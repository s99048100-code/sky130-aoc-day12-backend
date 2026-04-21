"""Three-way PPA compare: baseline (50 MHz) vs aggressive (100 MHz, original RTL)
vs pipelined (100 MHz, FSM CHECK-state pipelined). Writes pipelined_compare.md.

Usage:
    python pipelined_compare.py
"""
from __future__ import annotations
import json
import sys
from pathlib import Path

BASE_PATH = Path("runs/wokwi/final/metrics.json")
AGG_PATH = Path("runs/aggressive/final/metrics.json")
PIPE_PATH = Path("runs/pipelined/final/metrics.json")
RESOLVED_BASE = Path("runs/wokwi/resolved.json")
RESOLVED_AGG = Path("runs/aggressive/resolved.json")
RESOLVED_PIPE = Path("runs/pipelined/resolved.json")
OUT_PATH = Path("pipelined_compare.md")


def load(p: Path) -> dict:
    if not p.exists():
        return {}
    return json.loads(p.read_text())


def fnum(v, digits=2, suf=""):
    if v is None:
        return "n/a"
    if isinstance(v, bool):
        return str(v)
    if isinstance(v, int):
        return f"{v:,}{suf}"
    if isinstance(v, float):
        return f"{v:,.{digits}f}{suf}"
    return f"{v}{suf}"


def get(d: dict, key: str):
    return d.get(key) if d else None


def row(label, base_v, agg_v, pipe_v, digits=2, suf=""):
    return (
        f"| {label} | {fnum(base_v, digits, suf)} | "
        f"{fnum(agg_v, digits, suf)} | {fnum(pipe_v, digits, suf)} |"
    )


def build(base, agg, pipe, base_cfg, agg_cfg, pipe_cfg) -> str:
    out = []
    out.append("# PPA Comparison — Baseline vs Aggressive vs Pipelined RTL")
    out.append("")
    out.append("Three runs, same Sky130A PDK and LibreLane 2.4.2 flow.")
    out.append("")
    out.append("| Variant | RTL | `CLOCK_PERIOD` | `PL_TARGET_DENSITY_PCT` |")
    out.append("|---|---|---|---|")
    out.append(f"| Baseline (`runs/wokwi`)    | original | {get(base_cfg,'CLOCK_PERIOD') or '?' } ns | {get(base_cfg,'PL_TARGET_DENSITY_PCT') or '?'} |")
    out.append(f"| Aggressive (`runs/aggressive`) | original | {get(agg_cfg,'CLOCK_PERIOD') or '?'} ns | {get(agg_cfg,'PL_TARGET_DENSITY_PCT') or '?'} |")
    out.append(f"| Pipelined (`runs/pipelined`)   | **CHECK-state pipelined** | {get(pipe_cfg,'CLOCK_PERIOD') or '?'} ns | {get(pipe_cfg,'PL_TARGET_DENSITY_PCT') or '?'} |")
    out.append("")
    out.append("Smaller numbers are better for area/power/wirelength; larger numbers")
    out.append("are better for timing slack.")
    out.append("")

    out.append("### Area")
    out.append("")
    out.append("| Metric | Baseline | Aggressive | Pipelined |")
    out.append("|---|---|---|---|")
    out.append(row("Std-cell area (µm²)",
                   get(base, "design__instance__area__stdcell"),
                   get(agg,  "design__instance__area__stdcell"),
                   get(pipe, "design__instance__area__stdcell"), 1))
    out.append(row("Total std cells",
                   get(base, "design__instance__count__stdcell"),
                   get(agg,  "design__instance__count__stdcell"),
                   get(pipe, "design__instance__count__stdcell"), 0))
    out.append(row("Sequential cells",
                   get(base, "design__instance__count__class:sequential_cell"),
                   get(agg,  "design__instance__count__class:sequential_cell"),
                   get(pipe, "design__instance__count__class:sequential_cell"), 0))
    out.append("")

    out.append("### Timing (TT 25 °C 1.80 V)")
    out.append("")
    out.append("| Metric | Baseline | Aggressive | Pipelined |")
    out.append("|---|---|---|---|")
    out.append(row("Setup WS (ns)",
                   get(base, "timing__setup__ws__corner:nom_tt_025C_1v80"),
                   get(agg,  "timing__setup__ws__corner:nom_tt_025C_1v80"),
                   get(pipe, "timing__setup__ws__corner:nom_tt_025C_1v80"), 3))
    out.append(row("Setup violations",
                   get(base, "timing__setup_vio__count"),
                   get(agg,  "timing__setup_vio__count"),
                   get(pipe, "timing__setup_vio__count"), 0))
    out.append("")

    out.append("### Timing (SS 100 °C 1.60 V — slow corner)")
    out.append("")
    out.append("| Metric | Baseline | Aggressive | Pipelined |")
    out.append("|---|---|---|---|")
    out.append(row("Setup WS (ns)",
                   get(base, "timing__setup__ws__corner:nom_ss_100C_1v60"),
                   get(agg,  "timing__setup__ws__corner:nom_ss_100C_1v60"),
                   get(pipe, "timing__setup__ws__corner:nom_ss_100C_1v60"), 3))
    out.append("")

    out.append("### Power (TT 25 °C 1.80 V)")
    out.append("")
    out.append("| Metric | Baseline | Aggressive | Pipelined |")
    out.append("|---|---|---|---|")
    def mw(v):
        return v * 1e3 if isinstance(v, (int, float)) else None
    out.append(row("Total (mW)",
                   mw(get(base, "power__total")),
                   mw(get(agg,  "power__total")),
                   mw(get(pipe, "power__total")), 4))
    out.append("")

    out.append("## Reading the table")
    out.append("")
    out.append("- **Aggressive vs Baseline**: same RTL, just push the clock to 100 MHz.")
    out.append("  TT slack drops from +11.23 ns to +1.95 ns, SS slack flips negative")
    out.append("  (-5.47 ns) — the design fails sign-off at the slow corner.")
    out.append("- **Pipelined column**: scaffolding only. The RTL pipeline patch")
    out.append("  described in `design_notes.md` was prototyped and reverted before")
    out.append("  push (see that file for why), so `runs/pipelined/` does not exist")
    out.append("  yet and the column shows n/a. Once the patch is committed and CI")
    out.append("  produces `runs/pipelined/final/metrics.json`, re-running this")
    out.append("  script fills in the column — no other code change is needed.")
    out.append("")
    return "\n".join(out)


def main(argv):
    base = load(BASE_PATH)
    agg = load(AGG_PATH)
    pipe = load(PIPE_PATH)
    base_cfg = load(RESOLVED_BASE)
    agg_cfg = load(RESOLVED_AGG)
    pipe_cfg = load(RESOLVED_PIPE)
    if not pipe:
        print(f"[warn] {PIPE_PATH} not found — pipelined column will show n/a.")
        print(f"       Run LibreLane with src/pipelined_config.json first.")
    report = build(base, agg, pipe, base_cfg, agg_cfg, pipe_cfg)
    OUT_PATH.write_text(report, encoding="utf-8")
    try:
        print(report)
    except UnicodeEncodeError:
        sys.stdout.buffer.write(report.encode("utf-8", errors="replace"))
    print(f"\n[written to {OUT_PATH}]")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
