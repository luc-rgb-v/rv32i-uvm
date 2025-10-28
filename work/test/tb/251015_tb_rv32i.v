`timescale 1ns / 1ps

module tb_top_rv32i;

    // DUT inputs
    reg clk_i;
    reg rst_i;
    reg stall_i;
    reg flush_i;

    // DUT outputs
    wire        valid_fetch_if_id_o;
    wire [31:0] id_ex_valid_m_instruction_o;

    // Instantiate DUT
    top_rv32i uut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .stall_i(stall_i),
        .flush_i(flush_i),
        .valid_fetch_if_id_o(valid_fetch_if_id_o),
        .id_ex_valid_m_instruction_o(id_ex_valid_m_instruction_o)
    );

    //----------------------------------------------------
    // Clock Generation
    //----------------------------------------------------
    initial begin
        clk_i = 1'b0;
        forever #5 clk_i = ~clk_i;   // 100 MHz clock (10 ns period)
    end

    //----------------------------------------------------
    // Stimulus
    //----------------------------------------------------
    initial begin
        // Init
        rst_i   = 1'b1;
        stall_i = 1'b0;
        flush_i = 1'b0;

        // Apply reset
        #20;
        rst_i = 1'b0;

        // Run a few cycles
        #50;

        // Stall pipeline
        $display("[%0t] Applying stall", $time);
        stall_i = 1'b0;
        #20;
        stall_i = 1'b0;

        // Flush pipeline
        $display("[%0t] Applying flush", $time);
        flush_i = 1'b0;
        #10;
        flush_i = 1'b0;

        // Let it run
      #1000;

        // Finish
        $display("[%0t] Simulation finished", $time);
        $stop;
    end

    //----------------------------------------------------
    // Monitor signals
    //----------------------------------------------------
    initial begin
        $monitor("[%0t] rst=%b stall=%b flush=%b valid_fetch=%b instruction=%h",
                 $time, rst_i, stall_i, flush_i, valid_fetch_if_id_o, id_ex_valid_m_instruction_o);
    end

endmodule
