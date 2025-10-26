`timescale 1ns / 1ps
module mux_5to1 (
    input wire [31:0] a_i,
    input wire [31:0] b_i,
    input wire [31:0] c_i,
    input wire [31:0] d_i,
    input wire [31:0] e_i,    
    input wire [2:0] se_i,
    output wire [31:0] y_o
);

assign y_o = (se_i == 3'b100) ? e_i :
             (se_i == 3'b011) ? d_i :
             (se_i == 3'b010) ? c_i :
             (se_i == 3'b001) ? b_i :
              a_i;   // default

endmodule
