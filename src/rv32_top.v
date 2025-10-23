`timescale 1ns/1ps
// ============================================================================
// Minimal RV32I core top (IF → ID → EX → MEM → WB)
// - IF: if_stage_core + instr_mem_sync_addr
// - ID: your id_stage (control + RF + ID/EX regs)
// - EX: your ex_stage_top (ALU + branch/jump + forwarding)
// - MEM: mem_stage (pipeline reg only) + data_mem_rv32i (byte-addressed)
// - WB: wb_stage (select ALU/MEM/PC+4 and write back)
// Notes:
// - Notes
// ============================================================================

`define DEBUG_MODE

`define DEBUG_IF
//`define DEBUG_ID
//`define DEBUG_EX
//`define DEBUG_MEM
//`define DEBUG_WB

`ifdef DEBUG_MODE
    `ifdef DEBUG_IF
        `define IF_STAGE
    `endif
    `ifdef DEBUG_ID
        `define ID_STAGE
    `endif
    `ifdef DEBUG_EX
        `define EX_STAGE
    `endif
    `ifdef DEBUG_MEM
        `define MEM_STAGE
    `endif
    `ifdef DEBUG_WB
        `define WB_STAGE
    `endif
`endif

module rv32i_top (
`ifdef DEBUG_MODE
    output wire [31:0] pc,
    `ifdef DEBUG_IF

    `endif
    `ifdef DEBUG_ID

    `endif
`endif
    input wire clk_i,
    input wire rst_i
);

`ifdef IF_STAGE
    `define CONTROL_FLUSH_STALL
    `ifdef CONTROL_FLUSH_STALL
        wire stall_if_w;
        wire flush_if_w;
    `endif

    wire [31:0] ifid_pc_w;
    wire [31:0] ifid_instr_w;
    wire        ifid_valid_w;
`endif

`ifdef ID_STAGE
    `ifdef CONTROL_FLUSH_STALL
        wire flush_id_w;
        wire stall_id_w;
    `endif

    wire        idex_jal_w;
    wire        idex_jalr_w;
    wire        idex_se_rs1_pc_w;
    wire        idex_se_rs2_imm_w;
    wire [3:0]  idex_aluop_w;
    
    wire [31:0] idex_rs1_data_w;
    wire [31:0] idex_rs2_data_w;
    wire [31:0] idex_imm_w;
    wire [4:0]  idex_rs1_addr_w;
    wire [4:0]  idex_rs2_addr_w;

    wire        idex_memread_w;
    wire        idex_memwrite_w;
    wire [2:0]  idex_width_select_w;

    wire        idex_regwrite_w;
    wire [4:0]  idex_rd_addr_w;
    wire [1:0]  idex_memtoreg_w;

    wire [31:0] idex_pc_w;
    wire        idex_valid_w;

    `ifdef DEBUG_ID
        wire valid_m_instruction_w;
        wire csr_addr_w;
        wire zimm_w;
    `endif
`endif

`ifdef EX_STAGE
    `ifdef CONTROL_FLUSH_STALL
        wire flush_ex_w;
        wire stall_ex_w;
    `endif
    `ifdef MUX_5SELECT
        wire [31:0] ex_alu_result_w;
        wire [31:0] dmem_rdat_w;
        wire [31:0] mem_alu_result_w;
        wire [31:0] mem_data_to_wb_w;
    `endif
    `ifdef FORWARDING_UNIT
        wire       ex_regwrite_w;
        wire [4:0] ex_rd_addr_w;
        wire       ex_memtoreg_w;
        wire       mem_regwrite_w;
        wire [4:0] mem_rd_addr_w;
        wire       mem_memtoreg_w;
    `endif

    wire        exif_bj_sig_w;
    wire [31:0] exif_pc_bj_w;
    wire [31:0] exmem_alu_result_w;
    wire [31:0] exmem_store_data_w;

    wire        exmem_memread_w;
    wire        exmem_memwrite_w;
    wire [2:0]  exmem_width_select_w;

    wire        exmem_regwrite_w;
    wire [4:0]  exmem_rd_addr_w;
    wire [1:0]  exmem_memtoreg_w;
    wire [31:0] exmem_pc_w;
    
    wire        exmem_valid_w;
`endif

