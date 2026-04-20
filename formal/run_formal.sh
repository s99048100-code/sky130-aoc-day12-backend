#!/usr/bin/env bash
# Run Yosys equivalence check inside the LibreLane Docker image.
# Proves: src/project.v (behavioral RTL) is logically equivalent to the
# sky130-mapped post-synth netlists produced by LibreLane.
#
# Usage: bash formal/run_formal.sh [baseline|aggressive|both]

set -euo pipefail

WHICH="${1:-both}"
REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
PDK_DIR="${PDK_DIR:-$HOME/.ciel/ciel/sky130/versions/0fe599b2afb6708d281543108caf8310912f54af/sky130A}"
IMG="${FORMAL_IMG:-ghcr.io/librelane/librelane:2.4.2}"

if [ ! -d "$PDK_DIR" ]; then
  echo "PDK not found at $PDK_DIR" >&2
  exit 1
fi

prep_one() {
  local tag="$1"
  local src
  case "$tag" in
    baseline)   src="$REPO_DIR/runs/wokwi/final/nl/tt_um_range_finder.nl.v" ;;
    aggressive) src="$REPO_DIR/runs/aggressive/final/nl/tt_um_range_finder.nl.v" ;;
  esac
  local dst="$REPO_DIR/formal/nl_${tag}_clean.v"
  python3 "$REPO_DIR/formal/strip_fillers.py" "$src" "$dst"
}

run_one() {
  local tag="$1"
  local script="formal/equiv_${tag}.ys"
  local log="formal/equiv_${tag}.log"
  echo "================================"
  echo "equiv ${tag} -> ${log}"
  echo "================================"
  docker run --rm \
    -v "$REPO_DIR:/work" \
    -v "$PDK_DIR:/pdk:ro" \
    -w /work \
    "$IMG" \
    bash -c "yosys -ql ${log} ${script}" \
    && echo "[PASS] ${tag}" \
    || { echo "[FAIL] ${tag}"; tail -40 "$REPO_DIR/${log}"; exit 1; }
}

case "$WHICH" in
  baseline)   prep_one baseline;   run_one baseline ;;
  aggressive) prep_one aggressive; run_one aggressive ;;
  both)       prep_one baseline;   run_one baseline
              prep_one aggressive; run_one aggressive ;;
  *) echo "usage: $0 [baseline|aggressive|both]"; exit 1 ;;
esac
