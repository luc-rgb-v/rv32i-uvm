`timescale 1ns / 1ps
module tb_bram;

    reg clka;
    reg ena;
    reg wea;
    reg [12:0] addra;
    reg [7:0] dina;
    wire [7:0] douta;

    data_memory_mimic dut (
        .clka(clka),
        .ena(ena),
        .wea(wea),
        .addra(addra),
        .dina(dina),
        .douta(douta)
    );

    initial clka = 0;
    always #5 clka = ~clka;

    task write_data;
        input [12:0] addr;
        input [7:0] data;
        begin
            @(negedge clka);
            ena  = 1;
            wea  = 1;
            addra = addr;
            dina  = data;
            @(negedge clka);
            wea  = 0;
            ena  = 0;
            $display("[%0t] WRITE: mem[%0d] = 0x%0h", $time, addr, data);
        end
    endtask

    task read_data;
        input [12:0] addr;
        begin
            @(negedge clka);
            ena  = 1;
            wea  = 0;
            addra = addr;
            @(negedge clka);
            $display("[%0t] READ:  mem[%0d] = 0x%0h", $time, addr, douta);
            ena  = 1;
        end
    endtask

    // --------------------------
    // MAIN TEST SEQUENCE
    // --------------------------
    initial begin
        $dumpfile("king.vcd");
        $dumpvars(0, tb_bram);

        // Init signals
        ena   = 0;
        wea   = 0;
        addra = 0;
        dina  = 0;

        // Wait a bit for stable sim
        #20;

        // Write first 5 memory locations
        write_data(0, 8'h11);
        write_data(1, 8'h22);
        write_data(2, 8'h33);
        write_data(3, 8'h44);
        write_data(4, 8'h55);

        // Read first 5 addresses
        $display("\n--- Reading first 5 addresses ---");
        read_data(0);
        read_data(1);
        read_data(2);
        read_data(3);
        read_data(4);

        // Optionally read all memory contents (example: 0-15)
        $display("\n--- Dumping first 16 addresses ---");
        repeat (16) begin
            addra = addra + 1;
            read_data(addra);
        end
        $writememh("mem_dump.hex", dut.mem);
        $display("Simulation finished.");
        #50;
        $finish;
    end

endmodule
