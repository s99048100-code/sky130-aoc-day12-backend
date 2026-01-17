# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles, RisingEdge

async def send_word(dut, data):
    """
    Sends a single byte to the DUT using the AXI-Stream-like handshake.
    
    Protocol:
    1. Set Data (ui_in) and Valid (uio_in[0]).
    2. Wait until DUT asserts Ready (uio_out[2]).
    3. Deassert Valid.
    """
    dut.ui_in.value = data
    # Set s_tvalid high (bit 0 of uio_in)
    # Ensure m_tready (bit 1) remains 0 during input phase just to be clean, 
    # though strictly the DUT ignores it until output state.
    dut.uio_in.value = 1 

    # Wait for the rising edge to allow the DUT to sample inputs
    await RisingEdge(dut.clk)

    # Wait for s_tready (uio_out bit 2) to be high
    # We add a small timeout to prevent infinite loops if the state machine locks up
    timeout = 100
    while dut.uio_out.value[2] == 0:
        await RisingEdge(dut.clk)
        timeout -= 1
        if timeout == 0:
            raise RuntimeError(f"Timeout waiting for s_tready while sending data: {data}")

    # Data has been accepted. Deassert s_tvalid.
    dut.uio_in.value = 0
    
    # Wait one cycle to ensure the deassertion is registered
    await RisingEdge(dut.clk)


@cocotb.test()
async def test_project(dut):
    dut._log.info("Start Day 12 Solver Test")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, unit="us")
    cocotb.start_soon(clock.start())

    # --- Reset Sequence ---
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1
    await ClockCycles(dut.clk, 2)

    dut._log.info("Test Case 0: 4x4 Grid, Gift Counts: [1, 0, 0, 0, 0, 0]")

    # --- Input Phase ---
    # Sequence: Width, Height, then 6 bytes for gift counts
    
    # 1. Width = 4
    await send_word(dut, 4)
    
    # 2. Height = 4
    await send_word(dut, 4)
    
    # 3. Gift Counts: [1, 0, 0, 0, 0, 0]
    gift_counts = [1, 0, 0, 0, 0, 0]
    for count in gift_counts:
        await send_word(dut, count)

    dut._log.info("Configuration sent. Waiting for solver result...")

    # --- Processing Phase ---
    # Assert m_tready (uio_in bit 1) to indicate we are ready to receive the result.
    # uio_in = 2 (binary 00000010)
    dut.uio_in.value = 2

    # Wait for m_tvalid (uio_out bit 3) to go high.
    # The solver might take many cycles, so we use a generous timeout.
    max_cycles = 50000
    cycles = 0
    while dut.uio_out.value[3] == 0:
        await RisingEdge(dut.clk)
        cycles += 1
        if cycles > max_cycles:
            raise RuntimeError("Timeout: Solver did not produce a result within cycle limit.")

    # --- Verification ---
    # Result data is on uo_out (dedicated outputs)
    result = int(dut.uo_out.value)
    dut._log.info(f"Solver finished in {cycles} cycles. Result: {result}")

    # Check for Expected Result: 1 (Solvable)
    assert result == 1, f"Test Failed! Expected 1 (Solvable), but got {result}"
    
    dut._log.info("Test Passed!")
