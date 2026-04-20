"""Strip physical-only filler cells from a post-PnR netlist so Yosys can
read it without needing the sky130_ef fill/decap library. Fillers have no
functional ports — they do not affect logical equivalence."""
from __future__ import annotations
import re
import sys
from pathlib import Path

PATTERNS = [
    r"sky130_fd_sc_hd__decap",
    r"sky130_fd_sc_hd__fill",
    r"sky130_fd_sc_hd__tap",
    r"sky130_fd_sc_hd__diode",
    r"sky130_ef_sc_hd__",
]
LINE_RE = re.compile(r"^\s*(" + "|".join(PATTERNS) + r")")


def main(src: str, dst: str) -> int:
    kept = removed = 0
    with Path(src).open() as fi, Path(dst).open("w") as fo:
        for line in fi:
            if LINE_RE.match(line):
                removed += 1
                continue
            fo.write(line)
            kept += 1
    print(f"{src} -> {dst}: kept {kept} lines, removed {removed} filler-cell lines")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv[1], sys.argv[2]))
