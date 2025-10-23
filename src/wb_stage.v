`timescale 1ns/1ps
module wb_stage (
    // From MEM stage
    input wire [31:0] mem_data_i,
    input wire [31:0] alu_result_i,
    input wire        regwrite_i,
    input wire [4:0]  rd_addr_i,
    input wire [1:0]  wb_sel_i,       // 00: ALU, 01: MEM, 10: PC+4
    input wire [31:0] pc_address_i,
    input wire        mem_valid_i,
    // To Register File
    output wire        regwrite_o,
    output wire [4:0]  rd_addr_o,
    output wire [31:0] wb_data_o
);

    // Pass-through control
    assign regwrite_o = regwrite_i;
    assign rd_addr_o  = rd_addr_i;
    wire [31:0] wb_data_temp = (wb_sel_i == 2'b00) ? alu_result_i :
                       (wb_sel_i == 2'b01) ? mem_data_i   :
                       (wb_sel_i == 2'b10) ? (pc_address_i + 32'd4) :
                                             32'b0;
    assign wb_data_o = (mem_valid_i == 1) ? wb_data_temp : 32'b0;

endmodule


