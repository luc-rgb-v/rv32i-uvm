`timescale 1ns / 1ps
module tb_pipeline;

    // DUT signal
    reg clk = 0;
    reg rst = 1;
    reg flush = 0;
    reg stall = 0;
    reg [7:0] data_i = 8'h0;

    wire [7:0] data_1;
    wire [7:0] data_2;
    wire [7:0] data_3;
    wire [7:0] data_4;

    always #5 clk = ~clk;

    pipeline_reg dut (
        .clk(clk),
        .rst(rst),
        .flush(flush),
        .stall(stall),
        .data_i(data_i),
        .data_1(data_1),
        .data_2(data_2),
        .data_3(data_3),
        .data_4(data_4)
    );

    initial begin
        $dumpfile("tb_pipeline.vcd");
        $dumpvars(0, tb_pipeline);
        $display("===test pipeline===");
        $display("=== testbench   ===");
    end

    initial begin 
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #20; rst = 0; data_i = 8'h44;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #10; data_i = 8'h33;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #10; data_i = 8'h22;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #10; data_i = 8'h11;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #10; data_i = 8'hFF; flush = 1;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #20; data_i = 8'hAA; flush = 0;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #30; data_i = 8'hBB; stall = 1;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #20; data_i = 8'hCC; stall = 0;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #10; data_i = 8'hDD;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        #40;
        $display("[%0t] rst = %0b flush = %0b stall = %0b data_i = %08x data_1 = %08x data_2 = %08x data_3 = %08x data_4 = %08x", $time, rst, flush, stall, data_i, data_1, data_2, data_3, data_4);
        $display("=== test finish ===");
        $finish;
    end

endmodule


