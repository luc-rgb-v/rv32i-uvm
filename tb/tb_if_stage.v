`timescale 1ns/1ps
module tb_if_stage_bram4;

    // ==========================================================
    // DUT signals
    // ==========================================================
    reg         clk = 0;
    reg         rst = 1;
    reg         stall = 0;
    reg         flush = 0;
    reg  [31:0] pc_b_j = 32'h00000004;
    reg         take_b_j_sig = 0;
    wire [31:0] pc;
    wire [31:0] instr;
    wire        valid;

    // clock
    always #5 clk = ~clk; // 10ns period = 100 MHz

    // DUT instantiation
    if_stage_bram4 dut (
        .clk_i(clk),
        .rst_i(rst),
        .stall_i(stall),
        .flush_i(flush),
        .pc_b_j_i(pc_b_j),
        .take_b_j_sig_i(take_b_j_sig),
        .pc_o(pc),
        .instr_o(instr),
        .valid_o(valid)
    );

    // ==========================================================
    // SIMULATION CONTROL
    // ==========================================================
    initial begin
        $display("=== IF Stage BRAM4 Testbench ===");
        $display("Time(ns) | PC | INSTR | VALID | Notes");

        // reset
        #15 rst = 0;

        // normal fetch
        repeat (6) begin
            @(posedge clk);
            if (valid)
                $display("[%0t] PC=%08x INSTR=%08x VALID=%0b", $time, pc, instr, valid);
        end

        // simulate stall
        $display("---- Stall for 2 cycles ----");
        stall = 1;
        repeat (2) @(posedge clk);
        stall = 0;

        // continue fetching
        repeat (3) begin
            @(posedge clk);
            if (valid)
                $display("[%0t] PC=%08x INSTR=%08x VALID=%0b", $time, pc, instr, valid);
        end

        // simulate branch/jump
        $display("---- Branch/Jump to 0x02 ----");
        @(negedge clk);
        take_b_j_sig = 1;
        @(negedge clk);
        take_b_j_sig = 0;
        repeat (5) @(negedge clk);
        // fetch from new target
        repeat (2) begin
            @(posedge clk);
            if (valid)
                $display("[%0t] PC=%08x INSTR=%08x VALID=%0b", $time, pc, instr, valid);
        end

        // simulate flush
        $display("---- Pipeline flush ----");
        flush = 1;
        repeat (2) @(posedge clk);
        flush = 0;

        repeat (6) begin
            @(posedge clk);
            if (valid)
                $display("[%0t] PC=%08x INSTR=%08x VALID=%0b", $time, pc, instr, valid);
        end

        $display("=== Simulation End ===");
        $finish;
    end

endmodule
