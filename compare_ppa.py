from __future__ import annotations
import json
import sys
from pathlib import Path

BASE_PATH = Path("runs/wokwi/final/metrics.json")
NEW_PATH = Path("runs/aggressive/final/metrics.json")
RESOLVED_BASE = Path("runs/wokwi/resolved.json")
RESOLVED_NEW = Path("runs/aggressive/resolved.json")
OUT_PATH = Path("ppa_compare.md")


def load(p: Path) -> dict:
    if not p.exists():
        raise FileNotFoundError(p)
    return json.loads(p.read_text())


def fnum(v, digits=2, suf=""):
    if isinstance(v, bool):
        return str(v)
    if isinstance(v, int):
        return f"{v:,}{suf}"
    if isinstance(v, float):
        return f"{v:,.{digits}f}{suf}"
    return f"{v}{suf}"


def delta(new, base, digits=2, suf="", invert_good=False):
    if base == 0:
        return f"{fnum(new, digits, suf)} (n/a)"
    diff = new - base
    pct = (diff / base) * 100.0
    arrow = "▲" if diff > 0 else ("▼" if diff < 0 else "—")
    good = (diff < 0) ^ invert_good
    tag = " better" if (diff != 0 and good) else (" worse" if diff != 0 else "")
    return f"{fnum(new, digits, suf)} ({arrow} {pct:+.1f}%{tag})"


def row(label, base_v, new_v, digits=2, suf="", invert_good=False):
    return f"| {label} | {fnum(base_v, digits, suf)} | {delta(new_v, base_v, digits, suf, invert_good)} |"


