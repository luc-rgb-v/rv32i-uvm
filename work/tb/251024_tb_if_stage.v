`timescale 1ns/1ps
module tb_if;

    // ==========================================================
    // DUT signals
    // ==========================================================
    reg         clk_i = 0;
    reg         rst_i = 1;
    reg         stall_i = 0;
    reg         flush_i = 0;
    reg  [31:0] pc_bj_i = 32'h00000008;
    reg         take_bj_sig_i = 0;
    wire [31:0] pc_o;
    wire [31:0] instr_o;
    wire        valid_o;

    // Clock generation: 100 MHz
    always #5 clk_i = ~clk_i;

    // ==========================================================
    // DUT instantiation
    // ==========================================================
    if_stage dut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .stall_i(stall_i),
        .flush_i(flush_i),
        .take_bj_sig_i(take_bj_sig_i),
        .pc_bj_i(pc_bj_i),
        .instr_o(instr_o),
        .pc_o(pc_o),
        .valid_o(valid_o)
    );

    // ==========================================================
    // SIMULATION CONTROL
    // ==========================================================
    initial begin
        $dumpfile("if_stage_test.vcd");
        $dumpvars(0, tb_if);

        $display("=== IF Stage BRAM Testbench ===");
        $display("Time(ns) | PC | INSTR | VALID | Notes");

        // Hold reset for a few cycles
        repeat (3) @(posedge clk_i);
        rst_i = 0;
        $display("---- Reset released ----");

        // Normal fetch
        repeat (6) begin
            @(posedge clk_i);
            if (valid_o)
                $display("[%0t] PC=%08x | INSTR=%08x | VALID=%0b", $time, pc_o, instr_o, valid_o);
        end

        // Stall test
        $display("---- Stall for 2 cycles ----");
        stall_i = 1;
        repeat (2) @(posedge clk_i);
        stall_i = 0;

        // Continue normal fetch
        repeat (4) begin
            @(posedge clk_i);
            if (valid_o)
                $display("[%0t] PC=%08x | INSTR=%08x | VALID=%0b", $time, pc_o, instr_o, valid_o);
        end

        // Branch/jump test
        $display("---- Branch/Jump to 0x00000010 ----");
        @(negedge clk_i);
        take_bj_sig_i = 1;
        pc_bj_i = 32'h00000010;
        @(negedge clk_i);
        take_bj_sig_i = 0;

        repeat (5) begin
            @(posedge clk_i);
            if (valid_o)
                $display("[%0t] PC=%08x | INSTR=%08x | VALID=%0b", $time, pc_o, instr_o, valid_o);
        end

        // Flush test
        $display("---- Pipeline flush ----");
        flush_i = 1;
        @(posedge clk_i);
        flush_i = 0;

        repeat (6) begin
            @(posedge clk_i);
            if (valid_o)
                $display("[%0t] PC=%08x | INSTR=%08x | VALID=%0b", $time, pc_o, instr_o, valid_o);
        end

        $display("=== Simulation End ===");
        $finish;
    end

endmodule
