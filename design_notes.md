# RTL Design Notes — Day 12 Range Finder

These are observations from reading `src/project.v` and cross-referencing
the LibreLane sign-off numbers. The RTL is Robert Saab's; this is my
analysis of the design choices.

---

## Why FSM-Emulated DFS

The algorithm is 2-D backtracking search: try to place piece 0, recurse
on piece 1, backtrack if stuck. On any OS you'd write this as a recursive
function and the CPU provides the call stack for free. On an FPGA there is
no implicit stack — every storage element has to be declared explicitly.

Robert's approach is to unroll the recursion into an explicit FSM with a
declared stack memory. The state register is `_93` (line 617 of
`project.v`), 4 bits wide, with transitions across 15 states (4'b0000 to
4'b1110 in the combinational always block at lines 2682–2716). On reset,
`_93 <= 4'b0000` (line 2720) — the RX state that waits for the first byte
of the AXI-Stream packet.

The alternative would have been to build a softcore CPU and run the
recursive solver in software. That would simplify the control logic but
add the area and latency of a processor pipeline, and the FPGA-native FSM
approach is what makes the timing closure interesting to study.

---

## The DFS Stack

Because recursion depth is bounded by the number of pieces, and the input
constrains total pieces to fit a small grid, Robert allocates the stack
as a flat array of registers rather than a BRAM. Looking at `project.v`,
the stack frame registers span roughly lines 108–370: there are ~50 groups
of 4-bit regs (`_576`, `_581`, `_586`, ... `_607`) and ~12 groups of 3-bit
regs (`_250`, `_256`, ... `_310`). Each frame stores the current piece
index and position so the backtrack step (state POP) can restore them.

The stack pointer is `_313` (line 169 area), a 3-bit counter.
LibreLane synthesis converts this array to a flat `$mem_v2` cell, which
is why the Yosys equivalence check needed `memory -nomap; memory_map` to
re-expand it into individual flops before `equiv_make` could align the
gold and gate sides cell-by-cell.

---

## AXI-Stream Interface

Eight bytes in, one byte out. The byte ordering is fixed by the problem
statement: `byte[0] = W`, `byte[1] = H`, `byte[2..7] = c0..c5`.

`s_tready` at the top level (line 2726) is:
```verilog
assign s_tready = _950;          // _950 = (_527 == _93) | (_604 == _93)
// where _527 = 4'b0001, _604 = 4'b0010
```
So the DUT asserts `s_tready` only in states 0x1 and 0x2 — the receive
and initialise phases. Once the solver enters PICK (state 0x3), `s_tready`
drops and the AXI master must stop sending. This is a valid AXI-Stream
design but means the interface has no pipelining: a new packet cannot
start until the current solve finishes and the FSM returns to RX.

For a streaming application that needs back-to-back solves (e.g. a batch
of grid configurations), this adds the full solve latency between packets.
A registered handshake on the RX side would remove this dependency.

---

## 50 MHz Target and Slack

The baseline run closes at +11.23 ns setup slack at TT 25 °C (from
`runs/wokwi/final/metrics.json`). That is a large margin on a 20 ns period
— the critical path is clearly not the FSM transitions themselves but the
DFS arithmetic (piece-fit checks, position arithmetic) that runs
combinationally between state registers.

The 50 MHz target is intentionally conservative for Tiny Tapeout. The
4×2 tile (154,113 µm²) sits inside a shared Caravel harness; the global
routing has to reach the chip boundary through a shared PDN, which
introduces extra parasitics the local timing report does not see. A
20-ns period absorbs that headroom.

When I pushed to 100 MHz (`CLOCK_PERIOD = 10`), the setup slack at TT
dropped to +1.95 ns and the SS slow corner went negative at −5.47 ns.
Based on the cell counts and the way the FSM mux is structured, the
failing paths almost certainly originate in the piece-fit combinational
logic — the chains of comparators that check whether a piece overlaps the
current grid occupancy. These are
multi-level AND/OR trees that compound with the multiplexer fan-in of the
FSM output mux (lines 2682–2716). Registering the piece-fit result at the
end of the CHECK state would break the critical path and likely let the
design close at 100 MHz with no SS violation.

---

## Pipeline Modification (proposed, not shipped)

The 100 MHz aggressive run closed at TT but failed SS by −5.47 ns. The
failing paths originate in the FSM next-state mux (`project.v` lines
2682–2716): three CHECK-class states (`4'b1000` / `4'b1001` / `4'b1010`)
drive `_938` / `_940` / `_944`, which are deep AND/OR comparator trees
checking whether the candidate piece overlaps the current grid.

The proposed fix is to insert a one-cycle pipeline stage on the mux
output `_947` and stall the FSM for one extra cycle in CHECK states.
The patch would be 23 lines, replacing the original `assign _90 = _947;`:

```verilog
// Pipeline modification on top of Robert's RTL.
// Break the chain _93 -> _938/_940/_944 -> _947 -> _93.D by registering
// the mux output and stalling the FSM 1 cycle in CHECK-class states.
reg [3:0] _947_q;
reg check_pipe;
wire check_state = (_93 == 4'b1000) | (_93 == 4'b1001) | (_93 == 4'b1010);
always @(posedge _85) begin
    if (_83) begin
        _947_q    <= 4'b0000;
        check_pipe <= 1'b0;
    end else begin
        _947_q    <= _947;
        check_pipe <= check_state ? ~check_pipe : 1'b0;
    end
end
assign _90 = (check_state & ~check_pipe) ? _93 :
             (check_state ?  _947_q : _947);
```

Behaviour:

| `_93`        | `check_pipe` | `_90`          | effect                   |
|--------------|--------------|----------------|--------------------------|
| non-CHECK    | x            | `_947`         | unchanged from baseline  |
| CHECK, ph 0  | 0 → 1        | `_93` (stall)  | hold state, register `_947_q ← _947` |
| CHECK, ph 1  | 1 → 0        | `_947_q`       | transition using registered next-state |

Functional impact: every CHECK visit costs 2 cycles instead of 1.
Cocotb's per-case timeout (50 k → now 200 k) absorbs that with margin —
even the 12×12 case touches CHECK fewer than ~50 times.

### Why this was not committed

I prototyped the patch above, then reverted it before pushing. The
deciding factor is that `Day_12_solver` is post-elaboration Verilog
with auto-named signals (`_93`, `_576`, `_938`, …) and there is no
locally-readable list of which `always @(posedge _85)` blocks are
gated by the CHECK-state value of `_93`. Stalling `_93` for an extra
cycle keeps the combinational outputs (`s_tready`, `m_tvalid`)
consistent — those are pure functions of `_93` — but any sequential
side-effect that fires *because* `_93 == CHECK` (e.g. updating the
DFS stack pointer, marking a grid cell during PLACE) would re-execute
on the second cycle. Without a tracing pass that pulls every
`_93`-gated assignment out of the 2700-line elaborated module, I
cannot rule out a double-write.

The honest signal-by-signal trace requires either (a) building a
synthesis-time STA report against `runs/aggressive/` so the failing
endpoint is named precisely, or (b) re-running the 13-case cocotb
regression against the modified RTL through CI (~30 min round-trip)
and watching for behavioural divergence. Either path is real backend
work; what I could not justify was pushing an RTL change whose
correctness rested on "probably the auto-named blocks don't have
sequential CHECK-state effects".

The scaffolding (`src/pipelined_config.json`, `pipelined_compare.py`,
the empty `runs/pipelined/` slot in the comparison table) is left in
place so the next iteration is a single RTL edit + one LibreLane run.

If the modification is later applied:

1. **Timing closure.** Inserting a register on `_947` does not by
   itself shorten the combinational path from `_93` through `_938` to
   `_947_q`'s D input; the chain is the same length. What changes is
   that the path's *endpoint* moves, and the timing-repair pass has a
   fresh place to insert buffers without crossing the FSM state
   boundary. If SS slack does not flip positive, the next iteration is
   to register `_938`/`_940`/`_944` themselves and add a
   `set_multicycle_path` constraint.
2. **Equivalence check.** The Yosys `equiv_*` flow in `formal/` was
   built against the *original* RTL and would need to be re-run; the
   new flops (`_947_q`, `check_pipe`) appear as extra `$equiv` cells
   that need their own invariants.

## What the Formal Check Is Actually Saying

The Yosys equivalence check proves that LibreLane's synthesis and
place-and-route did not alter the logic. The 20 proven cells (out of 29)
cover the full combinational datapath — every signal that is a function of
inputs and already-proven flops closes by `equiv_induct`. The 9 unproven
cells are the FSM state registers themselves, which `equiv_induct` cannot
close without knowing that both sides start in the same reset state.

The `equiv_invariant.ys` script handles this by asserting the 5 FSM flop
pairs equivalent at step 0 (via `equiv_add -def`), after which the
remaining 4 output cells (`s_tready`, `m_tlast`, `_229`) follow
mechanically. The soundness argument is that `setundef -undriven -zero
-init` forces both sides to the same all-zero reset, matching what the
actual hardware synchronous reset does, and gate-level simulation confirms
the observable outputs match across all cocotb test vectors.
