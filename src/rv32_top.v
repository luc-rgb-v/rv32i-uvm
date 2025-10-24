`timescale 1ns/1ps
// ============================================================================
// Fixed RV32I core top (IF → ID → EX → MEM → WB)
// - Cleaned up widths, ifdef consistency, input/output assignments and constants
// - Assumes standard submodule port widths:
//   if_stage: instr_o[31:0], pc_o[31:0], valid_o
//   id_stage: various outputs listed in instantiation
//   ex_stage: b_j_sig_o, pc_b_j_o, alu_result_o, store_data_o, etc.
//   mem_stage: mem_data_o[31:0], alu_result_o[31:0], rd_addr_o[4:0], wb_sel_o[1:0], pc_address_o[31:0]
//   wb_stage: mem_data_i[31:0], alu_result_i[31:0], rd_addr_i[4:0], wb_sel_i[1:0], pc_address_i[31:0]
// ============================================================================
`define IF_STAGE
`define ID_STAGE
`define EX_STAGE
`define MEM_STAGE
`define WB_STAGE
//`define CONTROL_FLUSH_STALL

module rv32i_top (
    input wire clk_i,
    input wire rst_i
);

// -----------------------------------------------------------------------------
// CONTROL / PIPE SIGNALS
// -----------------------------------------------------------------------------
`ifdef DEBUG_IF
    wire exif_bj_sig_w;
    wire [31:0] exif_pc_bj_w;
`endif

`ifdef DEBUG_ID
    wire valid_m_instruction_w;
    wire [11:0] csr_addr_w; // example width for CSR addr
    wire [4:0] zimm_w;
`endif

`ifdef CONTROL_FLUSH_STALL
    wire stall_if_w;
    wire flush_if_w;
    wire flush_id_w;
    wire stall_id_w;
    wire flush_ex_w;
    wire stall_ex_w;
    wire flush_mem_w;
    wire stall_mem_w;
`endif

`ifdef IF_STAGE
    wire [31:0] ifid_pc_w;
    wire [31:0] ifid_instr_w;
    wire        ifid_valid_w;
`endif

`ifdef ID_STAGE
    wire        idex_jal_w;
    wire        idex_jalr_w;
    wire        idex_se_rs1_pc_w;
    wire        idex_se_rs2_imm_w;
    wire [3:0]  idex_aluop_w;
    
    wire [31:0] idex_rs1_data_w;
    wire [31:0] idex_rs2_data_w;
    wire [31:0] idex_imm_w;
    
`ifdef FORWARDING
    wire [4:0]  idex_rs1_addr_w;
    wire [4:0]  idex_rs2_addr_w;
`endif

    wire        idex_memread_w;
    wire        idex_memwrite_w;
    wire [2:0]  idex_width_select_w;

    wire        idex_regwrite_w;
    wire [4:0]  idex_rd_addr_w;
    wire [1:0]  idex_memtoreg_w;

    wire [31:0] idex_pc_w;
    wire        idex_valid_w;
`endif

`ifdef EX_STAGE
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
    // corrected widths
    wire [31:0] memwb_mem_data_w;
    wire [31:0] memwb_alu_result_w;
    wire [4:0]  memwb_rd_addr_w;
    wire [1:0]  memwb_memtoreg_w;
    wire [31:0] memwb_pc_w;
    wire        memwb_valid_w;
`endif

`ifdef WB_STAGE
    wire        wbrf_regwrite_w;
    wire [4:0]  wbrf_rd_addr_w;
    wire [31:0] wbrf_wdata_w;
`endif 

// -----------------------------------------------------------------------------
// CONNECT EXTERNAL DEBUG INPUTS TO INTERNAL WIRES (do NOT assign to inputs)
// -----------------------------------------------------------------------------
`ifdef IF_STAGE
    `ifdef DEBUG_IF
        // connect external debug inputs to internal wires
        assign exif_bj_sig_w = exif_bj_sig;
        assign exif_pc_bj_w  = exif_pc_bj;
        assign stall_if_w    = stall_if;
        assign flush_if_w    = flush_if;
    `endif
`endif

