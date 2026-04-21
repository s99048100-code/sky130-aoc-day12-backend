# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0
#
# 13-case regression suite mirroring REGRESSION_CASES in
# day12_golden_model.py. Each case is a separate @cocotb.test() so the
# JUnit results.xml reports per-case PASS/FAIL.

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge


REGRESSION_CASES = [
    # (W, H, counts,                    expected_solvable, max_cycles)
    (4,  4,  [1, 0, 0, 0, 0, 0],        1,  20000),
    (4,  4,  [1, 1, 0, 0, 0, 0],        0,  20000),
    (4,  4,  [1, 0, 1, 0, 0, 0],        0,  20000),
    (4,  4,  [1, 0, 0, 0, 1, 0],        0,  20000),
    (4,  4,  [0, 1, 0, 1, 0, 0],        0,  20000),
    (5,  5,  [2, 0, 0, 0, 0, 0],        0,  20000),
    (6,  5,  [2, 0, 0, 0, 0, 0],        0,  30000),
    (8,  4,  [1, 1, 0, 0, 0, 0],        1,  30000),
    (6,  6,  [1, 1, 0, 0, 0, 0],        0,  50000),
    (8,  8,  [1, 1, 1, 1, 1, 1],        1,  80000),
    (10, 10, [1, 1, 1, 1, 1, 1],        1, 100000),
    (8,  8,  [2, 2, 2, 2, 0, 0],        0,  80000),
    (12, 12, [2, 2, 2, 2, 2, 2],        1, 300000),
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


async def run_case(dut, w, h, counts, expected, max_cycles):
    cocotb.start_soon(Clock(dut.clk, 10, unit="us").start())
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
            raise RuntimeError(
                f"Solver did not produce result in {max_cycles} cycles "
                f"({w}x{h} counts={counts})"
            )

    result = int(dut.uo_out.value)
    dut._log.info(
        f"{w}x{h} counts={counts} expected={expected} got={result} cycles={cycles}"
    )
    assert result == expected, (
        f"{w}x{h} counts={counts}: expected {expected}, got {result}"
    )


def _make_test(idx, w, h, counts, expected, max_cycles):
    @cocotb.test(name=f"case_{idx:02d}_{w}x{h}_exp{expected}")
    async def _t(dut):
        await run_case(dut, w, h, counts, expected, max_cycles)
    return _t


for _idx, (_w, _h, _counts, _exp, _mc) in enumerate(REGRESSION_CASES):
    globals()[f"test_case_{_idx:02d}"] = _make_test(_idx, _w, _h, _counts, _exp, _mc)
