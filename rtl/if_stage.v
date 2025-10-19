`timescale 1ns/1ps
module if_stage (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire        stall_i,
    input  wire        flush_i,
    input  wire [31:0] pc_b_j_i,
    input  wire        take_b_j_sig_i,
    output reg  [31:0] pc_o,
    output reg  [31:0] instr_o,
    output reg         valid_o
);

    localparam RESET_PC  = 32'h00000000;
    localparam NOP_INSTR = 32'h00000013;

    reg [31:0] pc_addr;       // address issued to BRAM
    reg [31:0] pc_dly;        // delayed one cycle
    reg        valid_dly;

    // --- BRAM enable ---
    wire mem_ena = ~stall_i & ~flush_i;  // define it explicitly!

    // --- byte addresses ---
    wire [11:0] addr0 = pc_addr[10:0] + 11'h0;
    wire [11:0] addr1 = pc_addr[10:0] + 11'h1;
    wire [11:0] addr2 = pc_addr[10:0] + 11'h2;
    wire [11:0] addr3 = pc_addr[10:0] + 11'h3;
    wire [7:0] dout0, dout1, dout2, dout3;
    wire out_of_range = addr0[11] || addr1[11] || addr2[11] || addr3[11];
    // --- 4 BRAMs ---
    blk_mem_gen_0 rom0 (.clka(clk_i), .ena(mem_ena), .wea(1'b0),
                        .addra(addr0[10:0]), .dina(8'b0), .douta(dout0));
    blk_mem_gen_0 rom1 (.clka(clk_i), .ena(mem_ena), .wea(1'b0),
                        .addra(addr1[10:0]), .dina(8'b0), .douta(dout1));
    blk_mem_gen_0 rom2 (.clka(clk_i), .ena(mem_ena), .wea(1'b0),
                        .addra(addr2[10:0]), .dina(8'b0), .douta(dout2));
    blk_mem_gen_0 rom3 (.clka(clk_i), .ena(mem_ena), .wea(1'b0),
                        .addra(addr3[10:0]), .dina(8'b0), .douta(dout3));

    wire [31:0] instr_mem = {dout3, dout2, dout1, dout0};
    
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            pc_addr   <= RESET_PC;
            pc_dly    <= RESET_PC;
            pc_o      <= RESET_PC;
            instr_o   <= NOP_INSTR;
            valid_o   <= 1'b0;
            valid_dly <= 1'b0;
        end 
        else begin
            // =====================================================
            // 1. Handle FLUSH or BRANCH immediately
            // =====================================================
            if (flush_i | take_b_j_sig_i) begin
                pc_addr   <= take_b_j_sig_i ? pc_b_j_i : pc_addr; // jump or hold
                pc_dly    <= pc_addr;    // align pipeline
                instr_o   <= NOP_INSTR;  // mask stale instruction
                valid_o   <= 1'b0;
                valid_dly <= 1'b0;
            end 
            // =====================================================
            // 2. Normal sequential issue
            // =====================================================
            else if (~stall_i) begin
                // Issue new PC to memory
                pc_addr <= pc_addr + 32'd4;
                pc_dly  <= pc_addr;

                // Receive BRAM output (1-cycle latency)
                instr_o <= instr_mem;       // Load instruction from BRAM
                pc_o    <= pc_dly;          // Use delayed PC

                // valid follows memory latency
                valid_o   <= valid_dly;     // Valid signal follows previous valid state
                valid_dly <= 1'b1 && ~out_of_range;          // Set valid for the next cycle
            end 
            // =====================================================
            // 3. Stalled cycle (no new issue)
            // =====================================================
            else begin
                // Hold current state
                pc_addr   <= pc_addr;
                pc_dly    <= pc_dly;
                instr_o   <= instr_o;
                pc_o      <= pc_o;
                valid_o   <= 1'b0; // not valid when stalled
                valid_dly <= 1'b0;
            end
        end
    end
    
endmodule
