`timescale 1ns/1ps

module tb_datamem_readonly;
  // Clock
  reg clk = 0;
  always #5 clk = ~clk; // 100 MHz

  // DUT I/O
  reg         we, re;
  reg  [2:0]  width_sel;        // 000=LB,001=LH,010=LW,011=LBU,100=LHU
  reg  [8:0]  addr;
  reg  [31:0] wdata;
  wire [31:0] rdata;

  // Instantiate your DUT (uses blk_mem_gen_1 inside)
  data_mem_rv32i dut (
    .clk(clk),
    .we(we),
    .re(re),
    .width_sel(width_sel),
    .addr(addr),
    .wdata(wdata),
    .rdata(rdata)
  );

  // ----------------------------
  // 1-cycle read helper
  // ----------------------------
  task do_read;
    input [2:0]  wsel;
    input [8:0]  a;
    output [31:0] d;
  begin
    @(negedge clk);
    we        = 1'b0;
    re        = 1'b1;
    width_sel = wsel;
    addr      = a;
    @(posedge clk);     // BRAM captures address
    #1 d = rdata;       // valid this cycle
    @(negedge clk);
    re = 1'b0;
  end
  endtask

  integer i;
  reg [31:0] d;

  initial begin
    // defaults
    we = 0; re = 0; width_sel = 3'b000; addr = 9'd0; wdata = 32'h0;

    // Small settle time
    repeat (3) @(posedge clk);

    // ----------------------------
    // LB reads 0..24
    // ----------------------------
    $display("---- LW reads [0..24] ----");
    for (i = 0; i <= 24; i = i + 4) begin
      do_read(3'b010, i[8:0], d); // LW
      $display("LW  [0x%03h] -> 0x%08h", i[8:0], d);
    end
    
    // ----------------------------
    // LH reads (aligned) 0..24 step 2
    // ----------------------------
    $display("---- LH/LHU reads [0..24 step 2] ----");
    for (i = 0; i <= 24; i = i + 2) begin
      do_read(3'b001, i[8:0], d); // LH
      $display("LH  [0x%03h] -> 0x%08h", i[8:0], d);
      do_read(3'b100, i[8:0], d); // LHU
      $display("LHU [0x%03h] -> 0x%08h", i[8:0], d);
    end

    // ----------------------------
    // LW reads (aligned) 0..32 step 4
    // ----------------------------
    $display("---- LW reads [0..32 step 4] ----");
    for (i = 0; i <= 32; i = i + 4) begin
      do_read(3'b010, i[8:0], d); // LW
      $display("LW  [0x%03h] -> 0x%08h", i[8:0], d);
    end

    $display("Read-only sweep complete.");
    $finish;
  end
endmodule
