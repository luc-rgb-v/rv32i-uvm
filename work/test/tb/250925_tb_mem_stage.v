`timescale 1ns/1ps

module tb_data_mem_wrapped;

  // ---------------- DUT I/O ----------------
  reg         clk_i;
  reg         rst_i;
  reg         flush_i;
  reg         stall_i;

  // From EX
  reg         regwrite_i;
  reg  [4:0]  rd_addr_i;
  reg  [1:0]  memtoreg_i;
  reg  [31:0] pc_address_i;
  reg  [31:0] alu_result_i;

  // Data memory controls
  reg         write_en_i;
  reg         read_en_i;
  reg  [2:0]  width_sel_i;
  reg  [31:0] write_data_i;

  // To WB + raw read
  wire        regwrite_o;
  wire [4:0]  rd_addr_o;
  wire [1:0]  memtoreg_o;
  wire [31:0] pc_address_o;
  wire [31:0] alu_result_o;
  wire [31:0] data_mem_to_wb_o;  // registered load data
  wire [31:0] data_mem_o;        // raw async read

  // ------------- Instantiate DUT -------------
  data_mem_wrapped #(
    .DMEM_DEPTH_WORDS(128),       // 512 bytes
    .MISALIGNED_ZERO(1)
  ) dut (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .flush_i(flush_i),
    .stall_i(stall_i),

    .regwrite_i(regwrite_i),
    .rd_addr_i(rd_addr_i),
    .memtoreg_i(memtoreg_i),
    .pc_address_i(pc_address_i),
    .alu_result_i(alu_result_i),

    .write_en_i(write_en_i),
    .read_en_i(read_en_i),
    .width_sel_i(width_sel_i),
    .write_data_i(write_data_i),

    .regwrite_o(regwrite_o),
    .rd_addr_o(rd_addr_o),
    .memtoreg_o(memtoreg_o),
    .pc_address_o(pc_address_o),
    .alu_result_o(alu_result_o),
    .data_mem_to_wb_o(data_mem_to_wb_o),
    .data_mem_o(data_mem_o)
  );

  // ------------- Clock -------------
  initial clk_i = 0;
  always #5 clk_i = ~clk_i; // 100 MHz

  integer errors = 0, tests = 0;

  // ------------- Helpers -------------
  task step; begin @(posedge clk_i); #1; end endtask

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
  // stores reuse SB=000, SH=001, SW=010

  // memtoreg encodings
  localparam M2R_ALU = 2'b00;
  localparam M2R_MEM = 2'b01;
  localparam M2R_PC4 = 2'b10;

  // sign-extend 8 helper (portable)
  function [31:0] sext8; input [7:0] b; begin sext8 = {{24{b[7]}}, b}; end endfunction

  task clear_ctrl;
    begin
      flush_i = 0; stall_i = 0;
      regwrite_i = 0; rd_addr_i = 0; memtoreg_i = M2R_ALU;
      pc_address_i = 32'h0; alu_result_i = 32'h0;
      write_en_i = 0; read_en_i = 0; width_sel_i = LW; write_data_i = 32'h0;
    end
  endtask

  // Drive a BYTE address into memory via the MEM stage:
  // alu_result_i -> (step) -> alu_result_o -> data_mem.addr
  task set_addr; input [31:0] byte_addr;
    begin
      alu_result_i = byte_addr;
      step(); // now alu_result_o = byte_addr; memory sees addr
    end
  endtask

  // Synchronous stores (commit on posedge)
  task store_word; input [31:0] a; input [31:0] w;
    begin
      set_addr(a);
      width_sel_i = LW; write_data_i = w; write_en_i = 1; read_en_i = 0;
      step(); write_en_i = 0;
    end
  endtask

  task store_half; input [31:0] a; input [15:0] h;
    begin
      set_addr(a);
      width_sel_i = LH; write_data_i = {16'h0, h}; write_en_i = 1; read_en_i = 0;
      step(); write_en_i = 0;
    end
  endtask

  task store_byte; input [31:0] a; input [7:0] b;
    begin
      set_addr(a);
      width_sel_i = LB; write_data_i = {24'h0, b}; write_en_i = 1; read_en_i = 0;
      step(); write_en_i = 0;
    end
  endtask

  // Asynchronous read (raw) + registered WB capture
  task read_now; input [31:0] a; input [2:0] wsel; output [31:0] raw;
    begin
      set_addr(a);
      width_sel_i = wsel; read_en_i = 1;
      #1; raw = data_mem_o;   // async data now reflects addr
      step();                 // register into data_mem_to_wb_o
      read_en_i = 0;
    end
  endtask

  // ------------- Tests -------------
  reg [31:0] raw;

  // Byte addresses within 0..511 (wrapper uses addr[8:0])
  localparam A0   = 32'd64;   // word_idx=16, ofs=0
  localparam A0_o0 = A0 + 32'd0;
  localparam A0_o1 = A0 + 32'd1;
  localparam A0_o2 = A0 + 32'd2;
  localparam A0_o3 = A0 + 32'd3;

  localparam A1   = 32'd100;
  localparam A1_o0 = A1 + 32'd0;
  localparam A1_o1 = A1 + 32'd1;
  localparam A1_o2 = A1 + 32'd2;
  localparam A1_o3 = A1 + 32'd3;

  localparam A2   = 32'd120;

  initial begin
    // VCD (optional)
    // $dumpfile("tb_data_mem_wrapped.vcd");
    // $dumpvars(0, tb_data_mem_wrapped);

    // Reset
    rst_i = 1;
    clear_ctrl();
    step(); step();
    rst_i = 0; step();

    // ---- Basic pass-through controls (no stall/flush) ----
    regwrite_i = 1; rd_addr_i = 5'd7; memtoreg_i = M2R_PC4; pc_address_i = 32'h1234_5678;
    set_addr(32'hAB); // also advances one cycle
    check(regwrite_o==1 && rd_addr_o==5'd7 && memtoreg_o==M2R_PC4, "control pass-through");
    check(pc_address_o==32'h1234_5678, "pc pass-through");
    check(alu_result_o==32'hAB, "alu_result pass-through");

    // ---- Word store/load @ A0 ----
    store_word(A0_o0, 32'hA1B2C3D4);

    raw = 32'hx;
    read_now(A0_o0, LW, raw);
    check(raw === 32'hA1B2C3D4, "LW raw async = A1B2C3D4");
    check(data_mem_to_wb_o === 32'hA1B2C3D4, "LW registered WB = A1B2C3D4");

    // ---- Byte stores, then LB/LBU @ byte lanes ----
    store_byte(A1_o0, 8'h80);
    store_byte(A1_o1, 8'h7F);
    store_byte(A1_o2, 8'hAA);
    store_byte(A1_o3, 8'h55);

    read_now(A1_o0, LBU, raw); check(raw === 32'h00000080, "LBU ofs0 -> 0x80");
    read_now(A1_o1, LBU, raw); check(raw === 32'h0000007F, "LBU ofs1 -> 0x7F");
    read_now(A1_o2, LBU, raw); check(raw === 32'h000000AA, "LBU ofs2 -> 0xAA");
    read_now(A1_o3, LBU, raw); check(raw === 32'h00000055, "LBU ofs3 -> 0x55");

    read_now(A1_o0, LB, raw);  check(raw === 32'hFFFFFF80, "LB ofs0 sign-extend");
    read_now(A1_o1, LB, raw);  check(raw === 32'h0000007F, "LB ofs1 sign-extend(positive)");
    read_now(A1_o2, LB, raw);  check(raw === 32'hFFFFFFAA, "LB ofs2 sign-extend");
    read_now(A1_o3, LB, raw);  check(raw === 32'h00000055, "LB ofs3 sign-extend(positive)");

    // Composite word check: 0x55AA7F80
    read_now(A1_o0, LW, raw);
    check(raw === 32'h55AA7F80, "Composite word after 4 SBs");

    // ---- Halfword stores/loads (aligned & misaligned) ----
    store_word(A0_o0, 32'h00000000);
    store_half(A0_o0, 16'h8001); // low half
    read_now(A0_o0, LH,  raw); check(raw === 32'hFFFF8001, "LH low half sign-extend");
    read_now(A0_o0, LHU, raw); check(raw === 32'h00008001, "LHU low half zero-extend");

    store_half(A0_o2, 16'h7FFF); // high half
    read_now(A0_o0, LW,  raw);   check(raw === 32'h7FFF8001, "Word after SH high+low");

    // Misaligned LH/LHU/LW return 0 with MISALIGNED_ZERO=1
    read_now(A0_o1, LH,  raw); check(raw === 32'h00000000, "LH misaligned -> 0");
    read_now(A0_o1, LHU, raw); check(raw === 32'h00000000, "LHU misaligned -> 0");
    read_now(A0_o1, LW,  raw); check(raw === 32'h00000000, "LW misaligned ofs1 -> 0");

    // ---- memtoreg pass-through & stall/flush ----
    // Baseline WB value
    read_now(A0_o0, LW, raw); // WB now has 7FFF8001
    check(data_mem_to_wb_o === 32'h7FFF8001, "WB baseline before stall");

    // Change control, then stall and change address; outputs must hold
    regwrite_i = 1; rd_addr_i = 5'd9; memtoreg_i = M2R_MEM; pc_address_i = 32'hAAAA5555;
    stall_i = 1;
    set_addr(A2); width_sel_i = LW; read_en_i = 1;
    #1;
    check(data_mem_to_wb_o === 32'h7FFF8001, "stall holds WB data");
    step(); // still stalled
    check(regwrite_o==1 && rd_addr_o==5'd9 && memtoreg_o==M2R_MEM && pc_address_o==32'hAAAA5555,
          "stall holds control/pc");
    stall_i = 0; step();
    read_en_i = 0;

    // Flush: should clear registered outputs
    read_now(A1_o0, LW, raw); // set some known WB
    flush_i = 1; step(); flush_i = 0;
    check(data_mem_to_wb_o === 32'h00000000, "flush clears WB data");
    check(regwrite_o==1'b0 && rd_addr_o==5'b0 && memtoreg_o==2'b00 && pc_address_o==32'h00000000,
          "flush clears control/pc");

    // Summary
    if (errors == 0)
      $display("---- All %0d tests PASSED ----", tests);
    else
      $display("---- %0d / %0d tests FAILED ----", errors, tests);

    $finish;
  end

endmodule
