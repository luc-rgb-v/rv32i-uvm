`timescale 1ps / 1ps
module risc_rv32i (
    input clk_i,
    input rst_i,

    output wire [31:0] instr_addr_o,
    input wire [31:0] instruction_i,

);