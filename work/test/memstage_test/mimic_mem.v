`timescale 1ns / 1ps
module mimic_mem (
    input wire clka,
    input wire ena,
    input wire wea,
    input wire [12:0] addra,
    input wire [7:0] dina,
    output reg [7:0] douta
);
    // 8 byte
    reg [7:0] mem [0:7];

    always @(posedge clka) begin
        if (ena) begin
            douta <= mem[addra[2:0]];
            if (wea)
                mem[addra[2:0]] <= dina;
        end
    end

endmodule
