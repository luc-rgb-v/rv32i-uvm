`timescale 1ns/1ps
module wb_stage (
    // From MEM stage
    input  wire        regwrite_i,
    input  wire [4:0]  rd_addr_i,
    input  wire [31:0] alu_result_i,
    input  wire [31:0] data_mem_i,
    input  wire [31:0] pc_address_i,
    input  wire [1:0]  wb_sel_i,       // 00: ALU, 01: MEM, 10: PC+4

    // To Register File
    output wire        regwrite_o,
    output wire [4:0]  rd_addr_o,
    output wire [31:0] wb_data_o
);

    // Pass-through control
    assign regwrite_o = regwrite_i;
    assign rd_addr_o  = rd_addr_i;

    // WB mux (combinational)
    assign wb_data_o = (wb_sel_i == 2'b00) ? alu_result_i :
                       (wb_sel_i == 2'b01) ? data_mem_i   :
                       (wb_sel_i == 2'b10) ? (pc_address_i + 32'd4) :
                                             32'b0;

endmodule


