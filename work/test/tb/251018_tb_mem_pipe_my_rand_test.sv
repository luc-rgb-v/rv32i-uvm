`timescale 1ns/1ps

module tb_mem_pipe_my_rand_test;
  // Clock
  reg clk = 0;
  always #5 clk = ~clk; // 100 MHz

  // Inputs to EX stage
  reg         we_i, re_i;
  reg  [2:0]  width_sel_i;   // 000=LB,001=LH,010=LW,011=LBU,100=LHU
  reg  [8:0]  addr_i;
  reg  [31:0] wdata_i;

  // Outputs at MEM/WB
  wire [31:0] rdata_o;
  wire        rvalid_o;

  // DUT
  rv32i_mem_pipe dut (
    .clk(clk),
    .we_i(we_i),
    .re_i(re_i),
    .width_sel_i(width_sel_i),
    .addr_i(addr_i),
    .wdata_i(wdata_i),
    .rdata_o(rdata_o),
    .rvalid_o(rvalid_o),
    .we_q_o(), .re_q_o(), .width_sel_q_o(), .addr_q_o(), .wdata_q_o()
  );

  initial begin
    // Init
    we_i = 0; re_i = 0; width_sel_i = 3'b010; addr_i = 9'h000; wdata_i = 32'h0;
    repeat (3) @(posedge clk);

    // =========================================================
    // Phase 1: LW reads from COE via pipeline (expect 1-cycle valid)
    // =========================================================
    $display("\n-- Phase 1: LW reads from COE --");
    width_sel_i = 3'b010; // LW

    // Pattern per read:
    // N  : drive re_i=1, addr_i=A
    // N+1: rvalid_o should be 1, rdata_o valid
    @(negedge clk); re_i=1; addr_i=9'h000;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x000] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h004;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x004] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h008;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x008] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h00C;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x00C] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h010;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x010] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h014;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x014] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h018;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x018] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h01C;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x01C] -> 0x%08h", rdata_o);

    @(negedge clk); addr_i=9'h020;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LW  [0x020] -> 0x%08h", rdata_o);

    // =========================================================
    // Phase 2: LB / LBU reads (first four bytes)
    // =========================================================
    $display("\n-- Phase 2: LB / LBU reads --");
    width_sel_i = 3'b000; // LB

    @(negedge clk); addr_i=9'h000;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LB  [0x000] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    @(negedge clk); addr_i=9'h001;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LB  [0x001] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    @(negedge clk); addr_i=9'h002;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LB  [0x002] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    @(negedge clk); addr_i=9'h003;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LB  [0x003] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    width_sel_i = 3'b011; // LBU

    @(negedge clk); addr_i=9'h000;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LBU [0x000] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    @(negedge clk); addr_i=9'h001;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LBU [0x001] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    @(negedge clk); addr_i=9'h002;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LBU [0x002] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    @(negedge clk); addr_i=9'h003;
    @(posedge clk);
    @(posedge clk); #1 if (rvalid_o) $display("LBU [0x003] -> 0x%08h (byte=%02h)", rdata_o, rdata_o[7:0]);

    // =========================================================
    // Phase 3: LH / LHU aligned and misaligned
    // =========================================================
    $display("\n-- Phase 3: LH / LHU --");
    width_sel_i = 3'b001; // LH
    @(negedge clk); addr_i=9'h000; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LH  [0x000] -> 0x%08h", rdata_o);
    @(negedge clk); addr_i=9'h002; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LH  [0x002] -> 0x%08h", rdata_o);

    width_sel_i = 3'b100; // LHU
    @(negedge clk); addr_i=9'h000; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LHU [0x000] -> 0x%08h", rdata_o);
    @(negedge clk); addr_i=9'h002; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LHU [0x002] -> 0x%08h", rdata_o);

    // Misaligned cases (expect zero with MISALIGNED_ZERO=1)
    $display("\n-- Phase 3b: Misaligned LH/LW (expect 0) --");
    width_sel_i = 3'b001; @(negedge clk); addr_i=9'h001; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LH  [0x001] -> 0x%08h", rdata_o);
    width_sel_i = 3'b010; @(negedge clk); addr_i=9'h002; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LW  [0x002] -> 0x%08h", rdata_o);

    // =========================================================
    // Phase 4: SW writes 0,4,8,12,16 through the pipe
    // =========================================================
    $display("\n-- Phase 4: SW writes at 0,4,8,12,16 --");
    re_i = 0;
    width_sel_i = 3'b010; // SW

    // Write protocol through pipe:
    // N  : set we_i=1, addr_i=A, wdata_i=D
    // N+1: EX/MEM holds; memory writes on this cycle (inside dmem)
    // N+2: safe to change signals
    @(negedge clk); we_i=1; addr_i=9'h000; wdata_i=32'hA5A5_0000;
    @(posedge clk); @(posedge clk);

    @(negedge clk);             addr_i=9'h004; wdata_i=32'hA5A5_0004;
    @(posedge clk); @(posedge clk);

    @(negedge clk);             addr_i=9'h008; wdata_i=32'hA5A5_0008;
    @(posedge clk); @(posedge clk);

    @(negedge clk);             addr_i=9'h00C; wdata_i=32'hA5A5_000C;
    @(posedge clk); @(posedge clk);

    @(negedge clk);             addr_i=9'h010; wdata_i=32'hA5A5_0010;
    @(posedge clk); @(posedge clk);

    @(negedge clk); we_i=0;

    // =========================================================
    // Phase 5: Verify LW after writes
    // =========================================================
    $display("\n-- Phase 5: Verify LW after writes --");
    re_i = 1; width_sel_i = 3'b010;

    @(negedge clk); addr_i=9'h000; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LW  [0x000] -> 0x%08h (exp 0xA5A50000)", rdata_o);
    @(negedge clk); addr_i=9'h004; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LW  [0x004] -> 0x%08h (exp 0xA5A50004)", rdata_o);
    @(negedge clk); addr_i=9'h008; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LW  [0x008] -> 0x%08h (exp 0xA5A50008)", rdata_o);
    @(negedge clk); addr_i=9'h00C; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LW  [0x00C] -> 0x%08h (exp 0xA5A5000C)", rdata_o);
    @(negedge clk); addr_i=9'h010; @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LW  [0x010] -> 0x%08h (exp 0xA5A50010)", rdata_o);

    // =========================================================
    // Phase 6: Partial stores SB/SB/SH -> readback 0x44332211
    // =========================================================
    $display("\n-- Phase 6: SB/SH partial writes then readback --");
    re_i = 0;

    // SB @ 0x14 = 0x11
    width_sel_i = 3'b000;
    @(negedge clk); we_i=1; addr_i=9'h014; wdata_i=32'h0000_0011;
    @(posedge clk); @(posedge clk);

    // SB @ 0x15 = 0x22
    @(negedge clk);           addr_i=9'h015; wdata_i=32'h0000_0022;
    @(posedge clk); @(posedge clk);

    // SH @ 0x16 = 0x3344
    width_sel_i = 3'b001;
    @(negedge clk);           addr_i=9'h016; wdata_i=32'h0000_3344;
    @(posedge clk); @(posedge clk);

    @(negedge clk); we_i=0;

    // Readback LW @ 0x14
    re_i = 1; width_sel_i = 3'b010;
    @(negedge clk); addr_i=9'h014;
    @(posedge clk); @(posedge clk); #1 if (rvalid_o) $display("LW  [0x014] -> 0x%08h (exp 0x44332211)", rdata_o);

    // Done
    re_i = 0;
    repeat (2) @(posedge clk);
    $display("\n-- Test complete --\n");
    $finish;
  end
endmodule
