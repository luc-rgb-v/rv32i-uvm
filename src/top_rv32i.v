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
module rv32i_core_top #(
    // ---- IF / IMEM parameters ----
    parameter integer IMEM_WORDS      = 1024,
    parameter        IMEM_INIT_FILE   = "D:/Engineering_Hub/riscv-rv32im-soc/sim/vivado/test_if_stage/instruction.hex",                    // set to "instruction.hex" if desired

    // ---- DMEM parameters ----
    parameter integer DMEM_WORDS      = 128,                   // 128 words = 512 bytes
    parameter        DMEM_MISAL_ZERO  = 1
)(
    input  wire clk_i,
    input  wire rst_i
);

    // =========================================================================
    // Global simple control (replace with hazard/ctrl unit later)
    // =========================================================================
    wire stall_if   = 1'b0;
    wire stall_id   = 1'b0;
    wire stall_ex   = 1'b0;
    wire stall_mem  = 1'b0;

    wire flush_id   = 1'b0;  // ID/EX flush (hook your branch/hazard unit if you have one)
    wire flush_mem  = 1'b0;  // EX/MEM->MEM/WB flush (bubble)

    // =========================================================================
    // IF stage core + IMEM (registered address → 1-cycle fetch)
    // =========================================================================
    wire        if_imem_en;
    wire [31:0] if_imem_addr;
    wire [31:0] if_instr_d;

    wire [31:0] if_pc;              // current PC
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
wire        id_valid_i_w;
wire [4:0]  id_rs1_addr_i_w;
wire [4:0]  id_rs2_addr_i_w;

// EXs
wire        ex_valid_i_w;
wire [4:0]  ex_rd_addr_i_w;
wire        ex_memread_i_w;
wire        ex_take_b_j_i_w;

// Control outs
wire        stall_if_o_w;
wire        stall_id_o_w;
wire        flush_id_ex_o_w;

