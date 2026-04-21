# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0
#
# 13-case regression suite mirroring REGRESSION_CASES in
# day12_golden_model.py. Each (W, H, counts, expected) is run end-to-end
# through the AXI byte handshake and compared against the Python golden
# result. Test passes iff all 13 cases match.

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge


REGRESSION_CASES = [
    # (W, H, counts,                    expected_solvable)
    (4,  4,  [1, 0, 0, 0, 0, 0],        1),
    (4,  4,  [1, 1, 0, 0, 0, 0],        0),
    (4,  4,  [1, 0, 1, 0, 0, 0],        0),
    (4,  4,  [1, 0, 0, 0, 1, 0],        0),
    (4,  4,  [0, 1, 0, 1, 0, 0],        0),
    (5,  5,  [2, 0, 0, 0, 0, 0],        0),
    (6,  5,  [2, 0, 0, 0, 0, 0],        0),
    (8,  4,  [1, 1, 0, 0, 0, 0],        1),
    (6,  6,  [1, 1, 0, 0, 0, 0],        0),
    (8,  8,  [1, 1, 1, 1, 1, 1],        1),
    (10, 10, [1, 1, 1, 1, 1, 1],        1),
    (8,  8,  [2, 2, 2, 2, 0, 0],        0),
    (12, 12, [2, 2, 2, 2, 2, 2],        1),
]


async def send_word(dut, data):
    dut.ui_in.value = data
    dut.uio_in.value = 1  # s_tvalid
    await RisingEdge(dut.clk)
    timeout = 200
    while dut.uio_out.value[2] == 0:
        await RisingEdge(dut.clk)
        timeout -= 1
        if timeout == 0:
            raise RuntimeError(f"Timeout waiting for s_tready (data={data})")
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


async def run_case(dut, w, h, counts, max_cycles=200000):
    await reset(dut)
    await send_word(dut, w)
    await send_word(dut, h)
    for c in counts:
        await send_word(dut, c)
    dut.uio_in.value = 2  # m_tready high
    cycles = 0
    while dut.uio_out.value[3] == 0:
        await RisingEdge(dut.clk)
        cycles += 1
        if cycles > max_cycles:
            raise RuntimeError(f"Timeout: solver did not produce result in {max_cycles} cycles")
    return int(dut.uo_out.value), cycles


@cocotb.test()
async def test_regression_13(dut):
    """Run the full 13-case golden regression and assert HW == SW for all."""
    cocotb.start_soon(Clock(dut.clk, 10, unit="us").start())

    dut._log.info("=" * 60)
    dut._log.info("Day 12 Range Finder — 13-case cocotb regression")
    dut._log.info("=" * 60)

    results = []
    failures = []

    for idx, (w, h, counts, expected) in enumerate(REGRESSION_CASES):
        dut._log.info(f"[{idx:2d}] {w}x{h} counts={counts}  expected={expected}")
        result, cycles = await run_case(dut, w, h, counts)
        ok = (result == expected)
        tag = "PASS" if ok else "FAIL"
        dut._log.info(f"     -> got={result} cycles={cycles}  {tag}")
        results.append((idx, w, h, counts, expected, result, cycles, ok))
        if not ok:
            failures.append((idx, expected, result))

    dut._log.info("=" * 60)
    dut._log.info("SUMMARY")
    dut._log.info("=" * 60)
    for idx, w, h, counts, expected, result, cycles, ok in results:
        tag = "PASS" if ok else "FAIL"
        dut._log.info(
            f"  [{idx:2d}] {w:>2}x{h:<2} {str(counts):<22} "
            f"exp={expected} got={result} cyc={cycles:>6}  {tag}"
        )
    pass_count = sum(1 for r in results if r[7])
    dut._log.info(f"Total: {pass_count}/{len(results)} PASS")

    assert not failures, (
        f"{len(failures)} case(s) failed: "
        + ", ".join(f"#{i}(exp={e},got={g})" for i, e, g in failures)
    )
    dut._log.info("All 13 cases passed!")
