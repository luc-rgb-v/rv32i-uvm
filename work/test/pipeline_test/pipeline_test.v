`timescale 1ns / 1ps
module pipeline_reg (
    input wire clk,
    input wire rst,
    input wire flush,
    input wire stall,

    input wire [7:0] data_i,
    output wire [7:0] data_1,
    output wire [7:0] data_2,
    output wire [7:0] data_3,
    output wire [7:0] data_4
);

    reg [7:0] data_1_reg;
    reg [7:0] data_2_reg;
    reg [7:0] data_3_reg;
    reg [7:0] data_4_reg;
    
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            data_1_reg <= 8'h0;
            data_2_reg <= 8'h0;
            data_3_reg <= 8'h0;
            data_4_reg <= 8'h0;
        end else if (flush) begin
            data_1_reg <= 8'h0;
            data_2_reg <= 8'h0;
            data_3_reg <= 8'h0;
            data_4_reg <= 8'h0;
        end else if (~stall) begin
            data_1_reg <= data_i;
            data_2_reg <= data_1_reg;
            data_3_reg <= data_2_reg;
            data_4_reg <= data_3_reg;
        end
    end

    assign data_1 = data_1_reg;
    assign data_2 = data_2_reg;
    assign data_3 = data_3_reg;
    assign data_4 = data_4_reg;

endmodule

