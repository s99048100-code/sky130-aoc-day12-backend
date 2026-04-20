// Minimal functional stubs for sky130 buffer / delay cells that LibreLane's
// timing-repair pass inserts on the post-synth netlist. The liberty file's
// `function: "A"` is parsed as a blackbox by yosys, leaving no SAT model, which
// blocks equiv_induct from propagating AXI-output equivalences. Replacing the
// blackbox with an identity assign makes them transparent for formal.
//
// Safe: every cell listed here has `function: "A"` (pure buffer / delay) in
// the sky130_fd_sc_hd liberty file. Delay-only cells have identity logic.
`default_nettype none

module sky130_fd_sc_hd__buf_1  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__buf_2  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__buf_4  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__buf_6  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__buf_8  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__buf_12 (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__buf_16 (input A, output X); assign X = A; endmodule

module sky130_fd_sc_hd__clkbuf_1  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__clkbuf_2  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__clkbuf_4  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__clkbuf_8  (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__clkbuf_16 (input A, output X); assign X = A; endmodule

module sky130_fd_sc_hd__dlygate4sd1_1 (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__dlygate4sd2_1 (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__dlygate4sd3_1 (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__dlymetal6s2s_1 (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__dlymetal6s4s_1 (input A, output X); assign X = A; endmodule
module sky130_fd_sc_hd__dlymetal6s6s_1 (input A, output X); assign X = A; endmodule

// Positive-edge D flip-flop (no reset). Initial value 0 matches what
// `setundef -init -zero` forces on the gold side after memory_map, so
// equiv_induct sees a consistent base case on step 0.
module sky130_fd_sc_hd__dfxtp_1 (input D, CLK, output reg Q);
  initial Q = 1'b0;
  always @(posedge CLK) Q <= D;
endmodule
module sky130_fd_sc_hd__dfxtp_2 (input D, CLK, output reg Q);
  initial Q = 1'b0;
  always @(posedge CLK) Q <= D;
endmodule
module sky130_fd_sc_hd__dfxtp_4 (input D, CLK, output reg Q);
  initial Q = 1'b0;
  always @(posedge CLK) Q <= D;
endmodule

// Constant tie cells.
module sky130_fd_sc_hd__conb_1 (output HI, LO); assign HI = 1'b1; assign LO = 1'b0; endmodule
