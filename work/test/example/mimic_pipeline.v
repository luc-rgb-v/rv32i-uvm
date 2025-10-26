`timescale
module mimic_pipeline (
    input wire clk,
    input wire rst,
    input wire flush_if,
    input wire flush_id,
    input wire flush_ex,
    input wire flush_mem,
    input wire flush_sub_mem,
    input wire stall_pc,
    input wire stall_if,
    input wire stall_sub_if,
    input wire stall_id,
    input wire stall_ex,
    input wire stall_mem,
    output wire [7:0] pc_o,
    output wire [3:0] instruction_mem_o,
    output wire [7:0] if_stage_o,
    output wire [7:0] id_stage_o,
    output wire [7:0] ex_stage_o,
    output wire [3:0] data_mem_o,
    output wire [7:0] mem_stage_o,
    output wire [7:0] reg_file_o
);

    reg [7:0] pc_r;
    reg [3:0] instruction_mem_r;
    reg [7:0] if_stage_r;
    reg [7:0] id_stage_r;
    reg [7:0] ex_stage_r;
    reg [3:0] data_mem_r;
    reg [7:0] mem_stage_r;
    reg [7:0] reg_file_r;

endmodule