// =====================================================================
// Instantiation
// =====================================================================
    hazard_control_unit u_hazard_control_unit (
        .id_valid_i     (id_valid_i_w),
        .id_rs1_addr_i  (id_rs1_addr_i_w),
        .id_rs2_addr_i  (id_rs2_addr_i_w),

        .ex_valid_i     (ex_valid_i_w),
        .ex_rd_addr_i   (ex_rd_addr_i_w),
        .ex_memread_i   (ex_memread_i_w),
        .ex_take_b_j_i  (ex_take_b_j_i_w),

        .stall_if_o     (stall_if_o_w),
        .stall_id_o     (stall_id_o_w),
        .flush_id_ex_o  (flush_id_ex_o_w)
    );

    if_stage_core u_if_core (
        .clk_i          (clk_i),
        .rst_i          (rst_i),
        .stall_i        (stall_if),
        .flush_i        (1'b0),              // IF self-flushes on take_b_j_sig_i
        .take_b_j_sig_i (ex_bj_taken),
        .pc_b_j_i       (ex_pc_bj),

        .imem_en_o      (if_imem_en),
        .imem_addr_o    (if_imem_addr),
        .instr_d_i      (if_instr_d),

        .if_id_pc_o     (ifid_pc),
        .if_id_instr_o  (ifid_instr),
        .if_id_valid_o  (ifid_valid),

        .pc_o           (if_pc)
    );

    // Instruction memory (registered address)
    instr_mem_sync_addr u_imem (
        .clk     (clk_i),
        .en      (if_imem_en),
        .addr    (if_imem_addr),     // byte address
        .instr_d (if_instr_d),
        .dontuse()
    );

    // =========================================================================
    // ID stage (control + register file + ID/EX regs)
    // =========================================================================
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
    wire [11:0] idex_csr_addr;
    wire [4:0]  idex_zimm;

    wire        idex_memread;
    wire        idex_memwrite;
    wire [2:0]  idex_width_sel;
    wire [1:0]  idex_memtoreg;

    wire [31:0] idex_rs1_data;
    wire [31:0] idex_rs2_data;
    wire [31:0] idex_pc;

    wire        idex_valid;

    wire [4:0]  idex_rs1_addr;
    wire [4:0]  idex_rs2_addr;

    id_stage u_id (
        .clk_i                   (clk_i),
        .rst_i                   (rst_i),

        .flush_i                 (flush_id),
        .stall_i                 (stall_id),

        .instruction_i           (ifid_instr),
        .pc_address_i            (ifid_pc),
        .valid_m_instruction_i   (ifid_valid),

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
        .csr_addr_o              (idex_csr_addr),
        .zimm_o                  (idex_zimm),

        .memread_o               (idex_memread),
        .memwrite_o              (idex_memwrite),
        .width_select_o          (idex_width_sel),
        .memtoreg_o              (idex_memtoreg),

        .operand_a_o             (idex_rs1_data),
        .operand_b_o             (idex_rs2_data),
        .pc_address_o            (idex_pc),

        .valid_m_instruction_o   (idex_valid),

        .rs1_addr_o              (idex_rs1_addr),
        .rs2_addr_o              (idex_rs2_addr)
    );

    // =========================================================================
    // EX stage (ALU + branch/jump + forwarding)
    // =========================================================================
    // Forwarding sources from MEM and WB
    wire        exmem_wb_we;              // from MEM stage regwrite_o
    wire [4:0]  exmem_wb_rd_addr;         // from MEM stage rd_addr_o
    wire [1:0]  exmem_wb_m2r;             // from MEM stage memtoreg_o

    wire        memwb_we;                 // from WB stage regwrite_o
    wire [4:0]  memwb_rd_addr;            // from WB stage rd_addr_o
    wire [1:0]  memwb_m2r;                // from WB stage *input* sel (memtoreg passed through)

    // Data buses available for forwarding selections
    wire [31:0] exmem_alu_bus;            // ALU result at MEM input/output
    wire [31:0] exmem_mem_bus;            // (usually not used in EX/MEM, keep 0)
    wire [31:0] memwb_alu_bus;
    wire [31:0] memwb_mem_bus;

    // EX outputs to MEM
    wire [31:0] ex_alu_result;
    wire [31:0] ex_store_data;

    wire        ex_regwrite;
    wire [4:0]  ex_rd_addr;
    wire [1:0]  ex_memtoreg;
    wire        ex_memread;
    wire        ex_memwrite;
    wire [2:0]  ex_width_sel;

    // Wire up the available forwarding data
    assign exmem_alu_bus = ex_alu_result;
    assign exmem_mem_bus = 32'b0;

    // From MEM/WB: use the inputs to WB stage (selected later); both sources available
    // (These are declared further below, but forward-declared here)
    // memwb_alu_bus = mem_stage_alu_result_o
    // memwb_mem_bus = mem_stage_data_mem_o

    ex_stage_top u_ex (
        .clk_i                     (clk_i),
        .rst_i                     (rst_i),
        .stall_i                   (stall_ex),
        .flush_i                   (1'b0),           // optional separate EX flush

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
        .alu_EX_MEM_i              (exmem_alu_bus),
        .mem_EX_MEM_i              (exmem_mem_bus),
        .alu_MEM_WB_i              (/* set below */),
        .mem_MEM_WB_i              (/* set below */),

        // Producer meta (from later stages)
        .reg_file_write_EX_MEM_i         (exmem_wb_we),
        .reg_file_write_address_EX_MEM_i (exmem_wb_rd_addr),
        .mux_0_sel_EX_MEM_i              (exmem_wb_m2r),

        .reg_file_write_MEM_WB_i         (memwb_we),
        .reg_file_write_address_MEM_WB_i (memwb_rd_addr),
        .mux_0_sel_MEM_WB_i              (memwb_m2r),

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
        .width_select_o            (ex_width_sel)
    );

    // =========================================================================
    // MEM stage (pipeline reg only) + Data memory (byte-addressed)
    // =========================================================================
    wire        mem_regwrite;
    wire [4:0]  mem_rd_addr;
    wire [1:0]  mem_memtoreg;
    wire [31:0] mem_pc;
    wire [31:0] mem_alu_result;
    wire [31:0] mem_data_to_wb;     // registered load data for WB

    mem_stage u_mem (
        .clk_i         (clk_i),
        .rst_i         (rst_i),
        .flush_i       (flush_mem),
        .stall_i       (stall_mem),

        .regwrite_i    (ex_regwrite),
        .rd_addr_i     (ex_rd_addr),
        .memtoreg_i    (ex_memtoreg),
        .pc_address_i  (idex_pc),           // or pass an EX-tagged PC+4 path if you have one
        .alu_result_i  (ex_alu_result),

        .data_memory_i (/* raw DMEM read below */),

        .regwrite_o    (mem_regwrite),
        .rd_addr_o     (mem_rd_addr),
        .memtoreg_o    (mem_memtoreg),
        .pc_address_o  (mem_pc),
        .alu_result_o  (mem_alu_result),
        .data_mem_o    (mem_data_to_wb)
    );

    // Data memory (addr from MEM stage registered ALU result)
    wire        dmem_we   = ex_memwrite;          // store enable from EX control
    wire        dmem_re   = ex_memread;           // load enable from EX control
    wire [2:0]  dmem_wsel = ex_width_sel;
    wire [31:0] dmem_wdat = ex_store_data;
    wire [31:0] dmem_rdat;

    data_mem_rv32i u_dmem (
        .clk       (clk_i),
        .we        (dmem_we),
        .re        (dmem_re),
        .width_sel (dmem_wsel),
        .addr      (mem_alu_result[8:0]),   // byte address, small test RAM
        .wdata     (dmem_wdat),
        .rdata     (dmem_rdat)
    );

    // Connect DMEM raw read to MEM stage (then MEM registers it to WB)
    assign u_mem.data_memory_i = dmem_rdat; // if your tool dislikes, expose a wire:
    // wire [31:0] dmem_raw_r = dmem_rdat;
    // .data_memory_i(dmem_raw_r)

    // =========================================================================
    // WB stage: select (ALU / MEM / PC+4) and write back to RF (via ID)
    // =========================================================================
    wire        wb_regwrite;
    wire [4:0]  wb_rd_addr;
    wire [31:0] wb_wdata;
    wire [1:0]  wb_sel = mem_memtoreg;        // pass-through memtoreg

    wb_stage u_wb (
        .regwrite_i   (mem_regwrite),
        .rd_addr_i    (mem_rd_addr),
        .alu_result_i (mem_alu_result),
        .data_mem_i   (mem_data_to_wb),
        .pc_address_i (mem_pc),
        .wb_sel_i     (wb_sel),

        .regwrite_o   (wb_regwrite),
        .rd_addr_o    (wb_rd_addr),
        .wb_data_o    (wb_wdata)
    );

    // Feed back to ID’s RF write port
    assign wb_rf_we      = wb_regwrite;
    assign wb_rf_rd_addr = wb_rd_addr;
    assign wb_rf_wdata   = wb_wdata;

    // =========================================================================
    // Forwarding metadata hookup
    // =========================================================================
    // EX/MEM perspective (what EX sees “ahead”): use MEM stage outputs
    assign exmem_wb_we      = mem_regwrite;
    assign exmem_wb_rd_addr = mem_rd_addr;
    assign exmem_wb_m2r     = mem_memtoreg;

    // MEM/WB perspective: use WB stage outputs and the memtoreg that WB received
    assign memwb_we         = wb_regwrite;
    assign memwb_rd_addr    = wb_rd_addr;
    assign memwb_m2r        = wb_sel;                 // same 2-bit select that entered WB

    // Forwarding data buses from MEM/WB point:
    assign memwb_alu_bus    = mem_alu_result;         // ALU result entering WB
    assign memwb_mem_bus    = mem_data_to_wb;         // MEM data entering WB

    // =========================================================================
    // Branch redirect wiring
    // =========================================================================
    assign ex_pc_bj = ex_pc_bj;   // (already named as ex_pc_bj)
    // IF already observes ex_bj_taken + ex_pc_bj via u_if_core connections above.

endmodule
