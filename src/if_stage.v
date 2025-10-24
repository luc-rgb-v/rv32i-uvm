`timescale 1ns/1ps
module if_stage (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire        stall_i,
    input  wire        flush_i,
    input  wire        take_bj_sig_i,
    input  wire [31:0] pc_bj_i,
    output reg  [31:0] instr_o,
    output reg  [31:0] pc_o,
    output reg         valid_o
);

    // =============================================================
    // Parameters
    // =============================================================
    localparam RESET_PC  = 32'h00000000;
    localparam NOP_INSTR = 32'h00000013;

    // =============================================================
    // Internal registers
    // =============================================================
    reg [31:0] pc_addr;       // current PC
    reg [31:0] pc_dly;        // delayed one cycle (for pipeline align)
    reg        valid_dly;

    // =============================================================
    // BRAM enable & address mapping
    // =============================================================
    wire mem_ena = ~stall_i & ~flush_i;

    // word-aligned address (since instructions are 4 bytes each)
    wire [12:0] addr_word = pc_addr[14:2]; // use upper bits, discard byte offset

    // =============================================================
    // 32-bit instruction memory (1-cycle latency BRAM)
    // =============================================================
    wire [31:0] instr_mem;

    instruction_mem rom_inst (
        .clka   (clk_i),
        .ena    (mem_ena),
        .wea    (4'b0),
        .addra  (addr_word),
        .dina   (32'b0),
        .douta  (instr_mem)
    );

    // =============================================================
    // Sequential logic
    // =============================================================
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            pc_addr   <= RESET_PC;
            pc_dly    <= RESET_PC;
            pc_o      <= RESET_PC;
            instr_o   <= NOP_INSTR;
            valid_o   <= 1'b0;
            valid_dly <= 1'b0;
        end else begin
            // -----------------------------------------------------
            // 1. Handle FLUSH or BRANCH immediately
            // -----------------------------------------------------
            if (flush_i | take_bj_sig_i) begin
                pc_addr   <= take_bj_sig_i ? pc_bj_i : pc_addr;
                pc_dly    <= pc_addr;
                instr_o   <= NOP_INSTR;
                valid_o   <= 1'b0;
                valid_dly <= 1'b0;
            end 
            // -----------------------------------------------------
            // 2. Normal sequential issue
            // -----------------------------------------------------
            else if (~stall_i) begin
                // Issue next PC
                pc_addr <= pc_addr + 32'd4;
                pc_dly  <= pc_addr;

                // Receive BRAM output (1-cycle latency)
                instr_o <= instr_mem;
                pc_o    <= pc_dly;

                // Valid timing control
                valid_o   <= valid_dly;
                valid_dly <= 1'b1;
            end 
            // -----------------------------------------------------
            // 3. Stall
            // -----------------------------------------------------
            else begin
                pc_addr   <= pc_addr;
                pc_dly    <= pc_dly;
                instr_o   <= instr_o;
                pc_o      <= pc_o;
                valid_o   <= 1'b0;
                valid_dly <= 1'b0;
            end
        end
    end

endmodule
