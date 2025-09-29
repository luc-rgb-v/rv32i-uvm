`timescale 1ns/1ps
// ============================================================================
// IF stage (RV32I, standalone)
// - Byte-addressed PC register (word-aligned for base RV32I)
// - pc_next = (take_b_j_sig_i ? pc_b_j_i : pc_plus_4)
// - Interfaces to external IMEM: addr/en out, instruction in
// - IF/ID pipeline register with stall/flush; auto-flush on taken branch/jump
// ============================================================================
module if_stage_core(
    input  wire        clk_i,
    input  wire        rst_i,

    // Pipeline control
    input  wire        stall_i,          // hold PC and IF/ID
    input  wire        flush_i,          // external flush (e.g., trap)
    input  wire        take_b_j_sig_i,   // branch/jump taken (from EX)
    input  wire [31:0] pc_b_j_i,         // branch/jump target (byte address)

    // ---- Instruction memory interface (to be wrapped externally) ----
    output wire        imem_en_o,        // fetch enable (freeze when 0)
    output wire [31:0] imem_addr_o,      // BYTE address (PC)
    input  wire [31:0] instr_d_i,        // fetched instruction (1-cycle after addr)

    // ---- IF/ID pipeline register outputs ----
    output reg  [31:0] if_id_pc_o,       // PC of fetched instruction
    output reg  [31:0] if_id_instr_o,    // fetched instruction
    output reg         if_id_valid_o,    // 1 when IF/ID holds a valid instr

    // (optional) expose current PC
    output wire [31:0] pc_o
);

    // --------------------------
    // PC register & next-PC mux
    // --------------------------
    localparam [31:0] RESET_PC = 32'h0000_0000;
    localparam [31:0] NOP_WORD = 32'h0000_0013;
    reg  [31:0] pc_q;
    wire [31:0] pc_plus_4 = pc_q + 32'd4;

    // Your exact mux:
    wire [31:0] pc_next = take_b_j_sig_i ? pc_b_j_i : pc_plus_4;

    // Drive IMEM (registered-address, 1-cycle latency style)
    assign imem_en_o   = ~stall_i;
    assign imem_addr_o = pc_q;     // byte address
    assign pc_o        = pc_q;

    // PC update
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            pc_q <= RESET_PC;
        end else if (!stall_i) begin
            pc_q <= pc_next;  // base RV32I assumes word-aligned PC
        end
        // else: hold on stall
    end

    // --------------------------
    // IF/ID pipeline register
    // Note: instr_d_i corresponds to the instruction for the *previous* PC
    // (because IMEM is 1-cycle via registered address).
    // --------------------------
    wire flush_ifid_w = flush_i | take_b_j_sig_i;  // squash wrong-path

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            if_id_instr_o <= NOP_WORD;
            if_id_pc_o    <= RESET_PC;
            if_id_valid_o <= 1'b0;
        end else if (flush_ifid_w) begin
            if_id_instr_o <= NOP_WORD;
            if_id_pc_o    <= pc_q;      // value not used when invalid
            if_id_valid_o <= 1'b0;
        end else if (!stall_i) begin
            if_id_instr_o <= instr_d_i; // instruction for PC from previous cycle
            if_id_pc_o    <= pc_q;      // PC tag for that instruction
            if_id_valid_o <= 1'b1;
        end
        // else: hold on stall
    end

endmodule