`ifdef MEM_STAGE
    `ifdef CONTROL_FLUSH_STALL
        wire flush_mem_w;
        wire stall_mem_w;
    `endif

    wire        memwb_mem_data_w;
    wire [31:0] memwb_alu_result_w;
    wire [31:0] memwb_rd_addr_w;
    wire [31:0] memwb_memtoreg_w;
    wire        memwb_pc_w;
    wire        memwb_valid_w;

    `ifdef DEBUG_MEM

    `endif
`endif

`ifdef WB_STAGE
    wire        wbrf_regwrite_w;
    wire [4:0]  wbrf_rd_addr_w;
    wire [31:0] wbrf_wdata_w;

    `ifdef DEBUG_WB

    `endif
`endif 

//========= define module =========
`ifdef IF_STAGE
    if_stage u_if (
        .clk_i (clk_i),
        .rst_i (rst_i),

    `ifdef DEBUG_IF
        .stall_i (stall_if_w),
        .flush_i (flush_if_w),
    `else
        .stall_i (0),
        .flush_i (0),    
    `endif

        .take_bj_sig_i (exif_bj_sig_w),
        .pc_bj_i       (exif_pc_bj_w),

        .instr_o        (ifid_instr_w),
        .pc_o           (ifid_pc_w),
        .valid_o        (ifid_valid_w)
    );
`endif

`ifdef ID_STAGE
    id_stage u_id (
        .clk_i   (clk_i),
        .rst_i   (rst_i),

    `ifdef CONTROL_FLUSH_STALL
        .flush_i (flush_id_w),
        .stall_i (stall_id_w),
    `else
        .flush_i (0),
        .stall_i (0),
    `endif

        .instruction_i  (ifid_instr_w),
        .pc_address_i   (ifid_pc_w),
        .if_valid_i     (ifid_valid_w),

        .wb_regwrite_i  (wbrf_regwrite_w),
        .wb_rd_addr_i   (wbrf_rd_addr_w),
        .wb_wdata_i     (wbrf_wdata_w),

        .jal_o          (idex_jal_w),
        .jalr_o         (idex_jalr_w),
        .se_rs1_pc_o    (idex_se_rs1_pc_w),
        .se_rs2_imm_o   (idex_se_rs2_imm_w),
        .aluop_o        (idex_aluop_w),

        .rs1_data_o     (idex_rs1_data_w),
        .rs2_data_o     (idex_rs2_data_w),
        .imm_o          (idex_imm_w),
        .rs1_addr_o     (idex_rs1_addr_w),
        .rs2_addr_o     (idex_rs2_addr_w),

        .memread_o      (idex_memread_w),
        .memwrite_o     (idex_memwrite_w),
        .width_select_o (idex_width_select_w),

        .regwrite_o     (idex_regwrite_w),
        .rd_addr_o      (idex_rd_addr_w),
        .wb_sel_o       (idex_memtoreg_w),
    // ID bypass
        .pc_address_o   (idex_pc_w),
    // End bypass
        .id_valid_o     (idex_valid_w),

    `ifdef DEBUG_ID
        .valid_m_instruction_o (valid_m_instruction_w),
        .csr_addr_o            (csr_addr_w),
        .zimm_o                (zimm_w)
    `else
        .valid_m_instruction_o (),
        .csr_addr_o            (),
        .zimm_o                ()
    `endif
    );
