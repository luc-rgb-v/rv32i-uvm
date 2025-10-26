`timescale 1ns / 1ps
// alu_rv32i.v with unified branch flag and testbench

module alu_rv32i #(
  parameter XLEN = 32
) (
  input  wire [XLEN-1:0] a,
  input  wire [XLEN-1:0] b,
  input  wire [3:0]       alu_op,
  output wire [XLEN-1:0]  result,
  output wire             branch_taken
);

localparam ALU_ADD  = 4'b0000;
localparam ALU_SUB  = 4'b0001;
localparam ALU_SLL  = 4'b0010;
localparam ALU_SLT  = 4'b0011;
localparam ALU_SLTU = 4'b0100;
localparam ALU_XOR  = 4'b0101;
localparam ALU_SRL  = 4'b0110;
localparam ALU_SRA  = 4'b0111;
localparam ALU_OR   = 4'b1000;
localparam ALU_AND  = 4'b1001;

// branch ops
localparam ALU_BEQ  = 4'b1010;
localparam ALU_BNE  = 4'b1011;
localparam ALU_BLT  = 4'b1100;
localparam ALU_BGE  = 4'b1101;
localparam ALU_BLTU = 4'b1110;
localparam ALU_BGEU = 4'b1111;

// results
wire [XLEN-1:0] add_res  = a + b;
wire [XLEN-1:0] sub_res  = a - b;
wire [XLEN-1:0] sll_res  = a << b[4:0];
wire [XLEN-1:0] srl_res  = a >> b[4:0];
wire [XLEN-1:0] sra_res  = ($signed(a)) >>> b[4:0];
wire [XLEN-1:0] xor_res  = a ^ b;
wire [XLEN-1:0] or_res   = a | b;
wire [XLEN-1:0] and_res  = a & b;
wire [XLEN-1:0] slt_res  = ($signed(a) < $signed(b))  ? 32'd1 : 32'd0;
wire [XLEN-1:0] sltu_res = (a < b)                   ? 32'd1 : 32'd0;

// select result
assign result = (alu_op == ALU_ADD)  ? add_res  :
                (alu_op == ALU_SUB)  ? sub_res  :
                (alu_op == ALU_SLL)  ? sll_res  :
                (alu_op == ALU_SLT)  ? slt_res  :
                (alu_op == ALU_SLTU) ? sltu_res :
                (alu_op == ALU_XOR)  ? xor_res  :
                (alu_op == ALU_SRL)  ? srl_res  :
                (alu_op == ALU_SRA)  ? sra_res  :
                (alu_op == ALU_OR)   ? or_res   :
                (alu_op == ALU_AND)  ? and_res  :
                {XLEN{1'b0}};

// branch flag
assign branch_taken = (alu_op == ALU_BEQ)  ? (a == b) :
                      (alu_op == ALU_BNE)  ? (a != b) :
                      (alu_op == ALU_BLT)  ? ($signed(a) <  $signed(b)) :
                      (alu_op == ALU_BGE)  ? ($signed(a) >= $signed(b)) :
                      (alu_op == ALU_BLTU) ? (a < b) :
                      (alu_op == ALU_BGEU) ? (a >= b) :
                      1'b0;

endmodule
