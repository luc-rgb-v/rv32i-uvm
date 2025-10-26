`timescale 1ns/1ps

module mimic_pipeline_tb;

    // Clock + Reset
    reg clk;
    reg rst;

    // Flush signals
    reg flush_sub_if;
    reg flush_if;
    reg flush_id;
    reg flush_ex;
    reg flush_sub_mem;
    reg flush_mem;

    // Stall signals
    reg stall_pc;
    reg stall_sub_if;
    reg stall_if;
    reg stall_id;
    reg stall_ex;
    reg stall_sub_mem;

    // Outputs
    wire [7:0] pc_o;
    wire [7:0] instruction_data_o;
    wire [15:0] if_stage_o;
    wire [15:0] id_stage_o;
    wire [15:0] ex_stage_o;
    wire [7:0] data_mem_o;
    wire [23:0] mem_stage_o;
    wire [23:0] reg_file_o;

    // Instantiate UUT
    mimic_pipeline uut (
        .clk(clk),
        .rst(rst),

        .flush_sub_if(flush_sub_if),
        .flush_if(flush_if),
        .flush_id(flush_id),
        .flush_ex(flush_ex),
        .flush_sub_mem(flush_sub_mem),
        .flush_mem(flush_mem),

        .stall_pc(stall_pc),
        .stall_sub_if(stall_sub_if),
        .stall_if(stall_if),
        .stall_id(stall_id),
        .stall_ex(stall_ex),
        .stall_sub_mem(stall_sub_mem),

        .pc_o(pc_o),
        .instruction_data_o(instruction_data_o),
        .if_stage_o(if_stage_o),
        .id_stage_o(id_stage_o),
        .ex_stage_o(ex_stage_o),
        .data_mem_o(data_mem_o),
        .mem_stage_o(mem_stage_o),
        .reg_file_o(reg_file_o)
    );

    always #5 clk = ~clk;
    
    initial begin
        $dumpfile("test_pipeline_flush_pipeline.vcd");
        $dumpvars(0, mimic_pipeline_tb);
    end
    
    initial begin 
        #65; flush_if = 1; flush_id = 1; flush_ex = 1;
        #5; flush_if = 1; flush_id = 0; flush_ex = 0;
        #10; flush_if = 0;
    end 

    initial begin
        clk = 0;
        rst = 1;
        flush_sub_if = 0;
        flush_if = 0;
        flush_id = 0;
        flush_ex = 0;
        flush_sub_mem = 0;
        flush_mem = 0;

        stall_pc = 0;
        stall_sub_if = 0;
        stall_if = 0;
        stall_id = 0;
        stall_ex = 0;
        stall_sub_mem = 0;
        #10; rst = 0;


        #400 $finish;
    end

endmodule
