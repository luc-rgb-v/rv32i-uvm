`timescale 1ns/1ps
// ============================================================================
// Minimal RV32I core top (IF → ID → EX → MEM → WB)
// - IF: if_stage_core + instr_mem_sync_addr
// - ID: your id_stage (control + RF + ID/EX regs)
// - EX: your ex_stage_top (ALU + branch/jump + forwarding)
// - MEM: mem_stage (pipeline reg only) + data_mem_rv32i (byte-addressed)
// - WB: wb_stage (select ALU/MEM/PC+4 and write back)
// Notes:
//   * Hazard/branch flushes are minimal: IF self-flushes on taken branch,
//     ID/MEM flushes are currently tied low. Add your hazard unit to drive them.
// ============================================================================
module rv32i_core_top (
    input  wire clk_i,
    input  wire rst_i,
    output wire [31:0] pc
);

    // =========================================================================
    // IF stage core + IMEM (registered address → 1-cycle fetch)
    // =========================================================================
    wire        if_imem_en;
    wire [31:0] if_imem_addr;
    wire [31:0] if_instr_d;

    wire [31:0] ifid_pc;
    wire [31:0] ifid_instr;
    wire        ifid_valid;

    // Redirect from EX
    wire        ex_bj_taken;
    wire [31:0] ex_pc_bj;

    // =====================================================================
    // Wires for hazard_control_unit
    // =====================================================================
    
    // IDs
    wire [4:0]  id_rs1_addr_i_w;
    wire [4:0]  id_rs2_addr_i_w;
    
    // Control outs
    wire        stall_if_o_w;
    wire        stall_id_o_w;
    wire        flush_id_ex_o_w;

    wire idex_valid;
    wire exmem_valid;

    // WB feedback to RF
    wire        wb_rf_we;
    wire [4:0]  wb_rf_rd_addr;
    wire [31:0] wb_rf_wdata;

    // ID/EX outputs (to EX)
    wire [31:0] idex_imm;
    wire        idex_regwrite;
    wire [4:0]  idex_rd_addr;
    wire        idex_jal;
    wire        idex_jalr;
    wire        idex_alusrc;
    wire [3:0]  idex_aluop;

    wire        idex_memread;
    wire        idex_memwrite;
    wire [2:0]  idex_width_sel;
    wire [1:0]  idex_memtoreg;

    wire [31:0] idex_rs1_data;
    wire [31:0] idex_rs2_data;
    wire [31:0] idex_pc;

    wire [4:0]  idex_rs1_addr;
    wire [4:0]  idex_rs2_addr;

    // EX outputs to MEM
    wire [31:0] ex_alu_result;
    wire [31:0] ex_store_data;
    wire [31:0] ex_pc_address_o;

    wire        ex_regwrite;
    wire [4:0]  ex_rd_addr;
    wire [1:0]  ex_memtoreg;
    wire        ex_memread;
    wire        ex_memwrite;
    wire [2:0]  ex_width_sel;

    wire [31:0] dmem_rdat;

    wire        mem_regwrite;
    wire [4:0]  mem_rd_addr;
    wire [1:0]  mem_memtoreg;
    wire [31:0] mem_pc;
    wire [31:0] mem_alu_result;
    wire [31:0] mem_data_to_wb;

    // =====================================================================
    // Instantiation
    // =====================================================================
    hazard_control_unit u_hazard_control_unit (
        .id_valid_i     (idex_valid),
        .id_rs1_addr_i  (id_rs1_addr_i_w),
        .id_rs2_addr_i  (id_rs2_addr_i_w),

        .ex_valid_i     (exmem_valid),
        .ex_rd_addr_i   (ex_rd_addr),
        .ex_memread_i   (ex_memread),
        .ex_take_b_j_i  (ex_bj_taken),

        .stall_if_o     (stall_if_o_w),
        .stall_id_o     (stall_id_o_w),
        .flush_id_ex_o  (flush_id_ex_o_w)
    );

    if_stage_core u_if_core (
        .clk_i          (clk_i),
        .rst_i          (rst_i),
        .stall_i        (stall_if_o_w),
        .flush_i        (1'b0),              // IF self-flushes on take_b_j_sig_i
        .take_b_j_sig_i (ex_bj_taken),
        .pc_b_j_i       (ex_pc_bj),

        .imem_en_o      (if_imem_en),
        .imem_addr_o    (if_imem_addr),
        .instr_d_i      (if_instr_d),

        .if_id_pc_o     (ifid_pc),
        .if_id_instr_o  (ifid_instr),
        .if_valid_o     (ifid_valid),

        .pc_o           (pc)  // Debug
    );

    // Instruction memory (registered address)
    instr_mem_sync_addr u_imem (
        .clk     (clk_i),
        .en      (if_imem_en),
        .addr    (if_imem_addr),
        .instr_d (if_instr_d),
        .dontuse ()
    );

    // =========================================================================
    // ID stage (control + register file + ID/EX regs)

    id_stage u_id (
        .clk_i                   (clk_i),
        .rst_i                   (rst_i),

        .flush_i                 (flush_id_ex_o_w),
        .stall_i                 (stall_id_o_w),

        .instruction_i           (ifid_instr),
        .pc_address_i            (ifid_pc),
        .if_valid_i              (ifid_valid),

        // WB feedback
        .wb_regwrite_i           (wb_rf_we),
        .wb_rd_addr_i            (wb_rf_rd_addr),
        .wb_wdata_i              (wb_rf_wdata),

        // ID/EX outs
        .imm_o                   (idex_imm),
        .regwrite_o              (idex_regwrite),
        .rd_addr_o               (idex_rd_addr),
        .jal_o                   (idex_jal),
        .jalr_o                  (idex_jalr),
        .alusrc_o                (idex_alusrc),
        .aluop_o                 (idex_aluop),
        .csr_addr_o              (),
        .zimm_o                  (),

        .memread_o               (idex_memread),
        .memwrite_o              (idex_memwrite),
        .width_select_o          (idex_width_sel),
        .memtoreg_o              (idex_memtoreg),

        .operand_a_o             (idex_rs1_data),
        .operand_b_o             (idex_rs2_data),
        .pc_address_o            (idex_pc),

        .valid_m_instruction_o   (),
        .id_valid_o              (idex_valid),

        .rs1_addr_o              (idex_rs1_addr),
        .rs2_addr_o              (idex_rs2_addr),
        .rs1_addr_w              (id_rs1_addr_i_w),
        .rs2_addr_w              (id_rs2_addr_i_w)
    );

    // =========================================================================
    // EX stage (ALU + branch/jump + forwarding)

    ex_stage_top u_ex (
        .clk_i                     (clk_i),
        .rst_i                     (rst_i),
        .stall_i                   (1'b0),
        .flush_i                   (1'b0),

        .jal_i                     (idex_jal),
        .jalr_i                    (idex_jalr),
        .aluop_i                   (idex_aluop),
        .alusrc_i                  (idex_alusrc),
        .operand_a_i               (idex_rs1_data),
        .operand_b_i               (idex_rs2_data),
        .imm_i                     (idex_imm),
        .pc_address_i              (idex_pc),

        .regwrite_i                (idex_regwrite),
        .rd_addr_i                 (idex_rd_addr),
        .memtoreg_i                (idex_memtoreg),
        .memread_i                 (idex_memread),
        .memwrite_i                (idex_memwrite),
        .width_select_i            (idex_width_sel),
        .rs1_addr_i                (idex_rs1_addr),
        .rs2_addr_i                (idex_rs2_addr),

        // Forwarding/bypass sources
        .alu_EX_MEM_i              (ex_alu_result),
        .mem_EX_MEM_i              (dmem_rdat),
        .alu_MEM_WB_i              (mem_alu_result),
        .mem_MEM_WB_i              (mem_data_to_wb),

        // Producer meta (from later stages)
        .reg_file_write_EX_MEM_i         (ex_regwrite),
        .reg_file_write_address_EX_MEM_i (ex_rd_addr),
        .mux_0_sel_EX_MEM_i              (ex_memtoreg),

        .reg_file_write_MEM_WB_i         (mem_regwrite),
        .reg_file_write_address_MEM_WB_i (mem_rd_addr),
        .mux_0_sel_MEM_WB_i              (mem_memtoreg),
        .id_valid_i             (idex_valid),

        // Outputs
        .alu_result_o              (ex_alu_result),
        .store_data_o              (ex_store_data),
        .pc_b_j_o                  (ex_pc_bj),
        .b_j_taken_o               (ex_bj_taken),

        .regwrite_o                (ex_regwrite),
        .rd_addr_o                 (ex_rd_addr),
        .memtoreg_o                (ex_memtoreg),
        .memread_o                 (ex_memread),
        .memwrite_o                (ex_memwrite),
        .width_select_o            (ex_width_sel),
        .pc_address_o              (ex_pc_address_o),
        .ex_valid_o                (exmem_valid)
    );

    mem_stage u_mem (
        .clk_i         (clk_i),
        .rst_i         (rst_i),
        .flush_i       (1'b0),
        .stall_i       (1'b0),

        .regwrite_i    (ex_regwrite),
        .rd_addr_i     (ex_rd_addr),
        .memtoreg_i    (ex_memtoreg),
        .pc_address_i  (ex_pc_address_o),
        .alu_result_i  (ex_alu_result),
        .ex_valid_i    (exmem_valid),

        .data_memory_i (dmem_rdat),

        .regwrite_o    (mem_regwrite),
        .rd_addr_o     (mem_rd_addr),
        .memtoreg_o    (mem_memtoreg),
        .pc_address_o  (mem_pc),
        .alu_result_o  (mem_alu_result),
        .data_mem_o    (mem_data_to_wb)
    );

    data_mem_rv32i u_dmem (
        .clk       (clk_i),
        .we        (ex_memwrite),
        .re        (ex_memread),
        .width_sel (ex_width_sel),
        .addr      (ex_alu_result[8:0]),
        .wdata     (ex_store_data),
        .rdata     (dmem_rdat)
    );

    wb_stage u_wb (
        .regwrite_i   (mem_regwrite),
        .rd_addr_i    (mem_rd_addr),
        .alu_result_i (mem_alu_result),
        .data_mem_i   (mem_data_to_wb),
        .pc_address_i (mem_pc + 4),
        .wb_sel_i     (mem_memtoreg),

        .regwrite_o   (wb_rf_we),
        .rd_addr_o    (wb_rf_rd_addr),
        .wb_data_o    (wb_rf_wdata)
    );

endmodule
