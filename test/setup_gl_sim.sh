#!/usr/bin/env bash
# Prepare gate_level_netlist.v for a local GATES=yes cocotb run.
# CI (tt-gds-action) copies the post-PnR netlist automatically; locally
# use the filler-stripped baseline netlist from formal/ as a stand-in.
#
# Usage:
#   bash test/setup_gl_sim.sh
#   PDK_ROOT=/path/to/sky130 make -C test GATES=yes

set -euo pipefail
REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SRC="$REPO/formal/nl_baseline_clean.v"
DST="$REPO/test/gate_level_netlist.v"

if [ ! -f "$SRC" ]; then
  echo "formal/nl_baseline_clean.v not found — run bash formal/run_formal.sh baseline first" >&2
  exit 1
fi

cp "$SRC" "$DST"
echo "Copied nl_baseline_clean.v -> test/gate_level_netlist.v"
echo ""
echo "Now run:"
echo "  PDK_ROOT=/path/to/sky130A-parent make -C test GATES=yes"
