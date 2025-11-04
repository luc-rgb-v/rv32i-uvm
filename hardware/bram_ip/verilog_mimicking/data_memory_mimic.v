`timescale 1ns / 1ps
module data_memory_mimic (
    input  wire        clka,
    input  wire        ena,
    input  wire        wea,
    input  wire [10:0] addra,  // 2048 = 2^11
    input  wire [7:0]  dina,
    output reg  [7:0]  douta
);

    // 8-bit x 2048 memory array
    reg [7:0] mem [0:2047];

    // Synchronous write, synchronous read
    always @(posedge clka) begin
        if (ena) begin
            if (wea)
                mem[addra] <= dina;     // write
            douta <= mem[addra];        // read (sync)
        end
    end

endmodule
