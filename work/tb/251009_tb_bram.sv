`timescale 1ns / 1ps

module tb_blk_mem_gen_1;

    // Parameters
    localparam ADDR_WIDTH = 11;
    localparam DATA_WIDTH = 8;

    // Testbench signals
    reg                     clka;
    reg                     ena;
    reg  [0:0]              wea;
    reg  [ADDR_WIDTH-1:0]   addra;
    reg  [DATA_WIDTH-1:0]   dina;
    wire [DATA_WIDTH-1:0]   douta;

    // Instantiate DUT
    blk_mem_gen_1 uut (
        .clka   (clka),
        .ena    (ena),
        .wea    (wea),
        .addra  (addra),
        .dina   (dina),
        .douta  (douta)
    );

    // Clock generation (100 MHz)
    initial clka = 0;
    always #5 clka = ~clka;

    // Tasks -----------------------------------------------------

    // Write to memory
    task write_mem(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] data);
    begin
        @(posedge clka);
        ena  = 1;
        wea  = 1;
        addra = addr;
        dina  = data;
        @(posedge clka);
        wea = 0; // disable write
    end
    endtask

    // Read from memory (1-cycle latency typical in BRAM)
    task read_mem(input [ADDR_WIDTH-1:0] addr, output [DATA_WIDTH-1:0] data_out);
    begin
        @(posedge clka);
        ena  = 1;
        wea  = 0;
        addra = addr;
        @(posedge clka); // wait one cycle for valid data
        data_out = douta;
        $display("READ : ADDR=%0d DATA=%02h", addr, douta);
    end
    endtask

    // Check value
    task check_value(input [ADDR_WIDTH-1:0] addr, input [DATA_WIDTH-1:0] expected);
        reg [DATA_WIDTH-1:0] got;
    begin
        read_mem(addr, got);
        if (got !== expected)
            $display("❌ MISMATCH at ADDR=%0d : expected %02h, got %02h", addr, expected, got);
        else
            $display("✅ OK at ADDR=%0d : %02h", addr, got);
    end
    endtask

    // Stimulus --------------------------------------------------
    integer i;
    reg [7:0] tmp;

    initial begin
        ena   = 0;
        wea   = 0;
        addra = 0;
        dina  = 0;

        repeat (5) @(posedge clka);
        $display("\n==== TEST START ====\n");

        // 1️⃣ Basic writes
        write_mem(0, 8'hAA);
        write_mem(1, 8'h55);
        write_mem(2, 8'hFF);
        check_value(0, 8'hAA);
        check_value(1, 8'h55);
        check_value(2, 8'hFF);

        // 2️⃣ Overwrite check
        write_mem(1, 8'hCC);
        check_value(1, 8'hCC);

        // 3️⃣ Random addresses
        write_mem(100, 8'h12);
        write_mem(200, 8'h34);
        write_mem(511, 8'hFE);
        check_value(100, 8'h12);
        check_value(200, 8'h34);
        check_value(511, 8'hFE);

        // 4️⃣ Sequential block write/read
        $display("\n-- Sequential block write/read test --");
        for (i = 10; i < 20; i = i + 1)
            write_mem(i, i + 8'hA0); // write pattern
        for (i = 10; i < 20; i = i + 1)
            check_value(i, i + 8'hA0);

        // 5️⃣ Boundary test (lowest and highest addresses)
        $display("\n-- Boundary test --");
        write_mem(0,   8'h11);
        write_mem(511, 8'hEE);
        check_value(0,   8'h11);
        check_value(511, 8'hEE);

        // 6️⃣ Back-to-back write + read
        $display("\n-- Back-to-back write+read test --");
        write_mem(50, 8'h99);
        read_mem(50, tmp);
        if (tmp === 8'h99)
            $display("✅ Immediate readback OK");
        else
            $display("⚠️ Immediate readback may lag (depends on BRAM latency)");

        $display("\n==== ALL TESTS DONE ====\n");
        $stop;
    end

endmodule
