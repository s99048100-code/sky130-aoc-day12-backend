"""Stress test with bigger grids to validate the algorithm."""
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge


async def send_word(dut, data):
    dut.ui_in.value = data
    dut.uio_in.value = 1
    await RisingEdge(dut.clk)
    timeout = 300
    while dut.uio_out.value[2] == 0:
        await RisingEdge(dut.clk)
        timeout -= 1
        if timeout == 0:
            raise RuntimeError(f"Timeout on s_tready, data={data}")
    dut.uio_in.value = 0
    await RisingEdge(dut.clk)


async def reset(dut):
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 3)


async def run_case(dut, w, h, gifts, max_cycles=500000):
    await reset(dut)
    await send_word(dut, w)
    await send_word(dut, h)
    for g in gifts:
        await send_word(dut, g)
    dut.uio_in.value = 2
    cycles = 0
    while dut.uio_out.value[3] == 0:
        await RisingEdge(dut.clk)
        cycles += 1
        if cycles > max_cycles:
            return None, cycles
    result = int(dut.uo_out.value)
    return result, cycles


@cocotb.test()
async def test_bigger_grids(dut):
    """Try bigger grids and many shape combos."""
    cocotb.start_soon(Clock(dut.clk, 10, unit="us").start())

    cases = [
        (4, 4, [1, 1, 0, 0, 0, 0], "baseline fails"),
        (6, 6, [1, 1, 0, 0, 0, 0], "6x6 = 36 cells, 2 gifts"),
        (8, 8, [1, 1, 0, 0, 0, 0], "8x8 = 64 cells, 2 gifts"),
        (8, 8, [1, 1, 1, 1, 1, 1], "8x8, one of each"),
        (10, 10, [1, 1, 1, 1, 1, 1], "10x10, one of each"),
        (15, 15, [1, 1, 1, 1, 1, 1], "15x15 huge"),
        (4, 4, [1, 0, 1, 0, 0, 0], "#0 + #2 on 4x4"),
        (4, 4, [1, 0, 0, 0, 1, 0], "#0 + #4 on 4x4"),
        (4, 4, [0, 1, 0, 1, 0, 0], "#1 + #3 on 4x4"),
        (5, 5, [2, 0, 0, 0, 0, 0], "2x#0 on 5x5"),
        (6, 5, [2, 0, 0, 0, 0, 0], "2x#0 on 6x5 = 30 cells"),
        (8, 4, [1, 1, 0, 0, 0, 0], "8x4=32 cells, #0+#1"),
        (8, 8, [2, 2, 2, 2, 0, 0], "8x8 dense"),
        (12, 12, [2, 2, 2, 2, 2, 2], "12x12, 2 of each"),
    ]

    results = []
    for w, h, gifts, label in cases:
        try:
            result, cycles = await run_case(dut, w, h, gifts, max_cycles=300000)
            results.append((w, h, tuple(gifts), label, result, cycles))
            tag = "TIMEOUT" if result is None else ("SOLVABLE" if result == 1 else f"r={result}")
            dut._log.info(f"[{w:2d}x{h:2d}] {list(gifts)} {label}: {tag} ({cycles} cyc)")
        except Exception as e:
            dut._log.warning(f"[{w}x{h}] {label}: FAIL {e}")
            results.append((w, h, tuple(gifts), label, "ERR", 0))

    dut._log.info("===== BIGGER-GRID SUMMARY =====")
    for w, h, g, label, r, c in results:
        rs = "✓ SOLVABLE" if r == 1 else ("✗ NO-SOLUTION" if r == 0 else ("⏱ TIMEOUT" if r is None else f"?? {r}"))
        dut._log.info(f"  {w:2d}x{h:<2d} {list(g)}  →  {rs:15s}  ({c:>6d} cyc)  [{label}]")
