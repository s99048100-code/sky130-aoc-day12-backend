# PPA Comparison — Robert's Config vs Aggressive Re-run

Same RTL (`tt_um_range_finder`), same PDK (Sky130A), same flow
(LibreLane 2.4.2). Only the synthesis/PnR knobs differ.

| Knob | Baseline (`runs/wokwi`) | Aggressive (`runs/aggressive`) |
|---|---|---|
| `CLOCK_PERIOD` | 20 ns (50 MHz) | 10 ns (100 MHz) |
| `PL_TARGET_DENSITY_PCT` | 60 | 80 |

Smaller numbers are better for area/power/wirelength; larger numbers
are better for timing slack. Percentages are aggressive vs baseline.

### Area

| Metric | Baseline | Aggressive |
|---|---|---|
| Std-cell area (µm²) | 41,906.4 | 42,620.9 (▲ +1.7% worse) |
| Core utilization (%) | 28.09 | 28.57 (▲ +1.7% better) |
| Total std cells | 5,896 | 5,934 (▲ +0.6% worse) |
| Sequential cells | 658 | 658 (— +0.0%) |
| Hold-fix buffers | 508 | 508 (— +0.0%) |
| Timing-repair buffers | 844 | 883 (▲ +4.6% worse) |
| CTS buffers | 46 | 41 (▼ -10.9% better) |

### Routing

| Metric | Baseline | Aggressive |
|---|---|---|
| Wirelength (µm) | 114,152 | 126,073 (▲ +10.4% worse) |
| Nets | 3,705 | 3,742 (▲ +1.0% worse) |
| Vias | 28,233 | 30,331 (▲ +7.4% worse) |
| DRC errors | 0 | 0 (n/a) |

### Timing (TT 25 °C 1.80 V)

| Metric | Baseline | Aggressive |
|---|---|---|
| Setup WS (ns) | 11.228 | 1.949 (▼ -82.6% worse) |
| Hold WS (ns) | 0.325 | 0.334 (▲ +2.9% better) |
| Setup violations | 0 | 1,571 (n/a) |
| Hold violations | 0 | 0 (n/a) |

### Timing (SS 100 °C 1.60 V — slow corner)

| Metric | Baseline | Aggressive |
|---|---|---|
| Setup WS (ns) | 2.331 | -5.468 (▼ -334.6% worse) |
| Hold WS (ns) | 0.881 | 0.903 (▲ +2.4% better) |

### Power (TT 25 °C 1.80 V)

| Metric | Baseline | Aggressive |
|---|---|---|
| Total (mW) | 2.5969 | 5.0261 (▲ +93.5% worse) |
| Internal (mW) | 1.9212 | 3.7308 (▲ +94.2% worse) |
| Switching (mW) | 0.6757 | 1.2953 (▲ +91.7% worse) |
| Leakage (mW) | 0.000054 | 0.000054 (▲ +0.3% worse) |

### Sign-off

| Check | Baseline | Aggressive |
|---|---|---|
| Magic DRC | PASS | PASS |
| Routing DRC | PASS | PASS |
| Netgen LVS | PASS | PASS |

## Reading the table

- The DIE area is identical because Tiny Tapeout fixes the tile size
  ([0, 0, 682.64, 225.76]). Std-cell area, wirelength, and CTS
  buffer count are what actually move with these knobs.
- Pushing the clock from 50 MHz to 100 MHz forces synthesis to
  pick larger drive strengths and the timing-repair pass to insert
  more buffers. If the aggressive setup slack is still positive, the
  RTL has more headroom than the baseline target suggested.
- Density 60 → 80 packs cells tighter, which usually trades
  area for routing congestion / wirelength.
