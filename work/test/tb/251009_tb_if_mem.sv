`timescale 1ns/1ps

module instr_fetch_v2_tb;

    reg clk;
    reg rst;
    wire [10:0] pc;
    wire [31:0] instr;

    // DUT
    instr_fetch_v2 dut (
        .clk(clk),
        .rst(rst),
        .pc(pc),
        .instr_o(instr)
    );

    // Clock generation: 100 MHz
    initial clk = 0;
    always #10 clk = ~clk;

    // Reset pulse
    initial begin
        rst = 1;
        #20;
        rst = 0;
        #200;
        rst = 1;
        #60;
        rst = 0;
        #600 $finish;
    end

    // Display PC and instruction
    initial begin
        $display("Time (ns)\tPC\tInstruction");
        $monitor("%8t\t%h\t%h", $time, pc, instr);
    end

endmodule
