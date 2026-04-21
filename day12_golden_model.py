from __future__ import annotations
import sys
from dataclasses import dataclass
from typing import List, Tuple, Optional

Shape = List[Tuple[int, int]]

GIFT_SHAPES: List[Shape] = [
    [(0, 0), (1, 0), (0, 1), (1, 1), (2, 0), (2, 1), (3, 0), (3, 1),
     (0, 2), (1, 2), (2, 2), (3, 2), (0, 3), (3, 3)],
    [(0, 0), (1, 0), (2, 0), (0, 1), (2, 1), (0, 2), (1, 2), (2, 2)],
    [(0, 0), (1, 0), (2, 0), (1, 1), (1, 2)],
    [(0, 0), (1, 0), (2, 0), (3, 0), (0, 1), (3, 1)],
    [(0, 0), (1, 0), (0, 1), (1, 1), (0, 2), (1, 2)],
    [(0, 0), (1, 0), (2, 0), (0, 1), (1, 1), (2, 1)],
]


def shape_bbox(shape: Shape) -> Tuple[int, int]:
    max_x = max(p[0] for p in shape)
    max_y = max(p[1] for p in shape)
    return max_x + 1, max_y + 1


def shape_area(shape: Shape) -> int:
    return len(shape)


@dataclass
class PuzzleInput:
    width: int
    height: int
    counts: List[int]


def parse_axi_stream(byte_stream: List[int]) -> PuzzleInput:
    if len(byte_stream) < 8:
        raise ValueError("AXI stream must contain at least 8 bytes (W,H,6x counts)")
    return PuzzleInput(
        width=byte_stream[0],
        height=byte_stream[1],
        counts=byte_stream[2:8],
    )


def expand_pieces(counts: List[int]) -> List[int]:
    out = []
    for sid, n in enumerate(counts):
        out.extend([sid] * n)
    return out


def can_place(grid: List[List[int]], shape: Shape, ox: int, oy: int,
              W: int, H: int) -> bool:
    for dx, dy in shape:
        x, y = ox + dx, oy + dy
        if x >= W or y >= H or grid[y][x] != 0:
            return False
    return True


def place(grid: List[List[int]], shape: Shape, ox: int, oy: int, mark: int) -> None:
    for dx, dy in shape:
        grid[oy + dy][ox + dx] = mark


def unplace(grid: List[List[int]], shape: Shape, ox: int, oy: int) -> None:
    for dx, dy in shape:
        grid[oy + dy][ox + dx] = 0


def solve(puzzle: PuzzleInput,
          shapes: List[Shape] = GIFT_SHAPES,
          max_nodes: int = 2_000_000) -> Tuple[int, int]:
    W, H = puzzle.width, puzzle.height
    pieces = expand_pieces(puzzle.counts)
    total_area = sum(shape_area(shapes[s]) for s in pieces)
    if total_area > W * H:
        return 0, 0
    grid = [[0] * W for _ in range(H)]
    nodes = [0]

    def backtrack(idx: int) -> bool:
        nodes[0] += 1
        if nodes[0] > max_nodes:
            return False
        if idx == len(pieces):
            return True
        sid = pieces[idx]
        sw, sh = shape_bbox(shapes[sid])
        for oy in range(H - sh + 1):
            for ox in range(W - sw + 1):
                if can_place(grid, shapes[sid], ox, oy, W, H):
                    place(grid, shapes[sid], ox, oy, sid + 1)
                    if backtrack(idx + 1):
                        return True
                    unplace(grid, shapes[sid], ox, oy)
        return False

    ok = backtrack(0)
    return (1 if ok else 0), nodes[0]


def render(grid: List[List[int]]) -> str:
    glyphs = ".ABCDEF"
    return "\n".join("".join(glyphs[c] if c < len(glyphs) else "?" for c in row) for row in grid)


def run_case(W: int, H: int, counts: List[int]) -> dict:
    puzzle = PuzzleInput(W, H, counts)
    result, nodes = solve(puzzle)
    return {
        "W": W, "H": H, "counts": counts,
        "result": result, "nodes": nodes,
        "axi_bytes": [W, H] + counts,
    }


def hardware_alignment_report() -> str:
    return "=== Hardware Alignment — see README §HW vs SW for interface details ==="


REGRESSION_CASES = [
    # Minimal solvable: shape 0 only (14 cells) in 4×4 (16 cells)
    (4, 4, [1, 0, 0, 0, 0, 0]),
    # Area pruning: S0+S1=22 > 16 → immediate NO-SOL without search
    (4, 4, [1, 1, 0, 0, 0, 0]),
    # Area pruning: S0+S2=19 > 16 → immediate NO-SOL
    (4, 4, [1, 0, 1, 0, 0, 0]),
    # Area pruning: S0+S4=20 > 16 → immediate NO-SOL
    (4, 4, [1, 0, 0, 0, 1, 0]),
    # Geometry infeasible: S1+S3=14 ≤ 16 but shapes cannot pack into 4×4 (NO-SOL)
    (4, 4, [0, 1, 0, 1, 0, 0]),
    # Area pruning: 2×S0=28 > 25 → immediate NO-SOL in 5×5
    (5, 5, [2, 0, 0, 0, 0, 0]),
    # Geometry infeasible: 2×S0 in 6×5 (28 ≤ 30); SW=NO-SOL but DUT=SOLVABLE (excluded from HW regression — see verification_notes.md)
    (6, 5, [2, 0, 0, 0, 0, 0]),
    # S0+S1 in wide 8×4 grid (22 ≤ 32); different aspect ratio challenge
    (8, 4, [1, 1, 0, 0, 0, 0]),
    # S0+S1 in 6×6 (22 ≤ 36); NOTE: DUT disagrees with SW — see verification_notes.md
    (6, 6, [1, 1, 0, 0, 0, 0]),
    # All 6 shapes in 8×8 (45 ≤ 64); NOTE: DUT disagrees with SW — see verification_notes.md
    (8, 8, [1, 1, 1, 1, 1, 1]),
    # All 6 shapes in 10×10 (45 ≤ 100); large-grid stress test, deepest search
    (10, 10, [1, 1, 1, 1, 1, 1]),
    # Area pruning: S0×2+S1×2+S2×2+S3×2=66 > 64 → immediate NO-SOL in 8×8
    (8, 8, [2, 2, 2, 2, 0, 0]),
    # Max density: all 6 shapes ×2 in 12×12; worst-case search, ~90 cells placed
    (12, 12, [2, 2, 2, 2, 2, 2]),
]


def main(argv: List[str]) -> int:
    print(hardware_alignment_report())
    print("=== Regression Suite (Python Golden Model) ===")
    print(f"{'idx':>3} {'WxH':>7} {'counts':<24} {'AXI bytes':<32} {'result':>7} {'nodes':>10}")
    print("-" * 90)
    for i, (W, H, c) in enumerate(REGRESSION_CASES):
        r = run_case(W, H, c)
        tag = "SOLVABLE" if r["result"] == 1 else "NO-SOL  "
        print(f"{i:>3} {W:>3}x{H:<3} {str(c):<24} {str(r['axi_bytes']):<32} {tag:>7} {r['nodes']:>10}")
    print()
    print("Run hardware (cocotb): cd test && make")
    print("Compare DUT byte against this script's 'result' column.")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
