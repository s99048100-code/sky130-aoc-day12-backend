from __future__ import annotations
import json
import sys
from pathlib import Path

METRICS_PATH = Path("runs/wokwi/final/metrics.json")
OUT_PATH = Path("ppa_report.md")


def load_metrics(path: Path) -> dict:
    if not path.exists():
        raise FileNotFoundError(f"Cannot find {path}. Run OpenLane first.")
    return json.loads(path.read_text())


def fmt(value, unit: str = "", digits: int = 3) -> str:
    if isinstance(value, (int,)) and not isinstance(value, bool):
        return f"{value:,}{(' ' + unit) if unit else ''}"
    if isinstance(value, float):
        return f"{value:,.{digits}f}{(' ' + unit) if unit else ''}"
    return f"{value}{(' ' + unit) if unit else ''}"


def section(title: str, rows: list[tuple[str, str]]) -> str:
    out = [f"### {title}", "", "| Metric | Value |", "|---|---|"]
    for k, v in rows:
        out.append(f"| {k} | {v} |")
    out.append("")
    return "\n".join(out)


def build_report(m: dict) -> str:
    die_area_um2 = m["design__die__area"]
    core_area_um2 = m["design__core__area"]
    util = m["design__instance__utilization"] * 100
    cell_total = m["design__instance__count__stdcell"]
    seq_cells = m["design__instance__count__class:sequential_cell"]
    comb_cells = m["design__instance__count__class:multi_input_combinational_cell"]
    invs = m["design__instance__count__class:inverter"]
    bufs = m["design__instance__count__class:buffer"]
    tap_cells = m["design__instance__count__class:tap_cell"]
    fill_cells = m["design__instance__count__class:fill_cell"]
    cts_bufs = m["design__instance__count__class:clock_buffer"]
    cts_invs = m["design__instance__count__class:clock_inverter"]
    hold_bufs = m["design__instance__count__hold_buffer"]
    repair_bufs = m["design__instance__count__class:timing_repair_buffer"]
    diodes = m["design__instance__count__class:antenna_cell"]

    wl_route = m["route__wirelength"]
    wl_est = m["route__wirelength__estimated"]
    nets = m["route__net"]
    vias = m["route__vias"]
    drc_final = m["route__drc_errors"]

    p_int = m["power__internal__total"] * 1e3
    p_sw = m["power__switching__total"] * 1e3
    p_lk = m["power__leakage__total"] * 1e3
    p_total = m["power__total"] * 1e3

    setup_ws = m["timing__setup__ws__corner:nom_tt_025C_1v80"]
    hold_ws = m["timing__hold__ws__corner:nom_tt_025C_1v80"]
    setup_ws_ss = m["timing__setup__ws__corner:nom_ss_100C_1v60"]
    hold_ws_ss = m["timing__hold__ws__corner:nom_ss_100C_1v60"]

    drc_magic = m["magic__drc_error__count"]
    lvs_err = m["design__lvs_error__count"]
    ir_drop_worst = m["ir__drop__worst"] * 1e3

    bbox = m["design__die__bbox"]
    die_w_um, die_h_um = float(bbox.split()[2]), float(bbox.split()[3])

    return "\n".join([
        "# PPA Report — tt_um_range_finder",
        "",
        "Auto-generated from `runs/wokwi/final/metrics.json` (OpenLane / Sky130A).",
        "",
        section("Area", [
            ("Die bounding box", f"{die_w_um:.2f} x {die_h_um:.2f} um"),
            ("Die area", fmt(die_area_um2, "um^2", 0)),
            ("Core area", fmt(core_area_um2, "um^2", 0)),
            ("Standard-cell area", fmt(m["design__instance__area__stdcell"], "um^2", 1)),
            ("Core utilization", f"{util:.2f} %"),
            ("Tile footprint (info.yaml)", "4 x 2 (167x108 um per tile)"),
        ]),
        section("Cell Counts", [
            ("Total std cells", fmt(cell_total)),
            ("Sequential (FF/latch)", fmt(seq_cells)),
            ("Combinational (multi-input)", fmt(comb_cells)),
            ("Inverters", fmt(invs)),
            ("Buffers", fmt(bufs)),
            ("Hold-fix buffers", fmt(hold_bufs)),
            ("Timing-repair buffers", fmt(repair_bufs)),
            ("CTS buffers / inverters", f"{cts_bufs} / {cts_invs}"),
            ("Antenna diodes inserted", fmt(diodes)),
            ("Tap cells", fmt(tap_cells)),
            ("Fill cells", fmt(fill_cells)),
        ]),
        section("Routing", [
            ("Final wirelength", fmt(wl_route, "um", 0)),
            ("Estimated wirelength (post-GPL)", fmt(wl_est, "um", 1)),
            ("Total nets", fmt(nets)),
            ("Vias", fmt(vias)),
            ("DRC errors after detailed routing", fmt(drc_final)),
            ("Magic DRC errors", fmt(drc_magic)),
            ("LVS errors", fmt(lvs_err)),
        ]),
        section("Timing (10 MHz target, 100 ns period)", [
            ("Setup WS @ TT 25C 1.80V", f"{setup_ws:.3f} ns"),
            ("Hold  WS @ TT 25C 1.80V", f"{hold_ws:.3f} ns"),
            ("Setup WS @ SS 100C 1.60V (worst)", f"{setup_ws_ss:.3f} ns"),
            ("Hold  WS @ SS 100C 1.60V", f"{hold_ws_ss:.3f} ns"),
            ("Setup violations", fmt(m["timing__setup_vio__count"])),
            ("Hold violations", fmt(m["timing__hold_vio__count"])),
        ]),
        section("Power (TT 25C 1.80V)", [
            ("Internal", f"{p_int:.4f} mW"),
            ("Switching", f"{p_sw:.4f} mW"),
            ("Leakage", f"{p_lk:.6f} mW"),
            ("Total", f"{p_total:.4f} mW"),
            ("Worst IR drop", f"{ir_drop_worst:.4f} mV"),
        ]),
        section("Sign-off Checks", [
            ("Magic DRC", "PASS" if drc_magic == 0 else f"FAIL ({drc_magic})"),
            ("Routing DRC", "PASS" if drc_final == 0 else f"FAIL ({drc_final})"),
            ("Netgen LVS", "PASS" if lvs_err == 0 else f"FAIL ({lvs_err})"),
            ("Antenna violations (post-fix)", fmt(m["route__antenna_violation__count"])),
            ("Power-grid violations", fmt(m["design__power_grid_violation__count"])),
        ]),
    ])


def main(argv: list[str]) -> int:
    metrics = load_metrics(METRICS_PATH)
    report = build_report(metrics)
    OUT_PATH.write_text(report, encoding="utf-8")
    print(report)
    print(f"\n[written to {OUT_PATH}]")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
