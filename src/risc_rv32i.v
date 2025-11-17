`timescale 1ps / 1ps
module risc_rv32i (
  input  clk_i,
  input  rst_i,

  output wire [31:0] instr_addr_o,
  input  wire [31:0] instruction_i,
  output wire        imem_ena_o,

  input  wire        mem_memread_w,
  input  wire        bj_taken_i,
  input  wire [31:0] pc_bj_i,

  output wire [31:0] pc,
  output wire [31:0] ifid_pc,
  output wire [31:0] ifid_instruction
);

  // IF wires
  wire [31:0] if_pc_w;
  wire [31:0] if_pc_next_w;
  wire [31:0] if_pc_bj_w;
  wire        if_bj_taken_w;
  wire [31:0] pc_sub_w;

  // IF registers
  reg  [31:0] pc_r;
  reg  [31:0] ifid_pc_r;
  reg  [31:0] ifid_instruction_r;
  reg  [31:0] pc_sub_r;

  reg         valid_pc;
  reg         sup;
  reg         imem_ena_r;
  reg  [31:0] stall_instr;

  // Output assigns
  assign imem_ena_o       = imem_ena_r;
  assign if_bj_taken_w    = bj_taken_i;
  assign if_pc_bj_w       = pc_bj_i;

  assign pc               = pc_r;
  assign ifid_pc          = ifid_pc_r;
  assign ifid_instruction = ifid_instruction_r;
  assign pc_sub_w         = pc_sub_r;

  // IF combinational logic
  assign if_pc_w      = pc_r;
  assign instr_addr_o = if_pc_w;

  assign if_pc_next_w =
    if_bj_taken_w ? if_pc_bj_w : (if_pc_w + 32'h4);

  // Task
  task reset_if_stage;
    begin
      ifid_pc_r          <= 32'b0;
      ifid_instruction_r <= 32'b0;
    end
  endtask

  // PC register
  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i)
      pc_r <= 32'b0;
    else if (~mem_memread_w)
      pc_r <= if_pc_next_w;
  end

  // imem enable
  always @(*) begin
    if (if_bj_taken_w || mem_memread_w || rst_i)
      imem_ena_r = 1'b0;
    else
      imem_ena_r = 1'b1;
  end

  // valid_pc logic
  always @(posedge clk_i) begin
    if (rst_i || if_bj_taken_w)
      valid_pc <= 1'b0;
    else if (~mem_memread_w)
      valid_pc <= 1'b1;
  end

  // pc_sub register
  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i || if_bj_taken_w)
      pc_sub_r <= 32'b0;
    else if (~mem_memread_w)
      pc_sub_r <= if_pc_w;
  end

  // IF/ID register
  always @(posedge clk_i or posedge rst_i) begin
    if (rst_i || if_bj_taken_w) begin
      reset_if_stage();
    end else if (~mem_memread_w) begin
      ifid_instruction_r <= valid_pc ? instruction_i : 32'b0;
      ifid_pc_r          <= pc_sub_w;
    end
  end

endmodule
