# PPA Comparison — Baseline vs Aggressive vs Pipelined RTL

Three runs, same Sky130A PDK and LibreLane 2.4.2 flow.

| Variant | RTL | `CLOCK_PERIOD` | `PL_TARGET_DENSITY_PCT` |
|---|---|---|---|
| Baseline (`runs/wokwi`)    | original | 20 ns | 60 |
| Aggressive (`runs/aggressive`) | original | 10 ns | 80 |
| Pipelined (`runs/pipelined`)   | **CHECK-state pipelined** | ? ns | ? |

Smaller numbers are better for area/power/wirelength; larger numbers
are better for timing slack.

### Area

| Metric | Baseline | Aggressive | Pipelined |
|---|---|---|---|
| Std-cell area (µm²) | 41,906.4 | 42,620.9 | n/a |
| Total std cells | 5,896 | 5,934 | n/a |
| Sequential cells | 658 | 658 | n/a |

### Timing (TT 25 °C 1.80 V)

| Metric | Baseline | Aggressive | Pipelined |
|---|---|---|---|
| Setup WS (ns) | 11.228 | 1.949 | n/a |
| Setup violations | 0 | 1,571 | n/a |

### Timing (SS 100 °C 1.60 V — slow corner)

| Metric | Baseline | Aggressive | Pipelined |
|---|---|---|---|
| Setup WS (ns) | 2.331 | -5.468 | n/a |

### Power (TT 25 °C 1.80 V)

| Metric | Baseline | Aggressive | Pipelined |
|---|---|---|---|
| Total (mW) | 2.5969 | 5.0261 | n/a |

## Reading the table

- **Aggressive vs Baseline**: same RTL, just push the clock to 100 MHz.
  TT slack drops from +11.23 ns to +1.95 ns, SS slack flips negative
  (-5.47 ns) — the design fails sign-off at the slow corner.
- **Pipelined column**: scaffolding only. The RTL pipeline patch
  described in `design_notes.md` was prototyped and reverted before
  push (see that file for why), so `runs/pipelined/` does not exist
  yet and the column shows n/a. Once the patch is committed and CI
  produces `runs/pipelined/final/metrics.json`, re-running this
  script fills in the column — no other code change is needed.
