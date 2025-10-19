`timescale 1ns / 1ps
module mux_2to1 (
    input wire [31:0] a_i,
    input wire [31:0] b_i,
    input wire se_i,
    output wire [31:0] y_o
);
assign y_o = se_i ? b_i : a_i;
endmodule
