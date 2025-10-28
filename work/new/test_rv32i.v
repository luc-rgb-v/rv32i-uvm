`timescale 1ns/1ps

module rv32i_dut_tb;

    // ==================== CLOCK & RESET ====================
    reg clk_i = 1'b0;
    always #5 clk_i = ~clk_i; // 100 MHz clock (10ns period)

    reg rst_i;

    // ==================== DEBUG WIRES ====================
    wire [31:0] debug_pc_o;
    wire [31:0] debug_instr_o;
    wire        debug_if_valid_o;
    wire [31:0] debug_id_pc_o;
    wire [31:0] debug_rs1_data_o;
    wire [31:0] debug_rs2_data_o;
    wire [31:0] debug_imm_o;
    wire [3:0]  debug_alu_op_o;
    wire        debug_branch_taken_o;
    wire [31:0] debug_branch_target_o;
    wire [31:0] debug_alu_result_o;
    wire [31:0] debug_mem_addr_o;
    wire [31:0] debug_mem_wdata_o;
    wire [31:0] debug_mem_rdata_o;
    wire        debug_mem_read_o;
    wire        debug_mem_write_o;
    wire [31:0] debug_wb_data_o;
    wire [4:0]  debug_wb_rd_o;
    wire        debug_wb_valid_o;

    // ==================== DUT INSTANTIATION ====================
    rv32i dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .flush_mem(0),
        .flush_sub_mem(0),
        .flush_ex(0),
        .flush_id(0),
        .flush_if(0),
        .flush_sub_if(0),
        .stall_mem(0),
        .stall_sub_mem(0),
        .stall_ex(0),
        .stall_id(0),
        .stall_if(0),
        .stall_sub_if(0),
        .stall_pc(0),

        .debug_pc_o(debug_pc_o),
        .debug_instr_o(debug_instr_o),
        .debug_if_valid_o(debug_if_valid_o),
        .debug_id_pc_o(debug_id_pc_o),
        .debug_rs1_data_o(debug_rs1_data_o),
        .debug_rs2_data_o(debug_rs2_data_o),
        .debug_imm_o(debug_imm_o),
        .debug_alu_op_o(debug_alu_op_o),
        .debug_branch_taken_o(debug_branch_taken_o),
        .debug_branch_target_o(debug_branch_target_o),
        .debug_alu_result_o(debug_alu_result_o),
        .debug_mem_addr_o(debug_mem_addr_o),
        .debug_mem_wdata_o(debug_mem_wdata_o),
        .debug_mem_rdata_o(debug_mem_rdata_o),
        .debug_mem_read_o(debug_mem_read_o),
        .debug_mem_write_o(debug_mem_write_o),
        .debug_wb_data_o(debug_wb_data_o),
        .debug_wb_rd_o(debug_wb_rd_o),
        .debug_wb_valid_o(debug_wb_valid_o)
    );

    // ==================== WAVEFORM DUMP ====================
    initial begin
        $dumpfile("rv32i_dut_tb.vcd");
        $dumpvars(0, rv32i_dut_tb);
    end

    // ==================== STIMULUS ====================
    initial begin
        // Initialize all inputs
        rst_i = 1'b1;
       
        // Hold reset for a few cycles
        #30;
        rst_i = 1'b0;
        #10;

        // Let CPU run freely for a while
        #2000;
        // Finish simulation
        $display("Simulation completed.");
        $finish;
    end

    // ==================== DEBUG MONITOR ====================
    always @(posedge clk_i) begin
        $display("[%0t] PC=%08x | Instr=%08x | ALU=%08x | WB=%08x (rd=%0d) | IF_valid=%b",
                 $time, debug_pc_o, debug_instr_o,
                 debug_alu_result_o, debug_wb_data_o,
                 debug_wb_rd_o, debug_if_valid_o);
    end

endmodule
