# Day 12 Range Finder — Backend Notes

Physical-design and sign-off study built on `tt_um_range_finder`, a Tiny
Tapeout (Sky130A) submission that solves Advent of Code 2025 Day 12 (2-D
gift packing via DFS backtracking).

The RTL (`src/project.v`, `tt_um_range_finder` / `Day_12_solver`) is by
Robert Solomon Saab (Discord `.djharvey`). The Verilog is left untouched.
What this repo adds is:

- a Python reference (`day12_golden_model.py`) that mirrors the AXI byte
  protocol and runs the same DFS,
- a small scraper (`extract_ppa.py`) that turns LibreLane's
  `metrics.json` into a markdown PPA table,
- a second LibreLane re-run at 100 MHz / 80 % density
  (`runs/aggressive/`) and a side-by-side PPA diff
  (`compare_ppa.py` → [`ppa_compare.md`](ppa_compare.md)) that shows
  what actually breaks when you push the clock,
- notes on the RTL → GDSII flow and the HW/SW equivalence argument.

## Algorithm

Eight bytes in over an AXI-Stream-like channel:

```
byte[0] = W            ; grid width
byte[1] = H            ; grid height
byte[2..7] = c0..c5    ; how many of gift shape #0..#5 to pack
```

One byte back: `1` if solvable, `0` otherwise.

The hardware flattens the recursion stack into an FSM. The Python model
runs the same algorithm as a plain recursive function. The two are
I/O-equivalent.

```mermaid
%%{init: {'theme':'dark', 'themeVariables': {'darkMode':true, 'background':'#000000', 'primaryColor':'#1e293b', 'primaryTextColor':'#f8fafc', 'primaryBorderColor':'#94a3b8', 'lineColor':'#cbd5e1', 'mainBkg':'#1e293b'}}}%%
stateDiagram-v2
    [*] --> RX
    RX --> INIT       : 8 bytes received
    INIT --> PICK
    PICK --> DONE_OK  : all pieces placed
    PICK --> TRY      : piece available
    TRY --> CHECK
    CHECK --> PLACE   : fits
    CHECK --> NEXT    : conflict
    PLACE --> PICK    : recurse
    NEXT --> TRY      : positions remain
    NEXT --> POP      : exhausted
    POP --> NEXT      : continue parent loop
    POP --> DONE_FAIL : stack empty
    DONE_OK   --> TX
    DONE_FAIL --> TX
    TX --> [*]
```

## HW vs SW

| Aspect    | Hardware (`Day_12_solver`)   | Software (`day12_golden_model.py`) |
|-----------|------------------------------|------------------------------------|
| Algorithm | FSM-emulated DFS             | Python recursion                   |
| State     | On-chip grid + piece pointer | 2-D list + recursion stack         |
| Input     | 8-byte AXI-Stream            | `parse_axi_stream([W,H,c0..c5])`   |
| Output    | one byte on `m_tdata`        | `solve()` returns `0` / `1`        |

```
python day12_golden_model.py
```

dumps the AXI byte sequence and expected DUT byte for every regression
case. Diff that against the cocotb logs in `test/`.

## Sign-off Numbers

Sky130A, LibreLane 2.4.2, 50 MHz target (`CLOCK_PERIOD=20`). Pulled
from `runs/wokwi/final/metrics.json` by `extract_ppa.py`; long version
is in [`ppa_report.md`](ppa_report.md).

| Class    | Metric                              | Value               |
|----------|-------------------------------------|---------------------|
| Area     | Die / Core                          | 154113 / 149183 µm² |
| Area     | Std-cell area                       | 41906 µm²           |
| Area     | Core utilization                    | 28.09 %             |
| Cells    | Total / FF / comb                   | 5896 / 658 / 2106   |
| Cells    | Hold-fix / CTS buf / inv            | 508 / 46 / 25       |
| Cells    | Antenna diodes                      | 21                  |
| Routing  | Final wirelength                    | 114152 µm           |
| Routing  | Nets / vias                         | 3705 / 28233        |
| Routing  | DRC errors                          | 0                   |
| Timing   | Setup WS @ TT 25 °C 1.80 V          | +11.23 ns           |
| Timing   | Hold  WS @ TT 25 °C 1.80 V          | +0.32 ns            |
| Timing   | Setup WS @ SS 100 °C 1.60 V         | +2.33 ns            |
| Power    | Total @ TT 25 °C                    | 2.60 mW             |
| Sign-off | Magic DRC / Netgen LVS              | PASS / PASS         |

All TT/SS/FF corners close with zero setup/hold violations after CTS and
post-route timing repair.

## Re-running the Flow at 100 MHz

