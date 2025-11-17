`timescale 1ps/1ps
module imem_wrab (
  input wire clk_i,
  input wire en,
  input wire [31:0] instr_addr_i,
  output wire [31:0] instruction_o

);

blk_mem_gen_0 i_mem_dut (
  .clka(clk_i),
  .ena(en),
  .wea(0),
  .addra(instr_addr_i[9:0]),
  .dina(8b'0),
  .douta(instruction_o)
);

endmodule
