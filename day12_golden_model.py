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
    return (
        "=== Hardware Alignment ===\n"
        "Verilog DUT: tt_um_range_finder (top), Day_12_solver (core)\n"
        "Interface: AXI-Stream-like 8-bit byte channel\n"
        "  Input  bytes: [W, H, c0, c1, c2, c3, c4, c5]\n"
        "  Output byte : 1 = SOLVABLE, 0 = UNSOLVABLE\n"
        "Handshake:\n"
        "  ui[0]=s_tvalid, uio[0]=s_tready  (input  channel)\n"
        "  uio[1]=m_tvalid, ui[1]=m_tready, uio[2]=m_tlast (output channel)\n"
        "  ui[7:2] + ui[1:0] form s_tdata[7:0] (see info.yaml)\n"
        "Algorithm equivalence:\n"
        "  HW: hardware FSM emulates DFS via stack-unfolded backtracking\n"
        "  SW: this script runs the same DFS recursion in Python\n"
        "Verification flow:\n"
        "  1. Generate test vectors as byte sequences\n"
        "  2. Stream into Verilog DUT through cocotb (test/test.py)\n"
        "  3. Compare DUT output byte vs solve() return value\n"
        "  4. PASS iff hardware result == software result for all cases\n"
    )


REGRESSION_CASES = [
    (4, 4, [1, 0, 0, 0, 0, 0]),
    (4, 4, [1, 1, 0, 0, 0, 0]),
    (4, 4, [1, 0, 1, 0, 0, 0]),
    (4, 4, [1, 0, 0, 0, 1, 0]),
    (4, 4, [0, 1, 0, 1, 0, 0]),
    (5, 5, [2, 0, 0, 0, 0, 0]),
    (6, 5, [2, 0, 0, 0, 0, 0]),
    (8, 4, [1, 1, 0, 0, 0, 0]),
    (6, 6, [1, 1, 0, 0, 0, 0]),
    (8, 8, [1, 1, 1, 1, 1, 1]),
    (10, 10, [1, 1, 1, 1, 1, 1]),
    (8, 8, [2, 2, 2, 2, 0, 0]),
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