`endif

`ifdef EX_STAGE
    ex_stage u_ex (
        .clk_i   (clk_i),
        .rst_i   (rst_i),

    `ifdef CONTROL_FLUSH_STALL
        .stall_i (stall_ex_w),
        .flush_i (flush_ex_w),
    `else
        .stall_i (1'b0),
        .flush_i (1'b0),
    `endif
    // Input from ID
        .jal_i          (idex_jal_w),
        .jalr_i         (idex_jalr_w),
        .se_rs1_pc_i    (idex_se_rs1_pc_w),
        .se_rs2_imm_i   (idex_se_rs2_imm_w),
        .aluop_i        (idex_aluop_w),
        .operand_a_i    (idex_rs1_data_w),
        .operand_b_i    (idex_rs2_data_w),
        .imm_i          (idex_imm_w),
        .rs1_addr_i     (idex_rs1_addr_w),
        .rs2_addr_i     (idex_rs2_addr_w),
        .memread_i      (idex_memread_w),
        .memwrite_i     (idex_memwrite_w),
        .width_select_i (idex_width_select_w),
        .regwrite_i     (idex_regwrite_w),
        .rd_addr_i      (idex_rd_addr_w),
        .wb_sel_i       (idex_memtoreg_w),
        .pc_address_i   (idex_pc_w),
        .id_valid_i     (idex_valid_w),
    // End input
    `ifdef FORWARDING_UNIT_ACTIVITY
        .b (b),
        .c (c),
        .d (d),
        .e (e),
    `else
        .b (32'b0),
        .c (32'b0),
        .d (32'b0),
        .e (32'b0),
    `endif
    // Output EX stage
        .b_j_sig_o      (exif_bj_sig_w),
        .pc_b_j_o       (exif_pc_bj_w),
        .alu_result_o   (exmem_alu_result_w),
        .store_data_o   (exmem_store_data_w),
    // End output EX stage
    // Bypass
        .memread_o      (exmem_memread_w),
        .memwrite_o     (exmem_memwrite_w),
        .width_select_o (exmem_width_select_w),
        .regwrite_o     (exmem_regwrite_w),
        .rd_addr_o      (exmem_rd_addr_w),
        .wb_sel_o       (exmem_memtoreg_w),
        .pc_address_o   (exmem_pc_w),
    // End bypass
        .ex_valid_o     (exmem_valid_w)
    );
`endif
    
`ifdef MEM_STAGE
    mem_stage u_mem (
        .clk_i (clk_i),
        .rst_i (rst_i),

    `ifdef  CONTROL_FLUSH_STALL
        .flush_i (flush_mem_w),
        .stall_i (stall_mem_w),
    `else
        .stall_i (1'b0),
        .flush_i (1'b0),
    `endif

        .alu_result_i   (exmem_alu_result_w),
        .store_data_i   (exmem_store_data_w),

        .memread_i      (exmem_memread_w),
        .memwrite_i     (exmem_memwrite_w),
        .width_select_i (exmem_width_select_w),
        .regwrite_i     (exmem_regwrite_w),
        .rd_addr_i      (exmem_rd_addr_w),
        .wb_sel_i       (exmem_memtoreg_w),
        .pc_address_i   (exmem_pc_w),
        .ex_valid_i     (exmem_valid_w),
    // MEM out
        .mem_data_o     (memwb_mem_data_w),
    // End MEM
    // Bypass
        .alu_result_o   (memwb_alu_result_w),
        .regwrite_o     (memwb_regwrite_w),
        .rd_addr_o      (memwb_rd_addr_w),
        .wb_sel_o       (memwb_memtoreg_w),
        .pc_address_o   (memwb_pc_w),
    // End bypass
        .mem_valid_o    (memwb_valid_w)
    );
`endif

`ifdef WB_STAGE
    wb_stage u_wb (
        .mem_data_i   (memwb_mem_data_w),
        .alu_result_i (memwb_alu_result_w),
        .regwrite_i   (memwb_regwrite_w),
        .rd_addr_i    (memwb_rd_addr_w),
        .wb_sel_i     (memwb_memtoreg_w),
        .pc_address_i (memwb_pc_w + 4),
        .mem_valid_i  (memwb_valid_w),

        .regwrite_o   (wbrf_regwrite_w),
        .rd_addr_o    (wbrf_rd_addr_w),
        .wb_data_o    (wbrf_wdata_w)
    );
`endif

endmodule
