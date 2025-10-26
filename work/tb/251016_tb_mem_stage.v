`timescale 1ns/1ps

module mem_stage_tb;

    // DUT signals
    reg         clk;
    reg         rst;
    reg         flush_i;
    reg         stall_i;
    reg         regwrite_i;
    reg  [4:0]  rd_addr_i;
    reg  [1:0]  memtoreg_i;
    reg  [31:0] pc_address_i;
    reg  [31:0] alu_result_i;
    reg  [31:0] store_data_i;
    reg         memread_i;
    reg         memwrite_i;
    reg  [1:0]  mem_size_i;
    reg         mem_unsigned_i;
    reg         ex_valid_i;

    wire        regwrite_o;
    wire [4:0]  rd_addr_o;
    wire [1:0]  memtoreg_o;
    wire [31:0] pc_address_o;
    wire [31:0] alu_result_o;
    wire [31:0] mem_data_o;
    wire        mem_valid_o;

    // Instantiate DUT
    mem_stage uut (
        .clk_i(clk),
        .rst_i(rst),
        .flush_i(flush_i),
        .stall_i(stall_i),
        .regwrite_i(regwrite_i),
        .rd_addr_i(rd_addr_i),
        .memtoreg_i(memtoreg_i),
        .pc_address_i(pc_address_i),
        .alu_result_i(alu_result_i),
        .store_data_i(store_data_i),
        .memread_i(memread_i),
        .memwrite_i(memwrite_i),
        .mem_size_i(mem_size_i),
        .mem_unsigned_i(mem_unsigned_i),
        .ex_valid_i(ex_valid_i),
        .regwrite_o(regwrite_o),
        .rd_addr_o(rd_addr_o),
        .memtoreg_o(memtoreg_o),
        .pc_address_o(pc_address_o),
        .alu_result_o(alu_result_o),
        .mem_data_o(mem_data_o),
        .mem_valid_o(mem_valid_o)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk; // 100 MHz

    // Task to write
    task write_mem(input [31:0] addr, input [31:0] data, input [1:0] size);
    begin
        @(negedge clk);
        alu_result_i  <= addr;
        store_data_i  <= data;
        mem_size_i    <= size;
        memwrite_i    <= 1;
        memread_i     <= 0;
        ex_valid_i    <= 1;
        regwrite_i    <= 0;
        pc_address_i  <= pc_address_i + 4;
        @(negedge clk);
        memwrite_i    <= 0;
    end
    endtask

    // Task to read
    task read_mem(input [31:0] addr, input [1:0] size, input unsigned_mode);
    begin
        @(negedge clk);
        alu_result_i   <= addr;
        mem_size_i     <= size;
        mem_unsigned_i <= unsigned_mode;
        memread_i      <= 1;
        memwrite_i     <= 0;
        regwrite_i     <= 1;
        ex_valid_i     <= 1;
        pc_address_i   <= pc_address_i + 4;
        @(negedge clk);
        memread_i      <= 0;
    end
    endtask

    // Simulation control
    initial begin
        $dumpfile("mem_stage_tb.vcd");
        $dumpvars(0, mem_stage_tb);

        // Initialize
        rst          = 1;
        flush_i      = 0;
        stall_i      = 0;
        memread_i    = 0;
        memwrite_i   = 0;
        regwrite_i   = 0;
        rd_addr_i    = 5'd0;
        memtoreg_i   = 2'd1;
        pc_address_i = 32'd0;
        alu_result_i = 32'd0;
        store_data_i = 32'd0;
        mem_size_i   = 2'd2;
        mem_unsigned_i = 0;
        ex_valid_i   = 0;

        repeat (3) @(negedge clk);
        rst = 0;

        // ============================================
        // TEST SEQUENCE
        // ============================================

        // 1. Write full word
        write_mem(32'h00000000, 32'hAABBCCDD, 2'b10);

        // 2. Read back full word
        read_mem(32'h00000000, 2'b10, 0);

        // 3. Write halfword to lower half (SH)
        write_mem(32'h00000000, 32'h00001234, 2'b01);

        // 4. Read back halfword (signed)
        read_mem(32'h00000000, 2'b01, 0);

        // 5. Write halfword to upper half
        write_mem(32'h00000002, 32'h00005678, 2'b01);

        // 6. Read back halfword (unsigned)
        read_mem(32'h00000002, 2'b01, 1);

        // 7. Write byte (SB)
        write_mem(32'h00000001, 32'h000000AA, 2'b00);

        // 8. Read back byte (LB signed)
        read_mem(32'h00000001, 2'b00, 0);

        // 9. Read back byte (LBU unsigned)
        read_mem(32'h00000001, 2'b00, 1);

        // 10. Alternate read/write quickly
        write_mem(32'h00000004, 32'hDEADBEEF, 2'b10);
        read_mem (32'h00000004, 2'b10, 0);
        write_mem(32'h00000008, 32'hFACEB00C, 2'b10);
        read_mem (32'h00000008, 2'b10, 0);

        // 11. Flush test
        @(negedge clk);
        flush_i <= 1;
        @(negedge clk);
        flush_i <= 0;

        // Wait and finish
        repeat (20) @(negedge clk);
        $display("Simulation completed.");
        $finish;
    end

endmodule
