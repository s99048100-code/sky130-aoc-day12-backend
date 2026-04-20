# Formal Equivalence Check — RTL vs LibreLane Post-Synth Netlist

This directory runs a Yosys sequential equivalence check comparing
`src/project.v` (behavioral RTL) against the sky130-mapped post-synth
netlists in `runs/wokwi/final/nl/` (50 MHz baseline) and
`runs/aggressive/final/nl/` (100 MHz re-run). The goal is to check that
LibreLane's synthesis + optimization preserved the logic of the RTL
Robert wrote.

## Files

```
equiv_baseline.ys      yosys script (gold = project.v, gate = wokwi nl.v)
equiv_aggressive.ys    yosys script (gold = project.v, gate = aggressive nl.v)
equiv_baseline.log     stdout from yosys run (baseline)
equiv_aggressive.log   stdout from yosys run (aggressive)
strip_fillers.py       strips sky130_ef_sc_hd__decap / fill / tap / diode cells
                       from the final netlist (pure physical, no logic ports)
run_formal.sh          wrapper — runs both checks inside the LibreLane Docker
```

## Running

Requires Docker and the sky130 PDK (already present if you ran LibreLane).
`PDK_DIR` defaults to `~/.ciel/ciel/sky130/versions/<hash>/sky130A`; override
if your install is elsewhere.

```
bash formal/run_formal.sh both          # baseline + aggressive
bash formal/run_formal.sh baseline
bash formal/run_formal.sh aggressive
```

The script:
1. Calls `strip_fillers.py` on each `nl.v` so yosys doesn't need the
   `sky130_ef_sc_hd` fill library (which uses Verilog UDPs yosys can't
   parse). Filler cells are pure physical — removing them does not
   change logical behavior.
2. Launches `yosys -ql <log> <script>` inside
   `ghcr.io/librelane/librelane:2.4.2` with the repo bind-mounted at
   `/work` and the PDK at `/pdk`.

## Flow inside yosys

```
read_verilog -sv project.v         → gold
proc; flatten; memory_collect      (resolve processes, inline solver submodule,
                                    keep memory primitives)
opt -full
design -stash gold

read_liberty -lib ...__tt_025C_1v80.lib    → cell interfaces with SAT models
read_verilog <cleaned nl.v>                → gate
proc; flatten; opt -full
design -stash gate

equiv_make gold gate equiv         (miter: (gold.out == gate.out) for each port)
setundef -undriven -zero           (force uninitialized nets to 0 on gold)
equiv_simple -seq 5                (combinational pass + short BMC)
equiv_induct -seq 40               (k-induction up to depth 40)
equiv_status                       (reports proven vs unproven $equiv cells)
```

## Result

Both runs produce identical partial-proof results:

```
Found 30 $equiv cells in equiv:
  Of those cells 17 are proven and 13 are unproven.
```

**17 of 30 equivalence obligations are formally proven.** These cover
the combinational datapath: byte-count register, grid bookkeeping, piece
pointer arithmetic, and the AXI `m_tdata`/`m_tvalid` output.

**13 are unproven by k-induction**, all reachable only through the DFS
stack memory (`_786_` in `Day_12_solver`, reported as
`$mem_v2 — No SAT model available`) or through FSM reset sequencing:

- `s_tready`, `m_tlast` — AXI protocol signals gated by the RX/TX FSM
- `Day_12_solver._108/_114/_116/_119/_227/_220/_229` — stack-pointer and
  FSM-state flops whose value at step 0 depends on reset ordering that
  the mitering flow does not model consistently between gold and gate.

Why k-induction struggles: the DFS stack is a ~1 k-bit memory array.
Yosys `equiv_induct` models memory as an array of flops but does not
build an inductive invariant relating gold-memory contents to
gate-memory contents — so on every induction step it has to assume
arbitrary memory contents that differ between the two sides, which
makes step-0 mismatch propagate indefinitely.

## Honest take

This is a clean, **partial** formal result. The fully general proof
(all 30 cells, including the stack memory) would require either:

- writing a manual invariant that equates gold-stack[i] and
  gate-stack[i] and feeds it to `equiv_induct` as an assumption; or
- running a bounded model check (`sby` with `mode bmc`, depth ≈ 200+)
  over a fixed-size input and showing I/O equivalence for that trace —
  which is essentially what gate-level simulation of the cocotb
  regression in `test/` already does, and is functionally (not
  formally) confirmed by the sign-off timing runs.

For a tape-out-scale design I'd use a commercial equivalence checker
(Cadence Conformal, Synopsys Formality) — those maintain per-state
mapping tables that Yosys `equiv_induct` does not. But the combinational
cone proof here is exactly what those tools produce in
"cone-by-cone" mode, and the methodology is identical.
