`timescale 1ns/1ps

module tb_data_mem_rv32i;

  // ----------------- DUT I/O -----------------
  reg         clk;
  reg         we;
  reg         re;
  reg  [2:0]  width_sel;
  reg  [8:0]  addr;       // BYTE address (0..511)
  reg  [31:0] wdata;
  wire [31:0] rdata;

  // Instantiate DUT (512 bytes = 128 words), misaligned -> 0
  data_mem_rv32i #(
    .DEPTH_WORDS(128),
    .MISALIGNED_ZERO(1)
  ) dut (
    .clk(clk),
    .we(we),
    .re(re),
    .width_sel(width_sel),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata)
  );

  // ----------------- Clock -----------------
  initial clk = 0;
  always #5 clk = ~clk; // 100 MHz

  integer errors = 0, tests = 0;

  // ----------------- Helpers -----------------
  task step; begin @(posedge clk); #1; end endtask

  task check; input cond; input [1023:0] msg;
    begin
      tests = tests + 1;
      if (!cond) begin
        $display("[FAIL] %0s", msg);
        errors = errors + 1;
      end
    end
  endtask

  // width encodings
  localparam LB  = 3'b000;
  localparam LH  = 3'b001;
  localparam LW  = 3'b010;
  localparam LBU = 3'b011;
  localparam LHU = 3'b100;
  // stores reuse: SB=000, SH=001, SW=010

  task clear_ctrl;
    begin
      we = 0; re = 0; width_sel = LW; addr = 9'd0; wdata = 32'h0;
    end
  endtask

  // synchronous store (commit on next posedge)
  task store_byte;  input [8:0] a; input [7:0]  b;
    begin addr=a; width_sel=LB;  wdata={24'h0,b}; we=1; re=0; step(); we=0; end
  endtask
  task store_half;  input [8:0] a; input [15:0] h;
    begin addr=a; width_sel=LH;  wdata={16'h0,h}; we=1; re=0; step(); we=0; end
  endtask
  task store_word;  input [8:0] a; input [31:0] w;
    begin addr=a; width_sel=LW;  wdata=w;        we=1; re=0; step(); we=0; end
  endtask

  // async read (rdata visible immediately after addr+re+width change)
  task read_now; input [8:0] a; input [2:0] ws; output [31:0] out;
    begin
      addr = a; width_sel = ws; re = 1;
      #1; // async
      out = rdata;
      // leave re asserted only for this sample
      re = 0;
    end
  endtask

  // ----------------- Tests -----------------
  reg [31:0] val;

  // Some byte addresses within 0..511
  localparam A0 = 9'd64;   // word_idx=8, ofs=0
  localparam A0_o0 = A0 + 9'd0;
  localparam A0_o1 = A0 + 9'd1;
  localparam A0_o2 = A0 + 9'd2;
  localparam A0_o3 = A0 + 9'd3;

  localparam A1 = 9'd100;  // another word
  localparam A1_o0 = A1 + 9'd0;
  localparam A1_o1 = A1 + 9'd1;
  localparam A1_o2 = A1 + 9'd2;
  localparam A1_o3 = A1 + 9'd3;

  initial begin
    clear_ctrl();
    step(); // settle

    // -------- 1) Word store + LW / LB/LBU on each byte lane --------
    // Store word 0xA1B2C3D4 at A0 (ofs=0)
    store_word(A0_o0, 32'hA1B2C3D4);
    // LW @ ofs 0
    read_now(A0_o0, LW, val);
    check(val === 32'hA1B2C3D4, "LW returns full word");
    
    read_now(A0_o0, LB,  val); check(val === 32'hFFFFFFD4, "LB ofs0 -> D4 sign-extended");
    read_now(A0_o1, LB,  val); check(val === 32'hFFFFFFC3, "LB ofs1 -> C3 sign-extended");
    read_now(A0_o2, LB,  val); check(val === 32'hFFFFFFB2, "LB ofs2 -> B2 sign-extended");
    read_now(A0_o3, LB,  val); check(val === 32'hFFFFFFA1, "LB ofs3 -> A1 sign-extended");
    
    read_now(A0_o0, LBU, val); check(val === 32'h000000D4, "LBU ofs0 -> 00..D4");
    read_now(A0_o1, LBU, val); check(val === 32'h000000C3, "LBU ofs1 -> 00..C3");
    read_now(A0_o2, LBU, val); check(val === 32'h000000B2, "LBU ofs2 -> 00..B2");
    read_now(A0_o3, LBU, val); check(val === 32'h000000A1, "LBU ofs3 -> 00..A1");

    // -------- 2) Byte store into each offset, then read back --------
    store_word(A1_o0, 32'h00000000); // clear
    store_byte(A1_o0, 8'h80); // ofs0 = 0x80
    read_now(A1_o0, LBU, val); check(val === 32'h00000080, "SB ofs0 then LBU -> 0x80");
    read_now(A1_o0, LB,  val); check(val === 32'hFFFFFF80, "SB ofs0 then LB  -> sign-extend");

    store_byte(A1_o1, 8'h7F); // ofs1 = 0x7F
    read_now(A1_o1, LBU, val); check(val === 32'h0000007F, "SB ofs1 then LBU -> 0x7F");
    read_now(A1_o1, LB,  val); check(val === 32'h0000007F, "SB ofs1 then LB  -> 0x7F");

    store_byte(A1_o2, 8'hAA);
    read_now(A1_o2, LBU, val); check(val === 32'h000000AA, "SB ofs2 then LBU -> 0xAA");

    store_byte(A1_o3, 8'h55);
    read_now(A1_o3, LBU, val); check(val === 32'h00000055, "SB ofs3 then LBU -> 0x55");

    // After those SBs, assemble the word little-endian:
    // [31:24]=0x55, [23:16]=0xAA, [15:8]=0x7F, [7:0]=0x80  => 0x55AA7F80
    read_now(A1_o0, LW, val);
    check(val === 32'h55AA7F80, "Composite word after 4 SBs");

    // -------- 3) Halfword stores/loads (aligned & misaligned) --------
    // Aligned SH to low halfword (ofs=0)
    store_word(A0_o0, 32'h00000000);
    store_half(A0_o0, 16'h8001); // writes [15:0]
    read_now(A0_o0, LH,  val); check(val === 32'hFFFF8001, "LH aligned low half sign-extend");
    read_now(A0_o0, LHU, val); check(val === 32'h00008001, "LHU aligned low half zero-extend");

    // Aligned SH to high halfword (ofs=2)
    store_half(A0_o2, 16'h7FFF); // writes [31:16]
    // Reconstruct full word: high=7FFF, low=8001
    read_now(A0_o0, LW, val);
    check(val === 32'h7FFF8001, "Word after SH high(7FFF) + low(8001)");

    // Misaligned halfword read (ofs=1) -> expect 0 with MISALIGNED_ZERO=1
    read_now(A0_o1, LH,  val); check(val === 32'h00000000, "LH misaligned -> 0");
    read_now(A0_o1, LHU, val); check(val === 32'h00000000, "LHU misaligned -> 0");

    // -------- 4) Misaligned LW should return 0 (MISALIGNED_ZERO=1) --------
    read_now(A0_o1, LW, val); check(val === 32'h00000000, "LW misaligned ofs1 -> 0");
    read_now(A0_o2, LW, val); check(val === 32'h00000000, "LW misaligned ofs2 -> 0");
    read_now(A0_o3, LW, val); check(val === 32'h00000000, "LW misaligned ofs3 -> 0");

    // -------- 5) re=0 should force rdata=0 regardless of address --------
    addr = A0_o0; width_sel = LW; re = 0; #1;
    check(rdata === 32'h00000000, "re=0 => rdata=0");

    // Summary
    if (errors == 0)
      $display("---- All %0d tests PASSED ----", tests);
    else
      $display("---- %0d / %0d tests FAILED ----", errors, tests);

    $finish;
  end

endmodule
