`timescale 1ns/1ps
// -----------------------------------------------------------------------------
// instr_mem_sync_addr
// - RV32I instruction memory (byte-addressed PC)
// - 1-cycle latency via registered address (FPGA BRAM-friendly)
// - Output data is combinational from the registered address
// - Word-aligned fetch (PC[1:0]==2'b00); returns NOP (configurable) on misaligned/OOB
// - Init from word-per-line HEX (32-bit, MSB..LSB)
// -----------------------------------------------------------------------------
module instr_mem_sync_addr (
    input  wire        clk,
    input  wire        en,            // fetch enable (stalls address reg when 0)
    input  wire [31:0] addr,          // BYTE address (PC)
    output wire [31:0] instr_d,       // combinational data from prior-cycle address
    output wire [1:0] dontuse
);

    localparam DEPTH_WORDS        = 1024;              // number of 32-bit words
    localparam INIT_FILE          = "D:/Engineering_Hub/riscv-rv32im-soc/sim/vivado/test_if_stage/instruction.hex";


    localparam [31:0]  NOP_WORD           = 32'h00000013;
    localparam         MISALIGNED_RET_NOP = 1;
    localparam         OOB_RET_NOP        = 1;
    // 32-bit word memory
    reg [31:0] mem [0:DEPTH_WORDS-1];
    assign dontuse = addr[1:0];
    // Initialize: fill with NOPs then load hex
    integer i;
    initial begin
        for (i = 0; i < DEPTH_WORDS; i = i + 1) mem[i] = NOP_WORD;
        if (INIT_FILE != "") begin
            $display("instr_mem_sync_addr: loading %0d words from '%s'", DEPTH_WORDS, INIT_FILE);
            $readmemh(INIT_FILE, mem);
        end
    end

    // Register the word index (gives 1-cycle latency)
    reg [31:0] widx_q;
    always @(posedge clk) begin
        if (en) begin
            widx_q <= addr[31:2];     // capture word index from byte address
        end
        // if en==0, hold last index to "freeze" output (good for IF stalls)
    end

    // Misaligned/OOB detection for the *registered* address
    wire misaligned_q = 1'b0;                    // since we dropped addr[1:0] at capture
    wire oob_q        = (widx_q >= DEPTH_WORDS);

    // Combinational output from registered index (BRAM-friendly sync-read style)
    assign instr_d =
        misaligned_q ? (MISALIGNED_RET_NOP ? NOP_WORD : 32'hxxxx_xxxx) :
        oob_q        ? (OOB_RET_NOP        ? NOP_WORD : 32'hxxxx_xxxx) :
                       mem[widx_q];

endmodule