// If FORWARDING_UNIT is used, declare example bypass wires b/c/d/e
`ifdef FORWARDING_UNIT
    wire [31:0] b, c, d, e;
`endif

// -----------------------------------------------------------------------------
// MODULE INSTANTIATIONS
// -----------------------------------------------------------------------------
`ifdef IF_STAGE
    if_stage u_if (
        .clk_i (clk_i),
        .rst_i (rst_i),

    `ifdef DEBUG_IF
        .stall_i (stall_if_w),
        .flush_i (flush_if_w),
    `else
        .stall_i (1'b0),
        .flush_i (1'b0),    
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
        .flush_i (1'b0),
        .stall_i (1'b0),
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
`ifdef FORWARDING
        .rs1_addr_o     (idex_rs1_addr_w),
        .rs2_addr_o     (idex_rs2_addr_w),
`else
        .rs1_addr_o     (),
        .rs2_addr_o     (),
`endif
        .memread_o      (idex_memread_w),
        .memwrite_o     (idex_memwrite_w),
        .width_select_o (idex_width_select_w),

        .regwrite_o     (idex_regwrite_w),
        .rd_addr_o      (idex_rd_addr_w),
        .wb_sel_o       (idex_memtoreg_w),
    // ID bypass
        .pc_address_o   (idex_pc_w),
    // End bypass
        .id_valid_o     (idex_valid_w)

    `ifdef DEBUG_ID
        , .valid_m_instruction_o (valid_m_instruction_w)
        , .csr_addr_o            (csr_addr_w)
        , .zimm_o                (zimm_w)
    `endif
    );
`endif

`ifdef EX_STAGE
    ex_stage u_ex (
        .clk_i   (clk_i),
        .rst_i   (rst_i),

    `ifdef CONTROL_FLUSH_STALL
        .flush_i (flush_ex_w),
        .stall_i (stall_ex_w),
    `else
        .flush_i (1'b0),
        .stall_i (1'b0),
    `endif
    // Input from ID
        .jal_i          (idex_jal_w),
        .jalr_i         (idex_jalr_w),
        .se_rs1_pc_i    (idex_se_rs1_pc_w),
        .se_rs2_imm_i   (idex_se_rs2_imm_w),
        .aluop_i        (idex_aluop_w),
        .rs1_data_i     (idex_rs1_data_w),
        .rs2_data_i     (idex_rs2_data_w),
        .imm_i          (idex_imm_w),
        .memread_i      (idex_memread_w),
        .memwrite_i     (idex_memwrite_w),
        .width_select_i (idex_width_select_w),
        .regwrite_i     (idex_regwrite_w),
        .rd_addr_i      (idex_rd_addr_w),
        .wb_sel_i       (idex_memtoreg_w),
        .pc_address_i   (idex_pc_w),
        .id_valid_i     (idex_valid_w),
    // End input
    `ifdef FORWARDING_UNIT
        .fw0_sel_i (se0),
        .fw1_sel_i (se1),
        .fw_b_i    (b),
        .fw_c_i    (c),
        .fw_d_i    (d),
        .fw_e_i    (e),
    `else 
        .fw0_sel_i (3'b0),
        .fw1_sel_i (3'b0),
        .fw_b_i    (32'b0),
        .fw_c_i    (32'b0),
        .fw_d_i    (32'b0),
        .fw_e_i    (32'b0),
    `endif
    // Output EX stage
        .bj_sig_o      (exif_bj_sig_w),
        .pc_bj_o       (exif_pc_bj_w),
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

    `ifdef CONTROL_FLUSH_STALL
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
        .regwrite_o     (/*not used here*/),
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
        .regwrite_i   (memwb_valid_w ? 1'b1 : 1'b0), // example: drive from memwb_valid_w or memwb_regwrite if existed
        .rd_addr_i    (memwb_rd_addr_w),
        .wb_sel_i     (memwb_memtoreg_w),
        .pc_address_i (memwb_pc_w + 32'd4),
        .mem_valid_i  (memwb_valid_w),

        .regwrite_o   (wbrf_regwrite_w),
        .rd_addr_o    (wbrf_rd_addr_w),
        .wb_data_o    (wbrf_wdata_w)
    );
`endif

endmodule
