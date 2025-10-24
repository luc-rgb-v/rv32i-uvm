`timescale 1ns/1ps

// ============================================================
// ID stage top (Control + Register File + ID/EX pipeline regs)
// - pure Verilog-2001
// - includes flush/stall logic (ID/EX inside)
// - forwards rs1/rs2 addresses to EX for hazard/forwarding unit
// ============================================================
module id_stage (
    input wire        clk_i,
    input wire        rst_i,

    input wire        flush_i,
    input wire        stall_i,

    input wire [31:0] instruction_i,
    input wire [31:0] pc_address_i,
    input wire        if_valid_i,

    input wire        wb_regwrite_i,
    input wire [4:0]  wb_rd_addr_i,
    input wire [31:0] wb_wdata_i,

    output reg        jal_o,
    output reg        jalr_o,
    output reg        se_rs1_pc_o, 
    output reg        se_rs2_imm_o,
    output reg [3:0]  aluop_o,

    output reg [31:0] rs1_data_o,
    output reg [31:0] rs2_data_o,
    output reg [31:0] imm_o,
    output reg [4:0]  rs1_addr_o,
    output reg [4:0]  rs2_addr_o,

    output reg        memread_o,
    output reg        memwrite_o,
    output reg [2:0]  width_select_o,

    output reg        regwrite_o,
    output reg [4:0]  rd_addr_o,
    output reg [1:0]  wb_sel_o,

    output reg [31:0] pc_address_o,
    output reg        id_valid_o,

    output reg        valid_m_instruction_o,
    output reg [11:0] csr_addr_o,
    output reg [4:0]  zimm_o
);

    // -----------------------------------------
    // Wires between decoder/control and regfile
    // -----------------------------------------
    wire [4:0]  rs1_addr_w;
    wire [4:0]  rs2_addr_w;
    wire [31:0] imm_w;
    wire        regwrite_w;
    wire [4:0]  rd_addr_w;
    wire        jal_w;
    wire        jalr_w;
    wire        se_rs1_pc_w;
    wire        se_rs2_imm_w;
    wire [3:0]  aluop_w;
    wire [11:0] csr_addr_w;
    wire [4:0]  zimm_w;
    wire        memread_w;
    wire        memwrite_w;
    wire [2:0]  width_select_w;
    wire [1:0]  wb_sel_w;

    wire [31:0] rs1_data_w;
    wire [31:0] rs2_data_w;
    wire valid_m_instruction_w;
    
    // -------------------------
    // Control Unit instance
    // -------------------------
    control_unit u_ctrl (
        .instruction_i (instruction_i),
        .src1_addr_o   (rs1_addr_w),
        .src2_addr_o   (rs2_addr_w),
        .imm_o         (imm_w),
        .regwrite_o    (regwrite_w),
        .rd_addr_o     (rd_addr_w),
        .jal_o         (jal_w),
        .jalr_o        (jalr_w),
        .se_rs1_pc_o   (se_rs1_pc_w),
        .se_rs2_imm_o  (se_rs2_imm_w),
        .aluop_o       (aluop_w),
        .csr_addr_o    (csr_addr_w),
        .zimm_o        (zimm_w),
        .memread_o     (memread_w),
        .memwrite_o    (memwrite_w),
        .width_select_o(width_select_w),
        .memtoreg_o    (wb_sel_w),
        .valid_m_instruction_o(valid_m_instruction_w)
    );

    // -------------------------
    // Register File instance
    // -------------------------
    reg_file u_rf (
        .clk          (clk_i),
        .rs1_i        (rs1_addr_w),
        .rs2_i        (rs2_addr_w),
        .rd_i         (wb_rd_addr_i),
        .wd_i         (wb_wdata_i),
        .reg_write_i  (wb_regwrite_i),
        .rs1_data_o   (rs1_data_w),
        .rs2_data_o   (rs2_data_w)
    );

    // -----------------------------------------
    // Flush helper task (ID/EX pipeline regs)
    // -----------------------------------------
    task flush_regs;
    begin
        imm_o                 <= 32'b0;
        regwrite_o            <= 1'b0;
        rd_addr_o             <= 5'b0;
        jal_o                 <= 1'b0;
        jalr_o                <= 1'b0;
        se_rs1_pc_o           <= 1'b0;
        se_rs2_imm_o          <= 1'b0;
        aluop_o               <= 4'b0;
        csr_addr_o            <= 12'b0;
        zimm_o                <= 5'b0;
        memread_o             <= 1'b0;
        memwrite_o            <= 1'b0;
        width_select_o        <= 3'b0;
        wb_sel_o            <= 2'b0;
        rs1_addr_o           <= 32'b0;
        rs2_addr_o           <= 32'b0;
        pc_address_o          <= 32'b0;
        valid_m_instruction_o <= 1'b0;
        id_valid_o            <= 1'b0;
        rs1_addr_o            <= 5'b0;   // for forwarding
        rs2_addr_o            <= 5'b0;   // for forwarding

    end
    endtask

    // -----------------------------------------
    // ID/EX pipeline register
    // -----------------------------------------
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            flush_regs();
        end
        else if (flush_i) begin
            // bubble/poison the ID/EX stage
            flush_regs();
        end
        else if (~stall_i) begin
            // latch control/imm
            imm_o                 <= imm_w;
            // optional x0-mask here if desired:
            // regwrite_o         <= regwrite_w & (rd_addr_w != 5'b0);
            regwrite_o            <= regwrite_w;
            rd_addr_o             <= rd_addr_w;
            jal_o                 <= jal_w;
            jalr_o                <= jalr_w;
            se_rs1_pc_o           <= se_rs1_pc_w;
            se_rs2_imm_o          <= se_rs2_imm_w;
            aluop_o               <= aluop_w;
            csr_addr_o            <= csr_addr_w;
            zimm_o                <= zimm_w;
            memread_o             <= memread_w;
            memwrite_o            <= memwrite_w;
            width_select_o        <= width_select_w;
            wb_sel_o               <= wb_sel_w;
            rs1_data_o            <= rs1_data_w;
            rs2_data_o            <= rs2_data_w;
            pc_address_o          <= pc_address_i;
            valid_m_instruction_o <= valid_m_instruction_w;
            id_valid_o            <= if_valid_i;
            rs1_addr_o            <= rs1_addr_w;
            rs2_addr_o            <= rs2_addr_w;
        end
        // else: hold on stall_i
    end

endmodule
