`timescale 1ns / 1ps
//==============================================================
// Module: imm_decoder
// Function: Decode all RISC-V immediate types (I, S, B, J, U, SHAMT)
//==============================================================
module imm_decoder (
    input  wire [31:0] instruction_r,

    output wire [31:0] imm_i,
    output wire [31:0] imm_s,
    output wire [31:0] imm_b,
    output wire [31:0] imm_j,
    output wire [31:0] imm_u,
    output wire [31:0] shamt_imm
);

    // ----------------------------
    // Local opcode field decoding
    // ----------------------------
    wire [6:0] opcode = instruction_r[6:0];
    wire [2:0] funct3 = instruction_r[14:12];
    //wire [6:0] funct7 = instruction_r[31:25];

    // ----------------------------
    // Define opcode constants
    // ----------------------------
    localparam OPCODE_LUI      = 7'b0110111;
    localparam OPCODE_AUIPC    = 7'b0010111;
    localparam OPCODE_JAL      = 7'b1101111;
    localparam OPCODE_I_JALR   = 7'b1100111;
    localparam OPCODE_B        = 7'b1100011;
    localparam OPCODE_I_LOAD   = 7'b0000011;
    localparam OPCODE_S        = 7'b0100011;
    localparam OPCODE_I_ARITH  = 7'b0010011;

    // ----------------------------
    // Immediate types
    // ----------------------------
    // I-type (Load, JALR, Arithmetic except shifts)
    assign imm_i = (opcode == OPCODE_I_LOAD || opcode == OPCODE_I_JALR || (opcode == OPCODE_I_ARITH && !(funct3 == 3'b001 || funct3 == 3'b101))) ? {{20{instruction_r[31]}}, instruction_r[31:20]} : 32'b0;
    // S-type (Store)
    assign imm_s = (opcode == OPCODE_S) ? {{20{instruction_r[31]}}, instruction_r[31:25], instruction_r[11:7]} : 32'b0;
    // B-type (Branch)
    assign imm_b = (opcode == OPCODE_B) ? {{19{instruction_r[31]}}, instruction_r[31], instruction_r[7], instruction_r[30:25], instruction_r[11:8], 1'b0} : 32'b0;
    // U-type (LUI, AUIPC)
    assign imm_u = (opcode == OPCODE_LUI || opcode == OPCODE_AUIPC) ? {instruction_r[31:12], 12'b0} : 32'b0;
    // J-type (JAL)
    assign imm_j = (opcode == OPCODE_JAL) ? {{11{instruction_r[31]}}, instruction_r[31], instruction_r[19:12], instruction_r[20], instruction_r[30:21], 1'b0} : 32'b0;
    // SHAMT immediate (Shift instructions)
    assign shamt_imm = (opcode == OPCODE_I_ARITH && (funct3 == 3'b001 || funct3 == 3'b101)) ? {27'b0, instruction_r[24:20]} : 32'b0;
    
endmodule
