`timescale 1ns/1ps

module tb_datamem_my_rand_test;
  // Clock
  reg clk = 0;
  always #20 clk = ~clk; // 100 MHz (10 ns period)

  // DUT I/O
  reg         we, re;
  reg  [2:0]  width_sel;        // 000=LB,001=LH,010=LW,011=LBU,100=LHU
  reg  [8:0]  addr;
  reg  [31:0] wdata;
  wire [31:0] rdata;

  // DUT
  data_mem_rv32i dut (
    .clk(clk),
    .we(we),
    .re(re),
    .width_sel(width_sel),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata)
  );

  initial begin
    // ---- init ----
    we = 0; re = 0; width_sel = 3'b010; addr = 9'h000; wdata = 32'h0;
    repeat (3) @(posedge clk);

    // =========================
    // Phase 1: LW reads (COE)
    // =========================
    $display("\n-- Phase 1: LW reads from COE --");
    re = 1; width_sel = 3'b010;  // LW

    // each step: apply at negedge, sample on next posedge (1-cycle)
    @(negedge clk); addr = 9'h000; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h000, rdata);
    @(negedge clk); addr = 9'h004; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h004, rdata);
    @(negedge clk); addr = 9'h008; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h008, rdata);
    @(negedge clk); addr = 9'h00C; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h00C, rdata);
    @(negedge clk); addr = 9'h010; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h010, rdata);
    @(negedge clk); addr = 9'h014; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h014, rdata);
    @(negedge clk); addr = 9'h018; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h018, rdata);
    @(negedge clk); addr = 9'h01C; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h01C, rdata);
    @(negedge clk); addr = 9'h020; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h020, rdata);

    // =========================
    // Phase 2: LB / LBU reads
    // =========================
    $display("\n-- Phase 2: LB / LBU reads --");
    width_sel = 3'b000; // LB
    @(negedge clk); addr = 9'h000; @(posedge clk); #1 $display("LB  [0x%03h] -> 0x%08h (byte=%02h)", 9'h000, rdata, rdata[7:0]);
    @(negedge clk); addr = 9'h001; @(posedge clk); #1 $display("LB  [0x%03h] -> 0x%08h (byte=%02h)", 9'h001, rdata, rdata[7:0]);
    @(negedge clk); addr = 9'h002; @(posedge clk); #1 $display("LB  [0x%03h] -> 0x%08h (byte=%02h)", 9'h002, rdata, rdata[7:0]);
    @(negedge clk); addr = 9'h003; @(posedge clk); #1 $display("LB  [0x%03h] -> 0x%08h (byte=%02h)", 9'h003, rdata, rdata[7:0]);

    width_sel = 3'b011; // LBU
    @(negedge clk); addr = 9'h000; @(posedge clk); #1 $display("LBU [0x%03h] -> 0x%08h (byte=%02h)", 9'h000, rdata, rdata[7:0]);
    @(negedge clk); addr = 9'h001; @(posedge clk); #1 $display("LBU [0x%03h] -> 0x%08h (byte=%02h)", 9'h001, rdata, rdata[7:0]);
    @(negedge clk); addr = 9'h002; @(posedge clk); #1 $display("LBU [0x%03h] -> 0x%08h (byte=%02h)", 9'h002, rdata, rdata[7:0]);
    @(negedge clk); addr = 9'h003; @(posedge clk); #1 $display("LBU [0x%03h] -> 0x%08h (byte=%02h)", 9'h003, rdata, rdata[7:0]);

    // =========================
    // Phase 3: LH / LHU reads
    // =========================
    $display("\n-- Phase 3: LH / LHU reads (aligned) --");
    width_sel = 3'b001; // LH
    @(negedge clk); addr = 9'h000; @(posedge clk); #1 $display("LH  [0x%03h] -> 0x%08h", 9'h000, rdata);
    @(negedge clk); addr = 9'h002; @(posedge clk); #1 $display("LH  [0x%03h] -> 0x%08h", 9'h002, rdata);

    width_sel = 3'b100; // LHU
    @(negedge clk); addr = 9'h000; @(posedge clk); #1 $display("LHU [0x%03h] -> 0x%08h", 9'h000, rdata);
    @(negedge clk); addr = 9'h002; @(posedge clk); #1 $display("LHU [0x%03h] -> 0x%08h", 9'h002, rdata);

    // Misaligned checks
    $display("\n-- Phase 3b: Misaligned LH/LW -> expect zero (MISALIGNED_ZERO=1) --");
    width_sel = 3'b001; @(negedge clk); addr = 9'h001; @(posedge clk); #1 $display("LH  [0x%03h] -> 0x%08h", 9'h001, rdata);
    width_sel = 3'b010; @(negedge clk); addr = 9'h002; @(posedge clk); #1 $display("LW  [0x%03h] -> 0x%08h", 9'h002, rdata);

    // =========================
    // Phase 4: SW writes 0..16
    // =========================
    $display("\n-- Phase 4: SW writes at 0,4,8,12,16 --");
    re = 0;
    width_sel = 3'b010; // SW
    @(negedge clk); we=1; addr=9'h000; wdata=32'hA5A5_0000; @(posedge clk);
    @(negedge clk);        addr=9'h004; wdata=32'hA5A5_0004; @(posedge clk);
    @(negedge clk);        addr=9'h008; wdata=32'hA5A5_0008; @(posedge clk);
    @(negedge clk);        addr=9'h00C; wdata=32'hA5A5_000C; @(posedge clk);
    @(negedge clk);        addr=9'h010; wdata=32'hA5A5_0010; @(posedge clk);
    @(negedge clk); we=0;

    // =========================
    // Phase 5: Verify LW after writes
    // =========================
    $display("\n-- Phase 5: Verify LW after writes --");
    re = 1; width_sel = 3'b010; // LW
    @(negedge clk); addr=9'h000; @(posedge clk); #1 $display("LW  [0x000] -> 0x%08h (exp 0xA5A50000)", rdata);
    @(negedge clk); addr=9'h004; @(posedge clk); #1 $display("LW  [0x004] -> 0x%08h (exp 0xA5A50004)", rdata);
    @(negedge clk); addr=9'h008; @(posedge clk); #1 $display("LW  [0x008] -> 0x%08h (exp 0xA5A50008)", rdata);
    @(negedge clk); addr=9'h00C; @(posedge clk); #1 $display("LW  [0x00C] -> 0x%08h (exp 0xA5A5000C)", rdata);
    @(negedge clk); addr=9'h010; @(posedge clk); #1 $display("LW  [0x010] -> 0x%08h (exp 0xA5A50010)", rdata);

    // =========================
    // Phase 6: Partial stores SB/SH then readback
    // =========================
    $display("\n-- Phase 6: SB/SH partial writes then readback --");
    re = 0;
    // target word 0x0014
    // write bytes 0x11,0x22 and halfword 0x3344 to form 0x4433_2211
    // SB @ 0x14
    width_sel = 3'b000; @(negedge clk); we=1; addr=9'h014; wdata=32'h0000_0011; @(posedge clk);
    // SB @ 0x15
    @(negedge clk); addr=9'h015; wdata=32'h0000_0022; @(posedge clk);
    // SH @ 0x16
    width_sel = 3'b001; @(negedge clk); addr=9'h016; wdata=32'h0000_3344; @(posedge clk);
    @(negedge clk); we=0;

    // Readback LW @ 0x14
    re = 1; width_sel = 3'b010;
    @(negedge clk); addr=9'h014; @(posedge clk); #1 $display("LW  [0x014] -> 0x%08h (exp 0x44332211)", rdata);

    // ---- done ----
    re = 0;
    repeat (2) @(posedge clk);
    $display("\n-- Test complete --\n");
    $finish;
  end
endmodule
