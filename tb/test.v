`timescale 1ns / 1ps
module tb_risc_rv32i;
reg clk_i = 0;
reg rst_i = 1;

reg mem_memread = 0;
reg bj_taken = 0;
reg [31:0] pc_bj =32'b0;

wire [31:0] instr_addr;
wire [31:0] instruction;
wire [31:0] pc;
wire [31:0] ifid_pc;
wire [31:0] ifid_instruction;
  risc_rv32i rv32i_dut (
    .clk_i(clk_i),
    .rst_i(rst_i),
    .instr_addr_o(instr_addr),
    .instruction_i(instruction),
    .imem_ena_o(en)
    ,.mem_memread_w(mem_memread)
    ,.bj_taken_i(bj_taken)
    ,.pc_bj_i(pc_bj)
    ,.pc(pc)
    ,.ifid_pc(ifid_pc)
    ,.ifid_instruction(ifid_instruction)
  );

  blk_mem_gen_0 i_mem_dut (
    .clka(clk_i),
    .ena(en),
    .wea(0),
    .addra(instr_addr[9:0]),
    .dina(8'b0),
    .douta(instruction)
  );

  always #5 clk_i = ~clk_i;
  integer if_log;

  initial begin
    $dumpfile("risc_rv32i_tb_dump.vcd");
    $dumpvars(0,tb_risc_rv32i);
    #20; rst_i = 0; mem_memread = 0;
    #40; bj_taken = 1; pc_bj = 32'h0000004; mem_memread = 0;
    #10; bj_taken = 0; pc_bj = 32'h0000000; mem_memread = 0;
    #00; bj_taken = 0; pc_bj = 32'h0000000; mem_memread = 1;
    #10; bj_taken = 0; pc_bj = 32'h0000000; mem_memread = 0;
    #50;
    $finish;
  end 

endmodule