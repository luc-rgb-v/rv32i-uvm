`timescale 1ns / 1ps

// Testbench for memstage module (waveform analysis, Vivado Block RAM read-first)
module memstage_tb;

    // Inputs
    reg clk_i;
    reg rst_i;
    reg stall_i;
    reg flush_i;
    reg regwrite_i;
    reg [4:0] rd_addr_i;
    reg [1:0] memtoreg_i;
    reg [31:0] pc_address_i;
    reg [31:0] alu_result_i;
    reg [31:0] store_data_i;
    reg memread_i;
    reg memwrite_i;
    reg [2:0] funct3_i;
    reg ex_valid_i;

    // Outputs
    wire regwrite_o;
    wire [4:0] rd_addr_o;
    wire [1:0] memtoreg_o;
    wire [31:0] pc_address_o;
    wire [31:0] alu_result_o;
    wire [31:0] mem_data_o;
    wire mem_valid_o;

    // Instantiate the Unit Under Test (UUT)
    memstage uut (
        .clk_i(clk_i),
        .rst_i(rst_i),
        .stall_i(stall_i),
        .flush_i(flush_i),
        .regwrite_i(regwrite_i),
        .rd_addr_i(rd_addr_i),
        .memtoreg_i(memtoreg_i),
        .pc_address_i(pc_address_i),
        .alu_result_i(alu_result_i),
        .store_data_i(store_data_i),
        .memread_i(memread_i),
        .memwrite_i(memwrite_i),
        .funct3_i(funct3_i),
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
    initial begin
        clk_i = 0;
        forever #5 clk_i = ~clk_i; // 100 MHz clock (10 ns period)
    end

    // Test procedure
    initial begin
        // Initialize inputs
        rst_i = 1;
        stall_i = 0;
        flush_i = 0;
        regwrite_i = 0;
        rd_addr_i = 0;
        memtoreg_i = 0;
        pc_address_i = 0;
        alu_result_i = 0;
        store_data_i = 0;
        memread_i = 0;
        memwrite_i = 0;
        funct3_i = 0;
        ex_valid_i = 0;

        // Test 1: Reset
        #20;
        rst_i = 0;

        // Test 2: Preload memory with SW (address 0x0 = DDCCBBAA)
        memwrite_i = 1;
        memread_i = 0;
        rd_addr_i = 5'd10;
        memtoreg_i = 2'b01; // Memory data (not used for store)
        alu_result_i = 32'h00000000; // Address 0x0
        store_data_i = 32'hDDCCBBAA;
        funct3_i = 3'b010; // SW
        ex_valid_i = 1;
        #20;

        // Test 3: Preload memory with SW (address 0x4 = 44332211)
        alu_result_i = 32'h00000004; // Address 0x4
        store_data_i = 32'h44332211;
        funct3_i = 3'b010; // SW
        #20;

        // Test 4: Non-memory instruction (ALU pass-through)
        memwrite_i = 0;
        memread_i = 0;
        regwrite_i = 1;
        rd_addr_i = 5'd10;
        memtoreg_i = 2'b00; // ALU result
        pc_address_i = 32'h1000;
        alu_result_i = 32'hDEADBEEF;
        ex_valid_i = 1;
        #20;

        // Test 5: SB (offset 3)
        memwrite_i = 1;
        memread_i = 0;
        rd_addr_i = 5'd11;
        memtoreg_i = 2'b01; // Memory data (not used for store)
        alu_result_i = 32'h00000003; // Address 0x3
        store_data_i = 32'h11223344;
        funct3_i = 3'b000; // SB
        #20;

        // Test 6: SH (offset 0)
        alu_result_i = 32'h00000000; // Address 0x0
        store_data_i = 32'hAABBCCDD;
        funct3_i = 3'b001; // SH
        #20;

        // Test 7: SW (offset 0)
        alu_result_i = 32'h00000004; // Address 0x4
        store_data_i = 32'h12345678;
        funct3_i = 3'b010; // SW
        #20;

        // Test 8: LB (offset 3)
        memwrite_i = 0;
        memread_i = 1;
        alu_result_i = 32'h00000003; // Address 0x3
        funct3_i = 3'b000; // LB
        #20;

        // Test 9: LH (offset 0)
        alu_result_i = 32'h00000000; // Address 0x0
        funct3_i = 3'b001; // LH
        #20;

        // Test 10: LW (offset 0)
        alu_result_i = 32'h00000004; // Address 0x4
        funct3_i = 3'b010; // LW
        #20;

        // Test 11: LBU (offset 2)
        alu_result_i = 32'h00000002; // Address 0x2
        funct3_i = 3'b100; // LBU
        #20;

        // Test 12: LHU (offset 2)
        alu_result_i = 32'h00000002; // Address 0x2
        funct3_i = 3'b101; // LHU
        #20;

        // Test 13: Stall
        memread_i = 0;
        regwrite_i = 1;
        rd_addr_i = 5'd12;
        memtoreg_i = 2'b10; // PC+4
        pc_address_i = 32'h2000;
        alu_result_i = 32'h0;
        funct3_i = 3'b000;
        #10;
        stall_i = 1;
        #10;
        stall_i = 0;
        #20;

        // Test 14: Flush
        flush_i = 1;
        #10;
        flush_i = 0;
        #20;

        // Test 15: Original test sequence (stores)
        memwrite_i = 1;
        memread_i = 0;
        rd_addr_i = 5'd10;
        memtoreg_i = 2'b00;
        funct3_i = 3'b111; // Invalid funct3
        ex_valid_i = 1;
        alu_result_i = 32'h00000003; // Address 0x3
        store_data_i = 32'h11223344;
        #20;
        alu_result_i = 32'h00000007; // Address 0x7
        store_data_i = 32'haabbccdd;
        #20;
        alu_result_i = 32'h0000000B; // Address 0xB
        store_data_i = 32'h1a2b3c4d;
        #20;
        alu_result_i = 32'h0000000F; // Address 0xF
        store_data_i = 32'hff11cc22;
        #20;
        alu_result_i = 32'h0000001F; // Address 0x1F
        store_data_i = 32'hee33aa66;
        #20;

        // Test 16: Original test sequence (loads)
        memwrite_i = 0;
        memread_i = 1;
        alu_result_i = 32'h00000003; // Address 0x3
        store_data_i = 32'h11223344;
        #20;
        alu_result_i = 32'h00000007; // Address 0x7
        store_data_i = 32'haabbccdd;
        #20;
        alu_result_i = 32'h0000000B; // Address 0xB
        store_data_i = 32'hee33aa66;
        #20;
        alu_result_i = 32'h0000000F; // Address 0xF
        store_data_i = 32'hff11cc22;
        #20;
        alu_result_i = 32'h0000001F; // Address 0x1F
        store_data_i = 32'haabbccdd;
        #20;

        // End simulation
        #20;
        $finish;
    end

endmodule