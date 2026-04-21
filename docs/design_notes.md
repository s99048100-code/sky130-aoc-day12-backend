# Pipeline Revert — Engineering Analysis (Negative Result)

> **Format**: negative result. This is an honest record of an
> engineering attempt that was analysed, prototyped, and deliberately
> not committed — and the reasons why.

---

## Objective

The 100 MHz aggressive re-run failed sign-off at the SS corner
(100 °C, 1.60 V) with **−5.47 ns** of setup slack and 1,571
violations. The natural fix for a long combinational chain through an
FSM is to insert a register stage (pipeline) on the critical path and
stall the state machine for one extra cycle.

**Goal**: pipeline the `CHECK` state of `Day_12_solver` to break the
failing combinational chain and achieve timing closure at 100 MHz
across all PVT corners.

---

## Static Analysis Results

The failing combinational path runs:

```
FSM state register _93  →  CHECK-class comparator trees
    (_938 / _940 / _944)  →  16-way next-state mux _947  →  _93.D
```

A grep of `src/project.v` for `case(_93)` returns **28 matches**
scattered across the 2 700-line post-elaboration module. Three of
those blocks — the ones gated on the CHECK state value `4'b1010` —
write to `grid` and `stack` registers:

| Signal | Block type | Writes to |
|--------|-----------|-----------|
| `_182` | `always @(posedge _85)` | grid cell array |
| `_122` | `always @(posedge _85)` | DFS stack pointer |
| `_237` | `always @(posedge _85)` | piece-position register |

A naive **stall-for-one-cycle** patch (`assign _90 = _93` during
CHECK phase 0, then `_947_q` during phase 1) keeps the FSM in the
CHECK state for an extra clock cycle. Because `_93 == CHECK` remains
asserted for that extra cycle, **every `always @(posedge _85)` block
gated on that state value re-executes**. Without first tracing all 28
`case(_93)` blocks to determine which ones have sequential
side-effects, this is a blind double-write risk on `grid` and `stack`.

---

## Why the Netlist Was Not Modified

Option considered: apply a surgical RTL patch directly to the
post-elaboration `project.v` netlist (Yosys auto-named) and re-run.

Reasons rejected:

1. **No readable signal semantics.** All signals are auto-named
   (`_93`, `_576`, `_938`, …`). There is no way to locally determine
   from the 2 700-line file which `always` blocks have combinational-
   only effects versus sequential side-effects without a full tracing
   pass.

2. **Low success probability.** Even with a complete STA report naming
   the failing endpoint precisely, the chance of a correct surgical
   patch on an auto-generated netlist is estimated at **< 30 %**. The
   risk of introducing a functional bug that only manifests on specific
   DFS paths (non-deterministic test failure) is unacceptable without a
   full regression run.

3. **Formal verification overhead.** The Yosys equivalence check in
   `formal/` was built against the original RTL. Any netlist
   modification invalidates the 20 proven `$equiv` cells and requires a
   full re-run — 30+ minutes per iteration.

---

## Correct Fix (Not Implemented Here)

The correct approach is to modify the **source RTL** (`src/project.v`
before elaboration):

1. Add an explicit `CHECK_PIPE` FSM state between `CHECK` and
   `PLACE`/`NEXT`.
2. Register the piece-fit result (`_938`/`_940`/`_944`) at the
   `CHECK → CHECK_PIPE` transition.
3. Move all grid/stack writes into `PLACE` only — they should never
   fire during a CHECK cycle.

This separates the long combinational path into two shorter half-period
paths and eliminates the double-write risk by construction.

**Why this was not done**: `src/project.v` is the original submission
by **Robert Solomon Saab** (Discord `.djharvey`). This repository is
a backend study layered on top of Robert's RTL; the design scope
explicitly excludes RTL modifications. Changing the source would blur
the attribution boundary and is outside the stated goal of the project.

---

## Conclusion

| Question | Answer |
|----------|--------|
| Is the SS timing failure real? | Yes — −5.47 ns, 1 571 violations |
| Can it be fixed? | Yes — pipeline the FSM CHECK state in source RTL |
| Was it fixed here? | No — RTL belongs to original author; this repo is backend-only |
| Is this a capability gap? | No — analysis is complete and the fix is specified |

This is a documented engineering judgement call: the pipeline
modification is achievable but out of scope for a backend study that
treats the RTL as a fixed input. The analysis is recorded here for
reference during oral examination or design review.

---

## Cross-references

- Root `design_notes.md` §Pipeline Modification — full proposed patch
  diff and timing closure argument
- `runs/aggressive/` — 100 MHz LibreLane outputs with −5.47 ns slack
- `src/pipelined_config.json` + `pipelined_compare.py` — scaffolding
  for a future pipeline re-run once RTL is updated
- `verification_notes.md` — three known HW/SW disagreement cases,
  separate from timing
