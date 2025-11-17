`timescale 1ps / 1ps
module instr_mem (
  input clk_i,
  input wire [31:0] instr_addr_i,
  output reg [31:0] instruction_o
);
  reg [7:0] instructions_r [0:1023];
  integer i;
  initial begin
    for(i = 0; i < 1024 ; i=i+1)
    instructions_r[i] = 8'b0;
    $readmemh("instruction.mem", instructions_r);
    #1;
    $display("Index 0: %h", instructions_r[0]);
    $display("Index 1: %h", instructions_r[1]);
    $display("Index 2: %h", instructions_r[2]);
    $display("Index 3: %h", instructions_r[3]);
  end 
  always @ (posedge clk_i) begin
    instruction_o <= {instructions_r[instr_addr_i + 3], instructions_r[instr_addr_i + 2], instructions_r[instr_addr_i + 1], instructions_r[instr_addr_i + 0]};
  end
endmodule
