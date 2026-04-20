"""
power_breakdown.py — compare 50 MHz vs 100 MHz power from LibreLane metrics.json.

Reads:
  runs/wokwi/final/metrics.json       (50 MHz baseline)
  runs/aggressive/final/metrics.json  (100 MHz re-run)

Outputs:
  docs/power_breakdown.png
  power_breakdown.md  (table, embedded in README Power Analysis section)
"""

import json
import pathlib
import sys

try:
    import matplotlib
    matplotlib.use("Agg")
    import matplotlib.pyplot as plt
    import matplotlib.patches as mpatches
    HAS_MPL = True
except ImportError:
    HAS_MPL = False
    print("matplotlib not installed — skipping chart, printing table only")

ROOT = pathlib.Path(__file__).parent

RUNS = {
    "50 MHz (baseline)": ROOT / "runs/wokwi/final/metrics.json",
    "100 MHz (aggressive)": ROOT / "runs/aggressive/final/metrics.json",
}

KEYS = {
    "internal":  "power__internal__total",
    "switching": "power__switching__total",
    "leakage":   "power__leakage__total",
}

def load(path):
    with open(path) as f:
        d = json.load(f)
    return {k: d[v] * 1000 for k, v in KEYS.items()}  # W → mW

data = {label: load(path) for label, path in RUNS.items()}

# ── text table ──────────────────────────────────────────────────────────────
print(f"\n{'Component':<14}", end="")
for label in data:
    print(f"  {label:>22}", end="")
print()
print("-" * (14 + 25 * len(data)))
for component in ("internal", "switching", "leakage"):
    print(f"{component:<14}", end="")
    for vals in data.values():
        print(f"  {vals[component]:>20.4f} mW", end="")
    print()
print("-" * (14 + 25 * len(data)))
print(f"{'total':<14}", end="")
for vals in data.values():
    print(f"  {sum(vals.values()):>20.4f} mW", end="")
print("\n")

# ── markdown table ───────────────────────────────────────────────────────────
md_lines = [
    "| Component | 50 MHz (baseline) | 100 MHz (aggressive) | Δ |",
    "|---|--:|--:|--:|",
]
labels = list(data.keys())
for component in ("internal", "switching", "leakage", "total"):
    if component == "total":
        a = sum(data[labels[0]].values())
        b = sum(data[labels[1]].values())
    else:
        a = data[labels[0]][component]
        b = data[labels[1]][component]
    delta = (b - a) / a * 100
    md_lines.append(f"| {component} | {a:.3f} mW | {b:.3f} mW | +{delta:.0f}% |")

md_text = "\n".join(md_lines)
(ROOT / "power_breakdown.md").write_text(md_text + "\n")
print("Wrote power_breakdown.md")

if not HAS_MPL:
    sys.exit(0)

# ── chart ────────────────────────────────────────────────────────────────────
fig, ax = plt.subplots(figsize=(7, 4.5))

colors = {"internal": "#4e79a7", "switching": "#f28e2b", "leakage": "#76b7b2"}
x = range(len(data))
bar_width = 0.5
bottoms = [0.0] * len(data)

for component in ("leakage", "switching", "internal"):  # bottom → top
    vals = [d[component] for d in data.values()]
    bars = ax.bar(x, vals, bar_width, bottom=bottoms,
                  color=colors[component], label=component.capitalize(),
                  edgecolor="white", linewidth=0.5)
    # annotate non-trivial segments
    for rect, v, bot in zip(bars, vals, bottoms):
        if v > 0.02:
            ax.text(rect.get_x() + rect.get_width() / 2,
                    bot + v / 2, f"{v:.2f}", ha="center", va="center",
                    fontsize=8.5, color="white", fontweight="bold")
    bottoms = [b + v for b, v in zip(bottoms, vals)]

# total annotation above each bar
for i, (label, vals) in enumerate(data.items()):
    total = sum(vals.values())
    ax.text(i, total + 0.04, f"{total:.2f} mW",
            ha="center", va="bottom", fontsize=9, fontweight="bold")

ax.set_xticks(list(x))
ax.set_xticklabels(list(data.keys()), fontsize=10)
ax.set_ylabel("Power (mW)", fontsize=10)
ax.set_title("tt_um_range_finder — Power Breakdown\nSky130A, LibreLane 2.4.2, TT 25 °C 1.80 V",
             fontsize=10)
ax.set_ylim(0, max(bottoms) * 1.18)
ax.spines[["top", "right"]].set_visible(False)
ax.legend(loc="upper left", fontsize=9)

plt.tight_layout()
out = ROOT / "docs/power_breakdown.png"
fig.savefig(out, dpi=150, bbox_inches="tight")
print(f"Wrote {out}")