The baseline targets 50 MHz and closes with +11.23 ns of setup slack at
TT — that is a lot of room left on the table. To see where this RTL
actually breaks, I re-ran the flow with two knobs changed:

| Knob | Baseline (`runs/wokwi`) | Aggressive (`runs/aggressive`) |
|------|-------------------------|--------------------------------|
| `CLOCK_PERIOD`         | 20 ns (50 MHz) | 10 ns (100 MHz) |
| `PL_TARGET_DENSITY_PCT`| 60             | 80              |

Both runs use the same RTL, the same Sky130A PDK, the same LibreLane
2.4.2 flow, and the same Tiny Tapeout 4×2 die. Headline numbers:

|              | Baseline (50 MHz) | Aggressive (100 MHz) |
|--------------|------------------:|---------------------:|
| Std-cell area    | 41,906 µm²    | 42,621 µm² (+1.7 %) |
| Wirelength       | 114,152 µm    | 126,073 µm (+10.4 %) |
| Setup WS @ TT    | +11.23 ns     | +1.95 ns             |
| Setup WS @ SS slow| +2.33 ns     | **−5.47 ns** (fail)  |
| Setup violations @ TT | 0        | **1,571**            |
| Total power @ TT | 2.60 mW       | 5.03 mW (+93 %)      |
| Magic / LVS      | PASS / PASS   | PASS / PASS          |

Reading the table: at the typical (TT) corner the design *almost*
holds 100 MHz — only 1.95 ns of setup margin and 1.5 k violations the
timing-repair pass couldn't kill. At the slow (SS, 100 °C, 1.60 V)
corner setup slack flips negative, so this would not actually tape out
at 100 MHz without RTL changes (pipeline the FSM, register the byte
interface). Power roughly doubles because every flop toggles twice as
often.

Full table with hold corners and per-buffer-class deltas in
[`ppa_compare.md`](ppa_compare.md). Reproduce with:

```
librelane --dockerized --run-tag aggressive src/aggressive_config.json
python compare_ppa.py
```

## Layout

KLayout streamout of the final GDS
(`runs/wokwi/final/klayout_gds/tt_um_range_finder.klayout.gds`).

![tt_um_range_finder — KLayout layout](docs/klayout_layout.png)

Same die dropped into the Caravel-style frame for context (pads, power
rings, the full 4×2 Tiny Tapeout tile footprint):

![tt_um_range_finder — Caravel-style context](docs/klayout_caravel_context.png)

A high-res render produced by the Tiny Tapeout flow lives at
[`gds_render.png`](gds_render.png).

### 3D model

The GDS is converted to glTF with [GDS2glTF] and viewed in a tiny static
server (`D:/aoc_tapeout/start_3d_viewer.bat` on my machine; opens
`http://localhost:8765/viewer_3d.html`). The `.gltf` is ~66 MB so it is
not committed; regenerate locally with:

```
python GDS2glTF/gds2gltf.py runs/wokwi/final/gds/tt_um_range_finder.gds
```

[GDS2glTF]: https://github.com/mbalestrini/GDS2glTF

## Repo Layout

```
src/                    RTL (Robert) — untouched
src/aggressive_config.json   100 MHz / 80 % density override
test/                   cocotb testbench
runs/wokwi/             baseline 50 MHz LibreLane outputs (keepers only)
runs/aggressive/        100 MHz re-run (same keepers, different knobs)
  flow.log
  resolved.json
  final/metrics.json
  final/metrics.csv
  final/gds/*.gds
  final/klayout_gds/*.gds
docs/                   KLayout screenshots
day12_golden_model.py   Python reference
extract_ppa.py          metrics.json → ppa_report.md
compare_ppa.py          baseline vs aggressive → ppa_compare.md
ppa_report.md
ppa_compare.md
info.yaml               Tiny Tapeout descriptor
```

Everything else under `runs/` (intermediate `def/`, `odb/`, `lef/`,
`spef/`, `mag/`, tar snapshots, `.venv*/`, Docker caches) is gitignored;
those are reproducible by re-running OpenLane.

## Reproducing

```
git clone <this-repo>
cd sky130-aoc-day12-backend
python day12_golden_model.py
cd test && make
cd .. && python extract_ppa.py
```

Re-running PnR needs the Sky130A PDK + Docker; see the
[Tiny Tapeout local-hardening guide](https://www.tinytapeout.com/guides/local-hardening/).

## License & Credits

- RTL and original Tiny Tapeout submission: © Robert Solomon Saab — see
  project `LICENSE`.
- Backend reports, golden model, and notes in this repo: same license.
- PDK: SkyWater 130 nm Open Source PDK (Apache-2.0).
- Flow: OpenLane / OpenROAD / Yosys / Magic / KLayout / Netgen.
