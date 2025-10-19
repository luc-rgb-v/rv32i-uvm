`timescale 1ns/1ps

module tb_blk_mem_gen_2;

    // Inputs
    reg        clka;
    reg        ena;
    reg        wea;
    reg [12:0] addra;
    reg [7:0]  dina;

    // Outputs
    wire [7:0] douta;

    // Instantiate the BRAM
    blk_mem_gen_2 u_bram (
        .clka(clka),
        .ena(ena),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .douta(douta)
    );

    // Clock generation
    initial begin
        clka = 0;
        forever #5 clka = ~clka;
     
    end
    
        // Clock generation
    initial begin
        wea = 0;
        #7.5;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
        #5 wea = ~wea;
    end

    // Test sequence
    initial begin
        // Initialize
        ena = 0;
        addra = 0;
        dina = 0;
        #12.5;
        ena = 1;
        addra =0;
        dina = 8'hAA;
        #10; addra = 1; dina = 11;
        #10; addra = 2; dina = 22;
        #10; addra = 3; dina = 33;
        #10; addra = 4; dina = 44;
        #10; addra = 5; dina = 55;
        #10; addra = 0; dina = 0;
        #10; addra = 1;
        #10; addra = 2;
        #10; addra = 3;
        #10; addra = 4;
        // End simulation
        #20;
        $finish;
    end

endmodule