def build(base, new, base_cfg, new_cfg) -> str:
    base_clk = base_cfg["CLOCK_PERIOD"]
    new_clk = new_cfg["CLOCK_PERIOD"]
    base_dens = base_cfg["PL_TARGET_DENSITY_PCT"]
    new_dens = new_cfg["PL_TARGET_DENSITY_PCT"]

    out = []
    out.append("# PPA Comparison — Robert's Config vs Aggressive Re-run")
    out.append("")
    out.append("Same RTL (`tt_um_range_finder`), same PDK (Sky130A), same flow")
    out.append("(LibreLane 2.4.2). Only the synthesis/PnR knobs differ.")
    out.append("")
    out.append("| Knob | Baseline (`runs/wokwi`) | Aggressive (`runs/aggressive`) |")
    out.append("|---|---|---|")
    out.append(f"| `CLOCK_PERIOD` | {base_clk} ns ({1000/base_clk:.0f} MHz) | {new_clk} ns ({1000/new_clk:.0f} MHz) |")
    out.append(f"| `PL_TARGET_DENSITY_PCT` | {base_dens} | {new_dens} |")
    out.append("")
    out.append("Smaller numbers are better for area/power/wirelength; larger numbers")
    out.append("are better for timing slack. Percentages are aggressive vs baseline.")
    out.append("")
    out.append("### Area")
    out.append("")
    out.append("| Metric | Baseline | Aggressive |")
    out.append("|---|---|---|")
    out.append(row("Std-cell area (µm²)", base["design__instance__area__stdcell"], new["design__instance__area__stdcell"], 1))
    out.append(row("Core utilization (%)", base["design__instance__utilization"]*100, new["design__instance__utilization"]*100, 2, invert_good=True))
    out.append(row("Total std cells", base["design__instance__count__stdcell"], new["design__instance__count__stdcell"], 0))
    out.append(row("Sequential cells", base["design__instance__count__class:sequential_cell"], new["design__instance__count__class:sequential_cell"], 0))
    out.append(row("Hold-fix buffers", base["design__instance__count__hold_buffer"], new["design__instance__count__hold_buffer"], 0))
    out.append(row("Timing-repair buffers", base["design__instance__count__class:timing_repair_buffer"], new["design__instance__count__class:timing_repair_buffer"], 0))
    out.append(row("CTS buffers", base["design__instance__count__class:clock_buffer"], new["design__instance__count__class:clock_buffer"], 0))
    out.append("")
    out.append("### Routing")
    out.append("")
    out.append("| Metric | Baseline | Aggressive |")
    out.append("|---|---|---|")
    out.append(row("Wirelength (µm)", base["route__wirelength"], new["route__wirelength"], 0))
    out.append(row("Nets", base["route__net"], new["route__net"], 0))
    out.append(row("Vias", base["route__vias"], new["route__vias"], 0))
    out.append(row("DRC errors", base["route__drc_errors"], new["route__drc_errors"], 0))
    out.append("")
    out.append("### Timing (TT 25 °C 1.80 V)")
    out.append("")
    out.append("| Metric | Baseline | Aggressive |")
    out.append("|---|---|---|")
    out.append(row("Setup WS (ns)", base["timing__setup__ws__corner:nom_tt_025C_1v80"], new["timing__setup__ws__corner:nom_tt_025C_1v80"], 3, invert_good=True))
    out.append(row("Hold WS (ns)", base["timing__hold__ws__corner:nom_tt_025C_1v80"], new["timing__hold__ws__corner:nom_tt_025C_1v80"], 3, invert_good=True))
    out.append(row("Setup violations", base["timing__setup_vio__count"], new["timing__setup_vio__count"], 0))
    out.append(row("Hold violations", base["timing__hold_vio__count"], new["timing__hold_vio__count"], 0))
    out.append("")
    out.append("### Timing (SS 100 °C 1.60 V — slow corner)")
    out.append("")
    out.append("| Metric | Baseline | Aggressive |")
    out.append("|---|---|---|")
    out.append(row("Setup WS (ns)", base["timing__setup__ws__corner:nom_ss_100C_1v60"], new["timing__setup__ws__corner:nom_ss_100C_1v60"], 3, invert_good=True))
    out.append(row("Hold WS (ns)", base["timing__hold__ws__corner:nom_ss_100C_1v60"], new["timing__hold__ws__corner:nom_ss_100C_1v60"], 3, invert_good=True))
    out.append("")
    out.append("### Power (TT 25 °C 1.80 V)")
    out.append("")
    out.append("| Metric | Baseline | Aggressive |")
    out.append("|---|---|---|")
    out.append(row("Total (mW)", base["power__total"]*1e3, new["power__total"]*1e3, 4))
    out.append(row("Internal (mW)", base["power__internal__total"]*1e3, new["power__internal__total"]*1e3, 4))
    out.append(row("Switching (mW)", base["power__switching__total"]*1e3, new["power__switching__total"]*1e3, 4))
    out.append(row("Leakage (mW)", base["power__leakage__total"]*1e3, new["power__leakage__total"]*1e3, 6))
    out.append("")
    out.append("### Sign-off")
    out.append("")
    out.append("| Check | Baseline | Aggressive |")
    out.append("|---|---|---|")
    out.append(f"| Magic DRC | {'PASS' if base['magic__drc_error__count']==0 else 'FAIL'} | {'PASS' if new['magic__drc_error__count']==0 else 'FAIL'} |")
    out.append(f"| Routing DRC | {'PASS' if base['route__drc_errors']==0 else 'FAIL'} | {'PASS' if new['route__drc_errors']==0 else 'FAIL'} |")
    out.append(f"| Netgen LVS | {'PASS' if base['design__lvs_error__count']==0 else 'FAIL'} | {'PASS' if new['design__lvs_error__count']==0 else 'FAIL'} |")
    out.append("")
    out.append("## Reading the table")
    out.append("")
    out.append("- The DIE area is identical because Tiny Tapeout fixes the tile size")
    out.append(f"  ({base_cfg.get('DIE_AREA','?')}). Std-cell area, wirelength, and CTS")
    out.append("  buffer count are what actually move with these knobs.")
    out.append(f"- Pushing the clock from {1000/base_clk:.0f} MHz to {1000/new_clk:.0f} MHz forces synthesis to")
    out.append("  pick larger drive strengths and the timing-repair pass to insert")
    out.append("  more buffers. If the aggressive setup slack is still positive, the")
    out.append("  RTL has more headroom than the baseline target suggested.")
    out.append(f"- Density {base_dens} → {new_dens} packs cells tighter, which usually trades")
    out.append("  area for routing congestion / wirelength.")
    out.append("")
    return "\n".join(out)


def main(argv):
    base = load(BASE_PATH)
    new = load(NEW_PATH)
    base_cfg = load(RESOLVED_BASE)
    new_cfg = load(RESOLVED_NEW)
    report = build(base, new, base_cfg, new_cfg)
    OUT_PATH.write_text(report, encoding="utf-8")
    print(report)
    print(f"\n[written to {OUT_PATH}]")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
