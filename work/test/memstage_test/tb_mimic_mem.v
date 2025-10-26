`timescale 1ns / 1ps
module tb_mimic_mem;

    reg clka = 0;
    reg ena = 0;
    reg wea = 0;
    reg [12:0] address = 13'b0;
    reg [7:0] dina = 8'b0;
    wire [7:0] douta;

    always #5 clka = ~clka; 

    mimic_mem dut (
        .clka(clka),
        .ena(ena),
        .wea(wea),
        .address(address),
        .dina(dina),
        .douta(douta)
    );
    
    initial begin
        $dumpfile("mimic.vcd");
        $dumpvars(0,tb_mimic_mem);
        $display("=== start sim ===");
    end

    task write; input [12:0] b; input [7:0] c;
        begin
            #2.5;
            wea = 1; address = b; dina = c;
            #3;
            $display("[%0t] [write] wea = %b address = %02b dina = %02h douta = %02h", $time, wea, address[2:0], dina, douta);
            @(negedge clka);
        end
    endtask

    task read; input [12:0] b; input [7:0] c;
        begin
            #2.5;
            wea = 0; address = b; dina = c;
            #3;
            $display("[%0t] [read] wea = %b address = %02b dina = %02h douta = %02h", $time, wea, address[2:0], dina, douta);
            @(negedge clka);
        end
    endtask

    initial begin
        #10;
        ena = 1;

        write(13'd1, 8'h11);
        write(13'd2, 8'h22);
        write(13'd3, 8'h33);
        write(13'd4, 8'h44);
        write(13'd5, 8'h55);
        write(13'd6, 8'h66);

        read(13'd1, 8'h11);
        read(13'd2, 8'h22);
        read(13'd3, 8'h33);
        read(13'd4, 8'h44);
        read(13'd5, 8'h55);
        read(13'd6, 8'h66);

        ena = 0;

        write(13'd5, 8'hdd);
        write(13'd6, 8'hcc);
        write(13'd7, 8'hbb);
        write(13'd8, 8'haa);

        read(13'd5, 8'hdd);
        read(13'd6, 8'hcc);
        read(13'd7, 8'hbb);
        read(13'd8, 8'haa);

        $finish;
    end

endmodule
