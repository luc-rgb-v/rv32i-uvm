`timescale 1ns / 1ps
module branch_jump_calculation (
    input  wire [31:0] pc_i,
    input  wire [31:0] rs_1_i,
    input  wire [31:0] imm_i,
    input  wire jalr_sig_i,
    output wire [31:0] pc_b_j_o
);

assign pc_b_j_o =
    jalr_sig_i ? ((rs_1_i + imm_i) & 32'hFFFFFFFE) :  // clear LSB for JALR
                 (pc_i + imm_i);                      // default

endmodule
