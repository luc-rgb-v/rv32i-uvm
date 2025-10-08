`timescale 1ns/1ps

// =====================================================================
// EX Stage Top (with EX/MEM pipeline registers inside)
// - Verilog-2001
// - Forwarding from EX/MEM and MEM/WB (ALU, MEM/PC+4)
// - Uses forwarded A for JALR target calc
// - Latches all MEM/WB controls to EX/MEM
// =====================================================================
module ex_stage_top (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire        stall_i,
    input  wire        flush_i,

    // From ID/EX pipeline (registered ID outputs)
    input  wire        jal_i,
    input  wire        jalr_i,
    input  wire [3:0]  aluop_i,
    input  wire        alusrc_i,
    input  wire [31:0] operand_a_i,      // rs1 data
    input  wire [31:0] operand_b_i,      // rs2 data
    input  wire [31:0] imm_i,
    input  wire [31:0] pc_address_i,
    input  wire        regwrite_i,
    input  wire [4:0]  rd_addr_i,
    input  wire [1:0]  memtoreg_i,       // 00=ALU, 01=MEM, 10=PC+4
    input  wire        memread_i,
    input  wire        memwrite_i,
    input  wire [2:0]  width_select_i,
    input  wire [4:0]  rs1_addr_i,       // for forwarding matches
    input  wire [4:0]  rs2_addr_i,       // for forwarding matches

    // Bypass buses from EX/MEM and MEM/WB (producers)
    input  wire [31:0] alu_EX_MEM_i,     // ALU result from EX/MEM
    input  wire [31:0] mem_EX_MEM_i,     // MEM data or PC+4 (per memtoreg of EX/MEM)
    input  wire [31:0] alu_MEM_WB_i,     // ALU result from MEM/WB
    input  wire [31:0] mem_MEM_WB_i,     // MEM data or PC+4 (per memtoreg of MEM/WB)

    // Producer meta for forwarding decisions
    input  wire        reg_file_write_EX_MEM_i,
    input  wire [4:0]  reg_file_write_address_EX_MEM_i,
    input  wire [1:0]  mux_0_sel_EX_MEM_i,     // memtoreg of EX/MEM producer

    input  wire        reg_file_write_MEM_WB_i,
    input  wire [4:0]  reg_file_write_address_MEM_WB_i,
    input  wire [1:0]  mux_0_sel_MEM_WB_i,     // memtoreg of MEM/WB producer
    input  wire id_valid_i,

    // -----------------------------------------------------------------
    // EX/MEM registered outputs (to MEM stage and for forwarding taps)
    // -----------------------------------------------------------------
    output reg  [31:0] alu_result_o,
    output reg  [31:0] store_data_o,     // forwarded RS2 value (pre-imm), for stores
    output reg  [31:0] pc_b_j_o,         // branch/jump target addr
    output reg         b_j_taken_o,      // branch or jump taken

    output reg         regwrite_o,
    output reg  [4:0]  rd_addr_o,
    output reg  [1:0]  memtoreg_o,
    output reg         memread_o,
    output reg         memwrite_o,
    output reg  [2:0]  width_select_o,
    output reg  [31:0] pc_address_o,
    output reg         ex_valid_o

);

    // Forwarding control
    wire [2:0] fwd0_sel_w;
    wire [2:0] fwd1_sel_w;

    forwarding_unit u_forwarding_unit (
        .reg_file_read_address_0_ID_EXE (rs1_addr_i),
        .reg_file_read_address_1_ID_EXE (rs2_addr_i),

        .reg_file_write_EX_MEM          (reg_file_write_EX_MEM_i),
        .reg_file_write_address_EX_MEM  (reg_file_write_address_EX_MEM_i),
        .mux_0_sel_EX_MEM               (mux_0_sel_EX_MEM_i),

        .reg_file_write_MEM_WB          (reg_file_write_MEM_WB_i),
        .reg_file_write_address_MEM_WB  (reg_file_write_address_MEM_WB_i),
        .mux_0_sel_MEM_WB               (mux_0_sel_MEM_WB_i),

        .forward_mux_0_control          (fwd0_sel_w),
        .forward_mux_1_control          (fwd1_sel_w)
    );

    // 5→1 Forward muxes (A and B pre-imm)
    // a=from regfile(ID/EX), b=EX/MEM.ALU, c=EX/MEM.MEM/PC+4, d=MEM/WB.ALU, e=MEM/WB.MEM/PC+4
    wire [31:0] fwd_a_w;
    wire [31:0] fwd_b_w;  // rs2 forwarded value (used as store data)

    mux_5to1 u_mux_5to1_a (
        .a_i (operand_a_i),
        .b_i (alu_EX_MEM_i),
        .c_i (mem_EX_MEM_i),
        .d_i (alu_MEM_WB_i),
        .e_i (mem_MEM_WB_i),
        .se_i(fwd0_sel_w),
        .y_o (fwd_a_w)
    );

    mux_5to1 u_mux_5to1_b (
        .a_i (operand_b_i),
        .b_i (alu_EX_MEM_i),
        .c_i (mem_EX_MEM_i),
        .d_i (alu_MEM_WB_i),
        .e_i (mem_MEM_WB_i),
        .se_i(fwd1_sel_w),
        .y_o (fwd_b_w)
    );

    // ALU operand B select (imm vs forwarded rs2)
    wire [31:0] alu_op_b_w;

    mux_2to1 u_mux_2to1_b (
        .a_i (fwd_b_w),
        .b_i (imm_i),
        .se_i(alusrc_i),
        .y_o (alu_op_b_w)
    );

    // ALU produces result + branch_taken (for BEQ/BNE/BLT/BGE/BLTU/BGEU)
    wire [31:0] alu_result_w;
    wire        alu_branch_taken_w;

    alu_rv32i u_alu_rv32i (
        .a           (fwd_a_w),
        .b           (alu_op_b_w),
        .alu_op      (aluop_i),
        .result      (alu_result_w),
        .branch_taken(alu_branch_taken_w)
    );

    // Branch/Jump target calculation
    // - use forwarded A for JALR (rs1 + imm)
    // - JAL uses PC + imm (handled in this block)
    wire [31:0] pc_b_j_w;

    branch_jump_calculation u_branch_jump_calculation (
        .pc_i       (pc_address_i),
        .rs_1_i     (fwd_a_w),      // forwarded RS1 for JALR
        .imm_i      (imm_i),
        .jalr_sig_i (jalr_i),
        .pc_b_j_o   (pc_b_j_w)
    );

    // final taken flag
    wire b_j_taken_w = alu_branch_taken_w | jal_i | jalr_i;

    // -----------------------------------------------------------------
    // EX/MEM pipeline registers
    // -----------------------------------------------------------------
    task flush_regs;
    begin
        alu_result_o   <= 32'b0;
        store_data_o   <= 32'b0;
        pc_b_j_o       <= 32'b0;
        b_j_taken_o    <= 1'b0;

        regwrite_o     <= 1'b0;
        rd_addr_o      <= 5'b0;
        memtoreg_o     <= 2'b0;
        memread_o      <= 1'b0;
        memwrite_o     <= 1'b0;
        width_select_o <= 3'b0;
        pc_address_o   <= 32'b0;
        ex_valid_o     <= 1'b0;
    end
    endtask

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            flush_regs();
        end else if (flush_i) begin
            // bubble for EX/MEM
            flush_regs();
        end else if (~stall_i) begin
            // data/results
            alu_result_o   <= alu_result_w;
            store_data_o   <= fwd_b_w;       // rs2 after forwarding (before imm)
            pc_b_j_o       <= pc_b_j_w;
            b_j_taken_o    <= b_j_taken_w;

            // pass-through controls to MEM/WB
            regwrite_o     <= regwrite_i;
            rd_addr_o      <= rd_addr_i;
            memtoreg_o     <= memtoreg_i;
            memread_o      <= memread_i;
            memwrite_o     <= memwrite_i;
            width_select_o <= width_select_i;
            pc_address_o   <= pc_address_i;
            ex_valid_o     <= id_valid_i;
        end
        // else: hold on stall
    end

endmodule
