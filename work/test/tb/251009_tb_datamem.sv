`timescale 1ns/1ps

// -----------------------------------------------------------------------------
// Simple sim model of Xilinx blk_mem_gen_1 (8-bit, single-port, sync R/W)
// Depth 128 (address 0..127). Read data available 1 cycle after address.
// -----------------------------------------------------------------------------
module blk_mem_gen_1 (
  input  wire        clka,
  input  wire        ena,
  input  wire [0:0]  wea,
  input  wire [10:0] addra,      // we use only [6:0]; upper bits ignored
  input  wire [7:0]  dina,
  output wire [7:0]  douta
);
  reg  [7:0] mem [0:127];
  reg  [7:0] q;
  wire [6:0] a = addra[6:0];

  // Optional init pattern for visibility
  integer i;
  initial begin
    for (i = 0; i < 128; i = i + 1) mem[i] = 8'h00;
  end

  always @(posedge clka) begin
    if (ena) begin
      q <= mem[a];                // synchronous read (old contents)
      if (wea[0]) mem[a] <= dina; // write on same edge
    end
  end
  assign douta = q;
endmodule

// -----------------------------------------------------------------------------
// DUT under test
// -----------------------------------------------------------------------------
module tb_data_mem_rv32i;
  // clk/reset
  reg clk = 0;
  always #5 clk = ~clk; // 100 MHz

  // DUT ports
  reg         we, re;
  reg  [2:0]  width_sel;
  reg  [8:0]  addr;
  reg  [31:0] wdata;
  wire [31:0] rdata;

  // Instantiate your memory (assumes you compiled your data_mem_rv32i)
  data_mem_rv32i dut (
    .clk   (clk),
    .we    (we),
    .re    (re),
    .width_sel(width_sel),
    .addr  (addr),
    .wdata (wdata),
    .rdata (rdata)
  );

  // ---------------------------------------------------------------------------
  // Helpers: 1-cycle protocol
  // ---------------------------------------------------------------------------
  task automatic do_read(
      input  [2:0]  wsel,
      input  [8:0]  a,
      output [31:0] d
  );
    begin
      @(negedge clk);
      re        = 1'b1;
      width_sel = wsel;
      addr      = a;
      @(posedge clk);   // BRAM captures address; output next cycle
      #1 d = rdata;     // valid within this cycle
      @(negedge clk);
      re = 1'b0;
    end
  endtask

  task automatic do_write_word( // SW, aligned
      input [8:0]  a,           // byte address, must be 4-byte aligned
      input [31:0] wd
  );
    begin
      @(negedge clk);
      we        = 1'b1;
      width_sel = 3'b010; // LW/SW width code
      addr      = a;
      wdata     = wd;
      @(posedge clk);     // write happens here
      @(negedge clk);
      we = 1'b0;
    end
  endtask

  // Byte/halfword stores if needed
  task automatic do_write_byte(
      input [8:0]  a,
      input [7:0]  b
  );
    begin
      @(negedge clk);
      we        = 1'b1;
      width_sel = 3'b000; // SB
      addr      = a;
      wdata     = {24'h0, b};
      @(posedge clk);
      @(negedge clk);
      we = 1'b0;
    end
  endtask

  task automatic do_write_half(
      input [8:0]  a, // must be halfword aligned
      input [15:0] h
  );
    begin
      @(negedge clk);
      we        = 1'b1;
      width_sel = 3'b001; // SH
      addr      = a;
      wdata     = {16'h0, h};
      @(posedge clk);
      @(negedge clk);
      we = 1'b0;
    end
  endtask

  // Expect helper for quick checks
  task automatic expect_eq_lw(
    input [31:0] got, input [31:0] exp, input integer addr
  );
    begin
      if (got !== exp) begin
        $display("[%0t] ERROR: LW [0x%03h] got=0x%08h exp=0x%08h",
                 $time, addr, got, exp);
        $fatal(1);
      end else begin
        $display("[%0t] PASS : LW [0x%03h] 0x%08h",
                 $time, addr, got);
      end
    end
  endtask
  
  // Up to 32 chars
  task expect_eq_msg;
      input [31:0] got, exp;
      input [8*32-1:0] msg;
    begin
      if (got !== exp) begin
        $display("[%0t] ERROR: %s got=0x%08h exp=0x%08h", $time, msg, got, exp);
        $fatal(1);
      end else begin
        $display("[%0t] PASS : %s 0x%08h", $time, msg, got);
      end
    end
  endtask
    
  // ---------------------------------------------------------------------------
  // Test sequence
  // ---------------------------------------------------------------------------
  integer i;
  reg [31:0] dword;
  reg [31:0] r;

  initial begin
    // defaults
    we = 0; re = 0; width_sel = 3'b000; addr = 9'd0; wdata = 32'h0;

    // 1) Read bytes at addresses 0..24 (LB)
    $display("---- Step 1: Initial LB reads [0..24] ----");
    for (i = 0; i <= 24; i = i + 1) begin
      reg [31:0] db;
      do_read(3'b000, i[8:0], db); // LB
      $display("LB [0x%03x] = 0x%02x (sign-extended 0x%08x)", i[8:0], db[7:0], db);
    end

    // 2) Write words to addresses 0,4,8,12,16
    $display("---- Step 2: SW writes at 0,4,8,12,16 ----");
    for (i = 0; i <= 16; i = i + 4) begin
      do_write_word(i[8:0], 32'hA5A50000 + i); // pattern
      $display("SW [0x%03x] <= 0x%08x", i, 32'hA5A50000 + i);
    end

    // 3) Verify word reads back
    $display("---- Step 3: LW verify ----");
    for (i = 0; i <= 16; i = i + 4) begin
      do_read(3'b010, i[8:0], dword); // LW
      expect_eq_lw(dword, 32'hA5A50000 + i, i);
    end

    // 4) Byte and halfword views on an example word at addr 0x000C
    $display("---- Step 4: LB/LBU/LH/LHU views at 0x00C ----");
    begin
      // LB at offsets 0..3
      for (i = 0; i < 4; i = i + 1) begin
        do_read(3'b000, ((12+i) & 9'h1FF), r); // LB
        $display("LB  [0x%03x] -> 0x%08x", 12+i, r);
        do_read(3'b011, ((12+i) & 9'h1FF), r); // LBU
        $display("LBU [0x%03x] -> 0x%08x", 12+i, r);
      end
      // LH aligned at 12 and 14
      do_read(3'b001, 9'd12, r); $display("LH  [0x00C] -> 0x%08x", r);
      do_read(3'b100, 9'd12, r); $display("LHU [0x00C] -> 0x%08x", r);
      do_read(3'b001, 9'd14, r); $display("LH  [0x00E] -> 0x%08x", r);
      do_read(3'b100, 9'd14, r); $display("LHU [0x00E] -> 0x%08x", r);

      // Misaligned halfword and word should zero (per MISALIGNED_ZERO=1)
      do_read(3'b001, 9'd13, r); $display("LH  [0x00D misaligned] -> 0x%08x (expect 0)", r);
      do_read(3'b010, 9'd2 , r); $display("LW  [0x002 misaligned] -> 0x%08x (expect 0)", r);
    end

    // 5) Partial writes test: SB then SH over an existing word
    $display("---- Step 5: Partial writes ----");
    // Start with word at 0x0010; currently 0xA5A50010
    do_write_byte(9'd16, 8'h11);    // byte lane 0
    do_write_byte(9'd17, 8'h22);    // lane 1
    do_write_half(9'd18, 16'h3344); // lanes 2,3
    do_read(3'b010, 9'd16, dword);  // LW 0x0010
    // Expect little-endian: [31:24]=44, [23:16]=33, [15:8]=22, [7:0]=11
    expect_eq_msg(dword, 32'h4433_2211, "After SB/SB/SH @0x10");

    $display("All tests completed.");
    $finish;
  end
endmodule
