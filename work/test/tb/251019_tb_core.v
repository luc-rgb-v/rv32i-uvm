`timescale 1ns / 1ps

module tb_core;

    // Clock and reset
    reg clk_i;
    reg rst_i;

    // DUT outputs
    wire [31:0] pc_if_id;
    wire [31:0] instruction_if_id;
    wire [31:0] operand_a_id_ex;
    wire [31:0] operand_b_id_ex;
    wire [31:0] imm_id_ex;
    wire [31:0] alu_result_ex_mem;
    wire [31:0] data_write_ex_mem;
    wire [31:0] data_out_mem_wb;
    wire [4:0]  addr_wb;
    wire [31:0] data_wb;

    // Instantiate DUT
    rv32i_core_top dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .pc_if_id(pc_if_id),
        .instruction_if_id(instruction_if_id),
        .operand_a_id_ex(operand_a_id_ex),
        .operand_b_id_ex(operand_b_id_ex),
        .imm_id_ex(imm_id_ex),
        .alu_result_ex_mem(alu_result_ex_mem),
        .data_write_ex_mem(data_write_ex_mem),
        .data_out_mem_wb(data_out_mem_wb),
        .addr_wb(addr_wb),
        .data_wb(data_wb)
    );

    // --- Clock generation ---
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i;  // 100 MHz clock
    end

    // --- Reset and simulation control ---
    initial begin
        rst_i = 1'b1;
        #20;
        rst_i = 1'b0;    // release reset
        #2000;           // run simulation for some time
        $finish;
    end

    // --- Optional: waveform dump ---
    initial begin
        $dumpfile("tb_core.vcd");
        $dumpvars(0, tb_core);
    end

endmodule
