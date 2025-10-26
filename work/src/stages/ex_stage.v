`timescale 1ns/1ps

// =====================================================================
// EX Stage Top (with EX/MEM pipeline registers inside)
// - Verilog-2001
// - Forwarding from EX/MEM and MEM/WB (ALU, MEM/PC+4)
// - Uses forwarded A for JALR target calc
// - Latches all MEM/WB controls to EX/MEM
// =====================================================================
module ex_stage (
    input wire clk_i,
    input wire rst_i,
    input wire stall_i,
    input wire flush_i,

    // From ID/EX pipeline (registered ID outputs)
    input wire        jal_i,
    input wire        jalr_i,
    input wire        se_rs1_pc_i,      // select RS1 or PC for alu a
    input wire        se_rs2_imm_i,         // select RS2 or IMM for alu b
    input wire [3:0]  aluop_i,
    input wire [31:0] rs1_data_i,
    input wire [31:0] rs2_data_i,
    input wire [31:0] imm_i,
    input wire        memread_i,
    input wire        memwrite_i,
    input wire [2:0]  width_select_i,
    input wire        regwrite_i,
    input wire [4:0]  rd_addr_i,
    input wire [1:0]  wb_sel_i,
    input wire [31:0] pc_address_i,
    input wire        id_valid_i,

    // Forwarding selects (from control path)
    input wire [2:0]  fw0_sel_i,       // select for first 5-to-1 mux (fwd A)
    input wire [2:0]  fw1_sel_i,       // select for second 5-to-1 mux (fwd B)

    // Forwarding data inputs (these were missing; provide values from
    // EX/MEM.ALU, EX/MEM.MEM/PC+4, MEM/WB.ALU, MEM/WB.MEM/PC+4, etc.)
    input wire [31:0] fw_b_i,          // forwarded candidate b
    input wire [31:0] fw_c_i,          // forwarded candidate c
    input wire [31:0] fw_d_i,          // forwarded candidate d
    input wire [31:0] fw_e_i,          // forwarded candidate e

    output reg [31:0] pc_bj_o,
    output reg        bj_sig_o,
    // EX/MEM registered outputs
    output reg [31:0] alu_result_o,
    output reg [31:0] store_data_o,

    output reg        regwrite_o,
    output reg [4:0]  rd_addr_o,
    output reg [1:0]  wb_sel_o,

    output reg        memread_o,
    output reg        memwrite_o,
    output reg [2:0]  width_select_o,

    output reg [31:0] pc_address_o,
    output reg        ex_valid_o

);

    // a=from regfile(ID/EX), b=EX/MEM.ALU, c=EX/MEM.MEM/PC+4, d=MEM/WB.ALU, e=MEM/WB.MEM/PC+4
    wire [31:0] fwd_a_w;
    wire [31:0] fwd_b_w;  // rs2 forwarded value (used as store data)

    // fwd A: use fw0_sel_i to choose between (a,b,c,d,e)
    mux_5to1 u_mux_5to1_a (
        .a_i (rs1_data_i),
        .b_i (fw_b_i),
        .c_i (fw_c_i),
        .d_i (fw_d_i),
        .e_i (fw_e_i),
        .se_i(fw0_sel_i),
        .y_o (fwd_a_w)
    );

    // fwd B: use fw1_sel_i to choose between (a,b,c,d,e)
    mux_5to1 u_mux_5to1_b (
        .a_i (rs2_data_i),
        .b_i (fw_b_i),
        .c_i (fw_c_i),
        .d_i (fw_d_i),
        .e_i (fw_e_i),
        .se_i(fw1_sel_i),
        .y_o (fwd_b_w)
    );

    wire [31:0] alu_op_b_w;
    wire [31:0] alu_op_a_w;

    // If se_rs1_pc_i asserted, choose PC as ALU A input (for JAL)
    mux_2to1 umux_a (
        .a_i (fwd_a_w),
        .b_i (pc_address_i),
        .se_i(se_rs1_pc_i),
        .y_o (alu_op_a_w)
    );

    // If se_rs2_imm_i asserted, choose IMM as ALU B input (typical RISC-V ALUSrc)
    mux_2to1 umux_b (
        .a_i (fwd_b_w),
        .b_i (imm_i),
        .se_i(se_rs2_imm_i),
        .y_o (alu_op_b_w)
    );

    // ALU produces result + branch_taken (for BEQ/BNE/BLT/BGE/BLTU/BGEU)
    wire [31:0] alu_result_w;
    wire        alu_branch_taken_w;

    alu_rv32i u_alu_rv32i (
        .a           (alu_op_a_w),
        .b           (alu_op_b_w),
        .alu_op      (aluop_i),
        .result      (alu_result_w),
        .branch_taken(alu_branch_taken_w)
    );

    // Branch/Jump target calculation
    // - use forwarded A for JALR (rs1 + imm)
    // - JAL uses PC + imm (handled in this block)
    wire [31:0] pc_bj_w;

    branch_jump_calculation u_bj_cal (
        .pc_i       (pc_address_i),
        .rs_1_i     (fwd_a_w),      // forwarded RS1 for JALR
        .imm_i      (imm_i),
        .jalr_sig_i (jalr_i),
        .pc_b_j_o   (pc_bj_w)
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
        bj_sig_o       <= 1'b0;
        pc_bj_o        <= 32'b0;

        regwrite_o     <= 1'b0;
        rd_addr_o      <= 5'b0;
        wb_sel_o       <= 2'b0;
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
            bj_sig_o       <= b_j_taken_w;
            pc_bj_o        <= pc_bj_w;

            // pass-through controls to MEM/WB
            regwrite_o     <= regwrite_i;
            rd_addr_o      <= rd_addr_i;
            wb_sel_o       <= wb_sel_i;
            memread_o      <= memread_i;
            memwrite_o     <= memwrite_i;
            width_select_o <= width_select_i;
            pc_address_o   <= pc_address_i;
            ex_valid_o     <= id_valid_i;
        end
        // else: hold on stall
    end

endmodule
