"""Expanded test: try many gift-packing combinations on the DUT."""
import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge


async def send_word(dut, data):
    dut.ui_in.value = data
    dut.uio_in.value = 1  # s_tvalid high, m_tready low during input
    await RisingEdge(dut.clk)
    timeout = 200
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


async def run_case(dut, w, h, gifts, max_cycles=200000):
    await reset(dut)
    await send_word(dut, w)
    await send_word(dut, h)
    for g in gifts:
        await send_word(dut, g)
    dut.uio_in.value = 2  # m_tready high, wait for m_tvalid
    cycles = 0
    while dut.uio_out.value[3] == 0:
        await RisingEdge(dut.clk)
        cycles += 1
        if cycles > max_cycles:
            return None, cycles
    result = int(dut.uo_out.value)
    return result, cycles


@cocotb.test()
async def test_all_combos(dut):
    """Sweep many (grid_size, gift_count_vector) combinations."""
    cocotb.start_soon(Clock(dut.clk, 10, unit="us").start())

    # cases: (width, height, [c0..c5], label)
    cases = [
        (4, 4, [1, 0, 0, 0, 0, 0], "single gift #0"),
        (4, 4, [0, 1, 0, 0, 0, 0], "single gift #1"),
        (4, 4, [0, 0, 1, 0, 0, 0], "single gift #2"),
        (4, 4, [0, 0, 0, 1, 0, 0], "single gift #3"),
        (4, 4, [0, 0, 0, 0, 1, 0], "single gift #4"),
        (4, 4, [0, 0, 0, 0, 0, 1], "single gift #5"),
        (4, 4, [1, 1, 0, 0, 0, 0], "#0 + #1"),
        (4, 4, [2, 0, 0, 0, 0, 0], "two of #0"),
        (4, 4, [1, 1, 1, 0, 0, 0], "#0+#1+#2 trio"),
        (5, 5, [1, 1, 1, 1, 0, 0], "4 distinct gifts, 5x5"),
        (6, 4, [1, 1, 1, 1, 1, 1], "one of each, 6x4 = 24 cells"),
        (4, 4, [3, 0, 0, 0, 0, 0], "three of #0 (might overflow)"),
        (3, 3, [1, 0, 0, 0, 0, 0], "#0 on small 3x3"),
        (8, 4, [2, 2, 0, 0, 0, 0], "2x #0 + 2x #1 on 8x4"),
        (4, 4, [0, 0, 0, 0, 2, 0], "two of #4"),
        (5, 4, [1, 1, 0, 0, 1, 0], "mix on 5x4"),
    ]

    results = []
    for w, h, gifts, label in cases:
        try:
            result, cycles = await run_case(dut, w, h, gifts)
            status = "TIMEOUT" if result is None else "SOLVED" if result == 1 else f"r={result}"
            dut._log.info(f"[{w}x{h}] gifts={gifts} {label}: {status} ({cycles} cyc)")
            results.append((w, h, tuple(gifts), label, result, cycles))
        except Exception as e:
            dut._log.warning(f"[{w}x{h}] gifts={gifts} {label}: FAIL {e}")
            results.append((w, h, tuple(gifts), label, "ERR", 0))

    dut._log.info("===== SUMMARY =====")
    for w, h, g, label, r, c in results:
        rs = "✓ SOLVABLE" if r == 1 else ("✗ NO-SOLUTION" if r == 0 else f"?? {r}")
        dut._log.info(f"  {w}x{h:2d} {list(g)}  →  {rs:15s}  ({c:>6d} cycles)  [{label}]")
