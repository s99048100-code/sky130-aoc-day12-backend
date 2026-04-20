# PPA Report — tt_um_range_finder

Auto-generated from `runs/wokwi/final/metrics.json` (OpenLane / Sky130A).

### Area

| Metric | Value |
|---|---|
| Die bounding box | 682.64 x 225.76 um |
| Die area | 154,113 um^2 |
| Core area | 149,183 um^2 |
| Standard-cell area | 41,906.4 um^2 |
| Core utilization | 28.09 % |
| Tile footprint (info.yaml) | 4 x 2 (167x108 um per tile) |

### Cell Counts

| Metric | Value |
|---|---|
| Total std cells | 5,896 |
| Sequential (FF/latch) | 658 |
| Combinational (multi-input) | 2,106 |
| Inverters | 34 |
| Buffers | 4 |
| Hold-fix buffers | 508 |
| Timing-repair buffers | 844 |
| CTS buffers / inverters | 46 / 25 |
| Antenna diodes inserted | 21 |
| Tap cells | 2,158 |
| Fill cells | 10,794 |

### Routing

| Metric | Value |
|---|---|
| Final wirelength | 114,152 um |
| Estimated wirelength (post-GPL) | 94,287.9 um |
| Total nets | 3,705 |
| Vias | 28,233 |
| DRC errors after detailed routing | 0 |
| Magic DRC errors | 0 |
| LVS errors | 0 |

### Timing (10 MHz target, 100 ns period)

| Metric | Value |
|---|---|
| Setup WS @ TT 25C 1.80V | 11.228 ns |
| Hold  WS @ TT 25C 1.80V | 0.325 ns |
| Setup WS @ SS 100C 1.60V (worst) | 2.331 ns |
| Hold  WS @ SS 100C 1.60V | 0.881 ns |
| Setup violations | 0 |
| Hold violations | 0 |

### Power (TT 25C 1.80V)

| Metric | Value |
|---|---|
| Internal | 1.9212 mW |
| Switching | 0.6757 mW |
| Leakage | 0.000054 mW |
| Total | 2.5969 mW |
| Worst IR drop | 0.0820 mV |

### Sign-off Checks

| Metric | Value |
|---|---|
| Magic DRC | PASS |
| Routing DRC | PASS |
| Netgen LVS | PASS |
| Antenna violations (post-fix) | 3 |
| Power-grid violations | 0 |
