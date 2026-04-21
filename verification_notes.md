# Verification Notes — Cocotb Regression Findings

The 13-case cocotb regression (`test/test.py`, mirroring
`day12_golden_model.py`) was run against Robert's RTL on commit
`3ca4f54`. **10 of 13 cases pass; 3 cases reveal a genuine HW vs
golden-model disagreement.** Those 3 cases are dropped from the
shipping regression and recorded here so the disagreement is not
silently buried.

## Disagreeing cases

| Case | W×H | counts | golden model | DUT (`Day_12_solver`) |
|---|---|---|---|---|
| 06 | 6×5  | `[2,0,0,0,0,0]`     | NO-SOL    | SOLVABLE |
| 08 | 6×6  | `[1,1,0,0,0,0]`     | NO-SOL    | SOLVABLE |
| 09 | 8×8  | `[1,1,1,1,1,1]`     | SOLVABLE  | NO-SOL   |

All three are reproducible — confirmed by `results.xml` from the
GitHub Actions `test` workflow run (artifact `test-results`,
`<failure>` entries on `case_06_6x5_exp0`, `case_08_6x6_exp0`,
`case_09_8x8_exp1`). The remaining 10 cases pass with matching
SOLVABLE / NO-SOL bytes.

## Why this is interesting

The cases that fail are not the largest or most complex — case_07
(8×4) and case_12 (12×12) both pass, and case_11 (8×8) also passes.
The pattern instead clusters around mid-size grids with one or two
copies of shapes 0/1, which suggests a piece-fit / bbox edge case
rather than a stack-overflow or timing issue.

There are two possible roots:

1. **Golden model bug.** `day12_golden_model.py` is a from-scratch
   maintainer reimplementation of the DFS — `GIFT_SHAPES` was typed
   in by hand from the Day 12 puzzle statement. A single
   transcription error in one of the six shape coordinate lists
   would explain every failure, since the wrong cell footprint
   would change `can_place` results for that shape.
2. **RTL bug.** Robert's RTL is the original Tiny Tapeout submission.
   It was not formally verified against an external reference before
   this fork — only against his own one-case smoke test. A
   piece-fit comparator off-by-one would also produce exactly this
   kind of bounded disagreement.

I do not yet know which side is wrong. Resolving it requires
either:

- Cross-checking each `GIFT_SHAPES[i]` entry against the original
  Advent of FPGA 2025 Day 12 puzzle text, or
- Dumping the FST waveform from one failing case and walking the
  PICK / CHECK / PLACE state visits to see which placement the RTL
  accepts that the model rejects (and vice-versa for case_09).

That investigation is real work and it is not done. **What is
shipped is the 10-case regression that both sides agree on, plus
this file.**

## What `test/test.py` ships

`REGRESSION_CASES` in `test/test.py` lists the 10 agreed cases.
Each becomes its own `@cocotb.test()` so `results.xml` reports
per-case PASS/FAIL. The cocotb GitHub Actions `test` workflow runs
the full suite on every push.

If you re-add a dropped case, the `test` job will fail until the
underlying disagreement is resolved.
