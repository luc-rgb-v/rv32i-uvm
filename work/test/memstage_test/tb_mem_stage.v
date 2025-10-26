`timescale 1ns / 1ps
module tb_mem_stage;

    reg clk_i = 0;
    reg rst_i = 1;
    reg stall_i = 0;
    reg flush_i = 0;

    // From EX
    reg        regwrite_i = 0;
    reg [4:0]  rd_addr_i = 5'b0;
    reg [1:0]  memtoreg_i = 2'b0;
    reg [31:0] pc_address_i = 32'h0;
    reg [31:0] alu_result_i = 32'h0;
    reg [31:0] store_data_i = 32'h0;
    reg        memread_i = 0;
    reg        memwrite_i = 0;
    reg [2:0]  funct3_i = 3'b0;
    reg        ex_valid_i = 0;

    // To WB (MEM/WB register outputs)
    wire        regwrite_o;
    wire [4:0]  rd_addr_o;
    wire [1:0]  memtoreg_o;
    wire [31:0] pc_address_o;
    wire [31:0] alu_result_o;
    wire [31:0] mem_data_o;
    wire        mem_valid_o;

    always #5 clk_i = ~clk_i;

    memstage dut (
    	.clk_i(clk_i),
    	.rst_i(rst_i),
    	.stall_i(stall_i),
    	.flush_i(flush_i),
    	.regwrite_i(regwrite_i),
    	.rd_addr_i(rd_addr_i),
    	.memtoreg_i(memtoreg_i),
    	.pc_address_i(pc_address_i),
    	.alu_result_i(alu_result_i),
    	.store_data_i(store_data_i),
    	.memread_i(memread_i),
    	.memwrite_i(memwrite_i),
    	.funct3_i(funct3_i),
    	.ex_valid_i(ex_valid_i),
        .regwrite_o(regwrite_o),
        .rd_addr_o(rd_addr_o),
        .memtoreg_o(memtoreg_o),
        .pc_address_o(pc_address_o),
        .alu_result_o(alu_result_o),
        .mem_data_o(mem_data_o),
        .mem_valid_o(mem_valid_o)
    );

    task read_data; input [2:0] a; input [31:0] b;
        begin
            #2.5;
            memread_i = 1; 
            funct3_i = a;
            alu_result_i = b;
            #3;
            $display("[$0t] [read_data] addr = %d data = %h",$time, alu_result_i[14:2], mem_data_o);
            @(negedge clk_i);
        end
    endtask

    task write_data; input [2:0] a; input [31:0] b; input [31:0] c;
        begin
            #2.5;
            memwrite_i = 1; 
            funct3_i = a;
            alu_result_i = b;
            store_data_i = c;
            #3;
            $display("[$0t] [store_data] addr = %d store_data = %h",$time, alu_result_i[14:2], store_data_i);
            @(negedge clk_i);
        end
    endtask

    initial begin
        $dumpfile("mem_stage.vcd");
        $dumpvars(0,tb_mem_stage);
        $display("=== start sim ===");
    end

    initial begin
        #10;
        rst_i = 0;
        write_data(3'b111, 32'd0, 32'h11223344);
        write_data(3'b111, 32'd1, 32'haabbccdd);
        write_data(3'b111, 32'd2, 32'h12345678);
        write_data(3'b111, 32'd3, 32'hffeeddaa);
        write_data(3'b111, 32'd4, 32'h75934863);
        write_data(3'b111, 32'd5, 32'habcdef12);
        read_data(3'b111, 32'd0);
        read_data(3'b111, 32'd1);
        read_data(3'b111, 32'd2);
        read_data(3'b111, 32'd3);
        read_data(3'b111, 32'd4);
        read_data(3'b111, 32'd5);

        $finish;
    end
endmodule
