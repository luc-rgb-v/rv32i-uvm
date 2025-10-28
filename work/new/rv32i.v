`timescale 1ns/1ps

`define INITIAL_REG_FILE
//`define ID_EXTRA
`define DEBUG

module rv32i (
    input wire clk_i,
    input wire rst_i,
    input wire flush_mem, 
    input wire flush_sub_mem, 
    input wire flush_ex, 
    input wire flush_id, 
    input wire flush_if,
    input wire flush_sub_if, 
    input wire stall_mem, 
    input wire stall_sub_mem, 
    input wire stall_ex, 
    input wire stall_id, 
    input wire stall_if, 
    input wire stall_sub_if, 
    input wire stall_pc
`ifdef DEBUG
// ==================== DEBUG OUTPUTS ====================
    ,output wire [31:0] debug_pc_o
    ,output wire [31:0] debug_instr_o
    ,output wire        debug_if_valid_o
    ,output wire [31:0] debug_id_pc_o
    ,output wire [31:0] debug_rs1_data_o
    ,output wire [31:0] debug_rs2_data_o
    ,output wire [31:0] debug_imm_o
    ,output wire [3:0]  debug_alu_op_o
    ,output wire        debug_branch_taken_o
    ,output wire [31:0] debug_branch_target_o
    ,output wire [31:0] debug_alu_result_o
    ,output wire [31:0] debug_mem_addr_o
    ,output wire [31:0] debug_mem_wdata_o
    ,output wire [31:0] debug_mem_rdata_o
    ,output wire        debug_mem_read_o
    ,output wire        debug_mem_write_o
    ,output wire [31:0] debug_wb_data_o
    ,output wire [4:0]  debug_wb_rd_o
    ,output wire        debug_wb_valid_o
`endif
);

    // LOCAL_PARAM
    localparam RESET_PC  = 32'b00000000;
    localparam NOP_INSTR = 32'h00000013;
    // opcode RV32I
    localparam OPCODE_R       = 7'b0110011;
    localparam OPCODE_I_ARITH = 7'b0010011;
    localparam OPCODE_I_LOAD  = 7'b0000011;
    localparam OPCODE_I_JALR  = 7'b1100111;
    localparam OPCODE_SYSTEM  = 7'b1110011;
    localparam OPCODE_S       = 7'b0100011;
    localparam OPCODE_B       = 7'b1100011;
    localparam OPCODE_LUI     = 7'b0110111;
    localparam OPCODE_AUIPC   = 7'b0010111;
    localparam OPCODE_JAL     = 7'b1101111;
    localparam OPCODE_FENCE   = 7'b0001111;
    // ALU opcode
    localparam ALU_ADD  = 4'b0000;
    localparam ALU_SUB  = 4'b0001;
    localparam ALU_SLL  = 4'b0010;
    localparam ALU_SLT  = 4'b0011;
    localparam ALU_SLTU = 4'b0100;
    localparam ALU_XOR  = 4'b0101;
    localparam ALU_SRL  = 4'b0110;
    localparam ALU_SRA  = 4'b0111;
    localparam ALU_OR   = 4'b1000;
    localparam ALU_AND  = 4'b1001;
    // ALU branch
    localparam ALU_BEQ  = 4'b1010;
    localparam ALU_BNE  = 4'b1011;
    localparam ALU_BLT  = 4'b1100;
    localparam ALU_BGE  = 4'b1101;
    localparam ALU_BLTU = 4'b1110;
    localparam ALU_BGEU = 4'b1111;
    // Memory
    localparam [2:0] LB  = 3'b000;
    localparam [2:0] LH  = 3'b001;
    localparam [2:0] LW  = 3'b010;
    localparam [2:0] LBU = 3'b100;
    localparam [2:0] LHU = 3'b101;
    localparam [2:0] SB  = 3'b000;
    localparam [2:0] SH  = 3'b001;
    localparam [2:0] SW  = 3'b010;

    // IF_STAGE
    reg [31:0] pc_r;
    reg valid_pc_r;
    // SUB REG IN ORDER TO FIX DATAPATH
    reg [31:0] sub_if_pc_r;
    reg sub_if_valid_r;
    // IF/ID REG
    reg [31:0] instruction_r;
    reg [31:0] ifid_pc_r;
    reg ifid_valid_instruction_r;

    //wire stall_pc;
    wire take_bj_sig_w;
    wire [31:0] pc_bj_addr_w;
    wire [31:0] next_pc_w = take_bj_sig_w ? pc_bj_addr_w : pc_r + 32'h4;
    wire [31:0] instruction_data_w;

    // IF_STAGE
    always @ (posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            pc_r <= 32'b00;
            valid_pc_r <= 0;
        end else if (stall_pc) begin
            pc_r <= pc_r;
            valid_pc_r <= 0;
        end else begin
            pc_r <= next_pc_w;
            valid_pc_r <= 1;
        end

    end
    // BRAM 8192 x 32
    instruction_mem u_imen (
    .clka(clk_i),
    .ena(1),
    .wea(0),
    .addra(pc_r[12:0]),
    .dina(32'b0),
    .douta(instruction_data_w)
    );
    // SUB REG TO FIX DATAPATH
    //wire flush_sub_if, stall_sub_if;
    //wire flush_if, stall_if;
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            sub_if_pc_r <= 32'b0;
            sub_if_valid_r <= 0;
        end else if (flush_sub_if) begin
            sub_if_pc_r <= 32'b0;
            sub_if_valid_r <= 0;
        end else if (~stall_sub_if) begin
            sub_if_pc_r <= pc_r;
            sub_if_valid_r <= valid_pc_r;
        end
    end
    // IF/ID REG
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            instruction_r <= 32'b0;
            ifid_pc_r <= 32'b0;
            ifid_valid_instruction_r <= 0;
        end else if (flush_if) begin
            instruction_r <= 32'b0;
            ifid_pc_r <= 32'b0;
            ifid_valid_instruction_r <= 0;
        end else if (~stall_if) begin
            instruction_r <= instruction_data_w;
            ifid_pc_r <= sub_if_pc_r;
            ifid_valid_instruction_r <= sub_if_valid_r;
        end
     end

    // ID_STAGE
    reg jal_r, jalr_r, se_rs1_pc_r, se_imm_rs2_r;
    reg [3:0] alu_op_r;
    reg [31:0] rs1_data_r, rs2_data_r, imm_r;
    reg [4:0] rs1_addr_r, rs2_addr_r;
    reg idex_memread_r, idex_memwrite_r;
    reg [2:0] idex_width_se_r;
    reg [1:0] idex_wb_se_r;
    reg idex_regwrite_r;
    reg [4:0] idex_rd_addr_r;
    reg [31:0] idex_pc_r;
    reg id_valid_r;
    
`ifdef ID_EXTRA
    reg valid_m_instruction_r;
    reg [11:0] csr_addr_r;
    reg [4:0] zimm_r;
`endif

    wire [6:0] id_opcode_w = instruction_r[6:0];
    wire [4:0] id_src1_w   = instruction_r[19:15];
    wire [4:0] id_src2_w   = instruction_r[24:20];
    wire [4:0] id_rd_w     = instruction_r[11:7];
    wire [2:0] id_funct3_w = instruction_r[14:12];
    wire [6:0] id_funct7_w = instruction_r[31:25];

    wire [31:0] id_imm_i_w = {{20{instruction_r[31]}}, instruction_r[31:20]};
    wire [31:0] id_imm_s_w = {{20{instruction_r[31]}}, instruction_r[31:25], instruction_r[11:7]};
    wire [31:0] id_imm_b_w = {{19{instruction_r[31]}}, instruction_r[31], instruction_r[7], instruction_r[30:25], instruction_r[11:8], 1'b0};
    wire [31:0] id_imm_j_w = {{11{instruction_r[31]}}, instruction_r[31], instruction_r[19:12], instruction_r[20], instruction_r[30:21], 1'b0};
    wire [31:0] id_imm_u_w = {instruction_r[31:12], 12'b0};
    wire [31:0] id_shamt_imm_w = {27'b0, instruction_r[24:20]};

`ifdef ID_EXTRA
    // SYSTEM FIELDS
    wire [11:0] id_csr_field_w  = instruction_r[31:20];
    wire [4:0]  id_zimm_field_w = instruction_r[19:15];

    wire [11:0] id_csr_addr_w = (id_opcode_w == OPCODE_SYSTEM) ? id_csr_field_w  : 12'b0;
    wire [4:0] id_zimm_w = (id_opcode_w == OPCODE_SYSTEM) ? id_zimm_field_w : 5'b0;
    wire valid_m_instruction = (id_opcode_w == OPCODE_R) && (id_funct7_w == 7'b0000001);
`endif

    wire id_jal_w   = (id_opcode_w == OPCODE_JAL);
    wire id_jalr_w  = (id_opcode_w == OPCODE_I_JALR);

    // IMM select
    wire [31:0] id_imm_w  = (id_opcode_w == OPCODE_LUI || id_opcode_w == OPCODE_AUIPC) ? id_imm_u_w :
                            (id_opcode_w == OPCODE_JAL)                                ? id_imm_j_w :
                            (id_opcode_w == OPCODE_I_JALR)                             ? id_imm_i_w :
                            (id_opcode_w == OPCODE_B)                                  ? id_imm_b_w :
                            (id_opcode_w == OPCODE_I_LOAD)                             ? id_imm_i_w :
                            (id_opcode_w == OPCODE_S)                                  ? id_imm_s_w :
                            (id_opcode_w == OPCODE_I_ARITH && (id_funct3_w == 3'b001 || id_funct3_w == 3'b101)) ? id_shamt_imm_w :
                            (id_opcode_w == OPCODE_I_ARITH)                            ? id_imm_i_w :
                            32'b0;

    // Register addresses
    wire [4:0] id_src1_addr_w = (id_opcode_w == OPCODE_LUI || id_opcode_w == OPCODE_AUIPC || id_opcode_w == OPCODE_JAL || id_opcode_w == OPCODE_FENCE || (id_opcode_w == OPCODE_SYSTEM && (id_funct3_w == 3'b001 || id_funct3_w == 3'b010 || id_funct3_w == 3'b011))) ? 5'b0 : id_src1_w;
    wire [4:0] id_src2_addr_w = (id_opcode_w == OPCODE_B || id_opcode_w == OPCODE_S || id_opcode_w == OPCODE_R) ? id_src2_w : 5'b0;
    wire id_se_alu_src1_w = (id_opcode_w == OPCODE_AUIPC);  // MUX = 0 : rs1 ; MUX = 1 : PC
    wire id_se_alu_src2_w = (id_opcode_w == OPCODE_R) || (id_opcode_w == OPCODE_B); // MUX = 0 : imm ; MUX = 1 : rs2
    // MEM control
    wire id_memread_w  = (id_opcode_w == OPCODE_I_LOAD);
    wire id_memwrite_w = (id_opcode_w == OPCODE_S);
    // Loads: 000=LB, 001=LH, 010=LW, 100=LBU, 101=LHU
    wire [2:0] id_load_se_w = (id_funct3_w == 3'b000) ? 3'b000 : (id_funct3_w == 3'b001) ? 3'b001 : (id_funct3_w == 3'b010) ? 3'b010 : (id_funct3_w == 3'b100) ? 3'b100 : (id_funct3_w == 3'b101) ? 3'b101 : 3'b010;
    // Stores: 000=SB, 001=SH, 010=SW (others unused)
    wire [2:0] id_store_se_w = (id_funct3_w == 3'b000) ? 3'b000 : (id_funct3_w == 3'b001) ? 3'b001 : 3'b010;
    // Load and store select
    wire [2:0] id_width_select_w = (id_opcode_w == OPCODE_I_LOAD) ? id_load_se_w : (id_opcode_w == OPCODE_S) ? id_store_se_w : 3'b000;
    // wb_se = 01 memory; 10 PC + 4; 00 ALU
    wire [1:0] id_wb_se_w = (id_opcode_w == OPCODE_I_LOAD) ? 2'b01 : ((id_opcode_w == OPCODE_JAL) || (id_opcode_w == OPCODE_I_JALR)) ? 2'b10 : 2'b00;

    // --- reg writeback enables
    wire id_writes_rd_w = (id_opcode_w == OPCODE_R)        ||
                          (id_opcode_w == OPCODE_I_ARITH)  ||
                          (id_opcode_w == OPCODE_I_LOAD)   ||
                          (id_opcode_w == OPCODE_JAL)      ||
                          (id_opcode_w == OPCODE_I_JALR)   ||
                          (id_opcode_w == OPCODE_LUI)      ||
                          (id_opcode_w == OPCODE_AUIPC)    ||
                          ((id_opcode_w == OPCODE_SYSTEM) && id_funct3_w != 3'b000);

    wire [4:0] id_rd_addr_w  = id_writes_rd_w ? id_rd_w : 5'b0;

    // ALU control decode
    wire [3:0] id_alu_r_type_w = (id_funct3_w == 3'b000 && id_funct7_w == 7'b0100000) ? ALU_SUB :
                                 (id_funct3_w == 3'b000)                              ? ALU_ADD :
                                 (id_funct3_w == 3'b001)                              ? ALU_SLL :
                                 (id_funct3_w == 3'b010)                              ? ALU_SLT :
                                 (id_funct3_w == 3'b011)                              ? ALU_SLTU:
                                 (id_funct3_w == 3'b100)                              ? ALU_XOR :
                                 (id_funct3_w == 3'b101 && id_funct7_w == 7'b0100000) ? ALU_SRA :
                                 (id_funct3_w == 3'b101)                              ? ALU_SRL :
                                 (id_funct3_w == 3'b110)                              ? ALU_OR  :
                                 (id_funct3_w == 3'b111)                              ? ALU_AND : ALU_ADD;

    wire [3:0] id_alu_i_type_w = (id_funct3_w == 3'b000)                              ? ALU_ADD :
                                 (id_funct3_w == 3'b001)                              ? ALU_SLL :
                                 (id_funct3_w == 3'b010)                              ? ALU_SLT :
                                 (id_funct3_w == 3'b011)                              ? ALU_SLTU:
                                 (id_funct3_w == 3'b100)                              ? ALU_XOR :
                                 (id_funct3_w == 3'b101 && instruction_r[30])         ? ALU_SRA :
                                 (id_funct3_w == 3'b101)                              ? ALU_SRL :
                                 (id_funct3_w == 3'b110)                              ? ALU_OR  :
                                 (id_funct3_w == 3'b111)                              ? ALU_AND : ALU_ADD;

    wire [3:0] id_alu_b_type_w = (id_funct3_w == 3'b000) ? ALU_BEQ  :
                                 (id_funct3_w == 3'b001) ? ALU_BNE  :
                                 (id_funct3_w == 3'b100) ? ALU_BLT  :
                                 (id_funct3_w == 3'b101) ? ALU_BGE  :
                                 (id_funct3_w == 3'b110) ? ALU_BLTU :
                                 (id_funct3_w == 3'b111) ? ALU_BGEU : ALU_BEQ; // default safe

    wire [3:0] id_aluop_w =   (id_opcode_w == OPCODE_R)       ? id_alu_r_type_w :
                              (id_opcode_w == OPCODE_I_ARITH) ? id_alu_i_type_w :
                              (id_opcode_w == OPCODE_B)       ? id_alu_b_type_w :
                              (id_opcode_w == OPCODE_AUIPC)   ? ALU_ADD :          // typically PC + imm
                              (id_opcode_w == OPCODE_LUI)     ? ALU_ADD : ALU_ADD; // default

    // REGISTER_FILE
    reg [31:0] rf_registers_r [0:31];
    wire rf_regwrite_w;
    wire [4:0] rf_rd_addr_w;
    wire [31:0] rf_write_data_w;
    wire [31:0] rf_rs1_data_w = (id_src1_addr_w == 5'b0) ? 32'b0 : rf_registers_r[id_src1_addr_w];
    wire [31:0] rf_rs2_data_w = (id_src2_addr_w == 5'b0) ? 32'b0 : rf_registers_r[id_src2_addr_w];

    always @(posedge clk_i) begin
        if (rf_regwrite_w && rf_rd_addr_w != 5'b0) rf_registers_r[rf_rd_addr_w] <= rf_write_data_w;
    end

`ifdef INITIAL_REG_FILE
    integer i;
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            rf_registers_r[i] = 32'b0;
        end
    end
`endif

    // ID_STAGE
    task reset_id_regs;
        begin
            jal_r <= 1'b0;
            jalr_r <= 1'b0;
            se_rs1_pc_r <= 1'b0;
            se_imm_rs2_r <= 1'b0;
            alu_op_r <= 4'b0;
            rs1_data_r <= 32'b0;
            rs2_data_r <= 32'b0;
            imm_r <= 32'b0;
            rs1_addr_r <= 5'b0;
            rs2_addr_r <= 5'b0;
            idex_memread_r <= 1'b0;
            idex_memwrite_r <= 1'b0;
            idex_width_se_r <= 3'b0;
            idex_wb_se_r <= 2'b0;
            idex_regwrite_r <= 1'b0;
            idex_rd_addr_r  <= 5'b0;
            idex_pc_r <= 32'b0;
            id_valid_r <= 1'b0;

            `ifdef ID_EXTRA
                valid_m_instruction_r <= 1'b0;
                csr_addr_r <= 12'b0;
                zimm_r <= 5'b0;
            `endif
        end
    endtask
    
    //wire flush_id, stall_id;
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            reset_id_regs();
        else if (flush_id)
            reset_id_regs();
        else if (~stall_id) begin
            jal_r <= id_jal_w;
            jalr_r <= id_jalr_w;
            se_rs1_pc_r <= id_se_alu_src1_w;
            se_imm_rs2_r <= id_se_alu_src2_w;
            alu_op_r <= id_aluop_w;
            rs1_data_r <= rf_rs1_data_w;
            rs2_data_r <= rf_rs2_data_w;
            imm_r <= id_imm_w;
            rs1_addr_r <= id_src1_addr_w;
            rs2_addr_r <= id_src2_addr_w;
            idex_memread_r <= id_memread_w;
            idex_memwrite_r <= id_memwrite_w;
            idex_width_se_r <= id_width_select_w;
            idex_wb_se_r <= id_wb_se_w;
            idex_regwrite_r <= id_writes_rd_w;
            idex_rd_addr_r <= id_rd_addr_w;
            idex_pc_r <= ifid_pc_r;
            id_valid_r <= ifid_valid_instruction_r;

            `ifdef ID_EXTRA
                valid_m_instruction_r <= valid_m_instruction;
                csr_addr_r <= id_csr_addr_w;
                zimm_r <= id_zimm_w;
            `endif
        end
    end

    // EX_STAGE
    reg [31:0] ex_pc_bj_r;
    reg ex_bj_taken_r;

    reg [31:0] exmem_alu_result_r;
    reg [31:0] exmem_store_data_r;

    reg exmem_memread_r;
    reg exmem_memwrite_r;
    reg [2:0] exmem_width_se_r;

    reg [1:0] exmem_wb_se_r;
    reg exmem_regwrite_r;
    reg [4:0] exmem_rd_addr_r;

    reg [31:0] exmem_pc_r;
    reg ex_valid_r;

    // Priority order: EX stage → WB stage → default
    // Check rd match

    // wb_se = 01 memory; 10 PC + 4; 00 ALU
    wire [3:0] se1_w;

    wire [3:0] se2_w;
    wire [31:0] rs1_w;

    wire [31:0] rs2_w;
  
    wire [31:0] operand_a_w = (se_rs1_pc_r == 1'b1) ? idex_pc_r : rs1_w;
    wire [31:0] operand_b_w = (se_imm_rs2_r == 1'b1) ? rs2_w : imm_r;
    
    // ALU
    wire [31:0] add_res_w  = operand_a_w + operand_b_w;
    wire [31:0] sub_res_w  = operand_a_w - operand_b_w;
    wire [31:0] sll_res_w  = operand_a_w << operand_b_w[4:0];
    wire [31:0] srl_res_w  = operand_a_w >> operand_b_w[4:0];
    wire [31:0] sra_res_w  = ($signed(operand_a_w)) >>> operand_b_w[4:0];
    wire [31:0] xor_res_w  = operand_a_w ^ operand_b_w;
    wire [31:0] or_res_w   = operand_a_w | operand_b_w;
    wire [31:0] and_res_w  = operand_a_w & operand_b_w;
    wire [31:0] slt_res_w  = ($signed(operand_a_w) < $signed(operand_b_w)) ? 32'h1 : 32'b0;
    wire [31:0] sltu_res_w = (operand_a_w < operand_b_w) ? 32'h1 : 32'b0;

    wire [31:0] alu_result_w =  (alu_op_r == ALU_ADD)  ? add_res_w  :
                                (alu_op_r == ALU_SUB)  ? sub_res_w  :
                                (alu_op_r == ALU_SLL)  ? sll_res_w  :
                                (alu_op_r == ALU_SLT)  ? slt_res_w  :
                                (alu_op_r == ALU_SLTU) ? sltu_res_w :
                                (alu_op_r == ALU_XOR)  ? xor_res_w  :
                                (alu_op_r == ALU_SRL)  ? srl_res_w  :
                                (alu_op_r == ALU_SRA)  ? sra_res_w  :
                                (alu_op_r == ALU_OR)   ? or_res_w   :
                                (alu_op_r == ALU_AND)  ? and_res_w  :
                                32'b0;

    wire [31:0] alu_branch_taken_w = (alu_op_r == ALU_BEQ)  ? (operand_a_w == operand_b_w) :
                                     (alu_op_r == ALU_BNE)  ? (operand_a_w != operand_b_w) :
                                     (alu_op_r == ALU_BLT)  ? ($signed(operand_a_w) <  $signed(operand_b_w)) :
                                     (alu_op_r == ALU_BGE)  ? ($signed(operand_a_w) >= $signed(operand_b_w)) :
                                     (alu_op_r == ALU_BLTU) ? (operand_a_w < operand_b_w) :
                                     (alu_op_r == ALU_BGEU) ? (operand_a_w >= operand_b_w) :
                                     1'b0;

    wire [31:0] ex_pc_bj_w = jalr_r ? ((rs1_data_r + imm_r) & 32'hFFFFFFFE) : (idex_pc_r + imm_r);
    wire ex_bj_taken_w = alu_branch_taken_w || jal_r || jalr_r;

    // EX_STAGE
    task reset_ex_regs; begin
            ex_pc_bj_r <= 32'b0;
            ex_bj_taken_r <= 1'b0;
            exmem_alu_result_r <= 32'b0;
            exmem_store_data_r <= 32'b0;
            exmem_memread_r <= 1'b0;
            exmem_memwrite_r <= 1'b0;
            exmem_width_se_r <= 3'b0;
            exmem_wb_se_r <= 2'b0;
            exmem_regwrite_r <= 1'b0;
            exmem_rd_addr_r <= 5'b0;
            exmem_pc_r <= 32'b0;
            ex_valid_r <= 1'b0;
        end
    endtask

    //wire flush_ex, stall_ex;
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            reset_ex_regs();
        else if (flush_ex)
            reset_ex_regs();
        else if (~stall_ex) begin
            ex_pc_bj_r <= ex_pc_bj_w;
            ex_bj_taken_r <= ex_bj_taken_w;
            exmem_alu_result_r <= alu_result_w;
            exmem_store_data_r <= rs2_w;
            exmem_memread_r <= idex_memread_r;
            exmem_memwrite_r <= idex_memwrite_r;
            exmem_width_se_r <= idex_width_se_r;
            exmem_wb_se_r <= idex_wb_se_r;
            exmem_regwrite_r <= idex_regwrite_r;
            exmem_rd_addr_r <= idex_rd_addr_r;
            exmem_pc_r <= idex_pc_r + 32'h4;
            ex_valid_r <= id_valid_r;
        end
    end
    assign take_bj_sig_w = ex_bj_taken_r;
    assign pc_bj_addr_w = ex_pc_bj_r;

    // SUB_MEM_STAGE
    reg         sub_regwrite_r;
    reg  [4:0]  sub_rd_addr_r;
    reg  [1:0]  sub_wb_sel_r;
    reg  [31:0] sub_mem_pc_r;
    reg  [31:0] sub_mem_alu_result_r;
    reg         sub_valid_r;
   
    task reset_sub_mem_regs;
        begin 
            sub_regwrite_r      <= 0;
            sub_rd_addr_r       <= 4'b0;
            sub_wb_sel_r        <= 0;
            sub_mem_pc_r    <= 32'b0;
            sub_mem_alu_result_r    <= 32'b0;
            sub_valid_r         <= 0;
        end
    endtask

    //wire flush_sub_mem, stall_sub_mem;
    always @ (posedge clk_i or posedge rst_i) begin 
        if (rst_i) begin
            reset_sub_mem_regs();
        end else if (flush_sub_mem) begin
            reset_sub_mem_regs();
        end else if (~stall_sub_mem) begin
            sub_regwrite_r       <= exmem_regwrite_r;
            sub_rd_addr_r        <= exmem_rd_addr_r;
            sub_wb_sel_r         <= exmem_wb_se_r;
            sub_mem_pc_r         <= exmem_pc_r;
            sub_mem_alu_result_r <= exmem_alu_result_r;
            sub_valid_r          <= ex_valid_r  && !flush_sub_mem;
        end else begin
            sub_valid_r <= 1'b0;
        end
    end

    // MEM_STAGE
    reg memwb_regwrite_r;
    reg [4:0] memwb_rd_addr_r;
    reg memwb_wb_sel_r;
    reg [31:0] memwb_pc_r;
    reg [31:0] memwb_alu_result_r;
    reg [31:0] memwb_mem_data_r;
    reg memwb_mem_valid_r;

    wire [12:0] memory_address = exmem_alu_result_r[14:2];
    wire [1:0] off_set = exmem_alu_result_r[1:0];

    // Alignment check
    wire misalign_h = exmem_memwrite_r ? (exmem_width_se_r == SH && exmem_alu_result_r[0]) : 1'b0;
    wire misalign_w = exmem_memwrite_r ? (exmem_width_se_r == SW && |exmem_alu_result_r[1:0]) : 1'b0;
    wire misaligned = misalign_h | misalign_w;
    wire start_mem = ex_valid_r & (exmem_memread_r | exmem_memwrite_r) & ~misaligned;

    // Write enables
    wire dmem_we0 = start_mem & exmem_memwrite_r &
                  ( (exmem_width_se_r == SW) |
                    (exmem_width_se_r == SH && off_set[1] == 1'b0) |
                    (exmem_width_se_r == SB && off_set == 2'b00) );
    wire dmem_we1 = start_mem & exmem_memwrite_r &
                  ( (exmem_width_se_r == SW) |
                    (exmem_width_se_r == SH && off_set[1] == 1'b0) |
                    (exmem_width_se_r == SB && off_set == 2'b01) );
    wire dmem_we2 = start_mem & exmem_memwrite_r &
                  ( (exmem_width_se_r == SW) |
                    (exmem_width_se_r == SH && off_set[1] == 1'b1) |
                    (exmem_width_se_r == SB && off_set == 2'b10) );
    wire dmem_we3 = start_mem & exmem_memwrite_r &
                  ( (exmem_width_se_r == SW) |
                    (exmem_width_se_r == SH && off_set[1] == 1'b1) |
                    (exmem_width_se_r == SB && off_set == 2'b11) );

    // Write data
    wire [7:0] din0 = (exmem_width_se_r == SW) ? exmem_store_data_r[7:0] :
                      (exmem_width_se_r == SH && off_set[1] == 1'b0) ? exmem_store_data_r[7:0] :
                      (exmem_width_se_r == SB && off_set == 2'b00) ? exmem_store_data_r[7:0] : 8'h00;
    wire [7:0] din1 = (exmem_width_se_r == SW) ? exmem_store_data_r[15:8] :
                      (exmem_width_se_r == SH && off_set[1] == 1'b0) ? exmem_store_data_r[15:8] :
                      (exmem_width_se_r == SB && off_set == 2'b01) ? exmem_store_data_r[7:0] : 8'h00;
    wire [7:0] din2 = (exmem_width_se_r == SW) ? exmem_store_data_r[23:16] :
                      (exmem_width_se_r == SH && off_set[1] == 1'b1) ? exmem_store_data_r[7:0] :
                      (exmem_width_se_r == SB && off_set == 2'b10) ? exmem_store_data_r[7:0] : 8'h00;
    wire [7:0] din3 = (exmem_width_se_r == SW) ? exmem_store_data_r[31:24] :
                      (exmem_width_se_r == SH && off_set[1] == 1'b1) ? exmem_store_data_r[15:8] :
                      (exmem_width_se_r == SB && off_set == 2'b11) ? exmem_store_data_r[7:0] : 8'h00;

    // 4 banks
    wire [7:0] dout0, dout1, dout2, dout3;
    data_memory u_dmem0 (.clka(clk_i), .ena(start_mem), .wea((dmem_we0)), .addra(memory_address), .dina(din0), .douta(dout0));
    data_memory u_dmem1 (.clka(clk_i), .ena(start_mem), .wea((dmem_we1)), .addra(memory_address), .dina(din1), .douta(dout1));
    data_memory u_dmem2 (.clka(clk_i), .ena(start_mem), .wea((dmem_we2)), .addra(memory_address), .dina(din2), .douta(dout2));
    data_memory u_dmem3 (.clka(clk_i), .ena(start_mem), .wea((dmem_we3)), .addra(memory_address), .dina(din3), .douta(dout3));

    wire [31:0] lb_data  = (off_set[1:0] == 2'b00) ? {{24{dout0[7]}}, dout0} :
                           (off_set[1:0] == 2'b01) ? {{24{dout1[7]}}, dout1} :
                           (off_set[1:0] == 2'b10) ? {{24{dout2[7]}}, dout2} :
                           {{24{dout3[7]}}, dout3}; // LB: Sign-extend selected byte

    wire [31:0] lh_data  = (off_set[1]) ? {{16{dout3[7]}}, dout3, dout2} :
                           {{16{dout1[7]}}, dout1, dout0}; // LH: Sign-extend halfword

    wire [31:0] lw_data  = {dout3, dout2, dout1, dout0}; 
    
    wire [31:0] lbu_data = (off_set[1:0] == 2'b00) ? {24'b0, dout0} :
                           (off_set[1:0] == 2'b01) ? {24'b0, dout1} :
                           (off_set[1:0] == 2'b10) ? {24'b0, dout2} :
                           {24'b0, dout3}; // LBU: Zero-extend selected byte
    
    wire [31:0] lhu_data = (off_set[1]) ? {16'b0, dout3, dout2} :
                       {16'b0, dout1, dout0}; // LHU: Zero-extend halfword

    wire [31:0] load_data_w = (exmem_width_se_r == LB)  ? lb_data  :
                              (exmem_width_se_r == LH)  ? lh_data  :
                              (exmem_width_se_r == LW)  ? lw_data  :
                              (exmem_width_se_r == LBU) ? lbu_data :
                              (exmem_width_se_r == LHU) ? lhu_data :
                              32'b0;

    task reset_MEM_to_WB_reg;
        begin
            memwb_regwrite_r      <= 0;
            memwb_rd_addr_r       <= 5'b0;
            memwb_wb_sel_r        <= 2'b0;
            memwb_pc_r            <= 32'b0;
            memwb_alu_result_r    <= 32'b0;
            memwb_mem_data_r      <= 32'b0;
            memwb_mem_valid_r     <= 0;
        end
    endtask

    //wire flush_mem, stall_mem;
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin 
            reset_MEM_to_WB_reg;
        end else if (flush_mem) begin
            reset_MEM_to_WB_reg;
        end else if (~stall_mem) begin
            memwb_regwrite_r      <= sub_regwrite_r;
            memwb_rd_addr_r       <= sub_rd_addr_r;
            memwb_wb_sel_r        <= sub_wb_sel_r;
            memwb_pc_r            <= sub_mem_pc_r;
            memwb_alu_result_r    <= sub_mem_alu_result_r;
            memwb_mem_data_r      <= load_data_w;
            memwb_mem_valid_r     <= sub_valid_r  && !flush_mem;
        end
    end
    
    // Write back
    wire [31:0] wb_data_w = (memwb_mem_valid_r == 1) ? ((memwb_wb_sel_r == 2'b00) ? memwb_alu_result_r :
                                                        (memwb_wb_sel_r == 2'b01) ? memwb_mem_data_r   :
                                                        (memwb_wb_sel_r == 2'b10) ? (memwb_pc_r) : 32'b0) : 32'b0;

    wire exmem_match_1_w  = exmem_regwrite_r && (rs1_addr_r == exmem_rd_addr_r) && (rs1_addr_r != 5'b00000);
    wire exmem_match_2_w  = exmem_regwrite_r && (rs2_addr_r == exmem_rd_addr_r) && (rs2_addr_r != 5'b00000);
    wire submem_match_1_w  = sub_regwrite_r && (rs1_addr_r == sub_rd_addr_r) && (rs1_addr_r != 5'b00000);
    wire submem_match_2_w  = sub_regwrite_r && (rs2_addr_r == sub_rd_addr_r) && (rs2_addr_r != 5'b00000);
    wire memwb_match_1_w  = memwb_regwrite_r && (rs1_addr_r == memwb_rd_addr_r) && (rs1_addr_r != 5'b00000);
    wire memwb_match_2_w  = memwb_regwrite_r && (rs2_addr_r == memwb_rd_addr_r) && (rs2_addr_r != 5'b00000);

    // wb_se = 01 memory; 10 PC + 4; 00 ALU
    assign se1_w = (exmem_match_1_w && (exmem_wb_se_r == 2'b00)) ? 4'b0001 : 
                   (exmem_match_1_w && (exmem_wb_se_r == 2'b10)) ? 4'b0010 : 
                   (submem_match_1_w && (sub_wb_sel_r == 2'b00)) ? 4'b0011 : 
                   (submem_match_1_w && (sub_wb_sel_r == 2'b01)) ? 4'b0100 : 
                   (submem_match_1_w && (sub_wb_sel_r == 2'b10)) ? 4'b0101 : 
                   (memwb_match_1_w && (memwb_wb_sel_r == 2'b00)) ? 4'b0110 : 
                   (memwb_match_1_w && (memwb_wb_sel_r == 2'b01)) ? 4'b0111 : 
                   (memwb_match_1_w && (memwb_wb_sel_r == 2'b10)) ? 4'b1000 : 
                   4'b0000;
                   
    assign se2_w = (exmem_match_2_w && (exmem_wb_se_r == 2'b00)) ? 4'b0001 : 
                   (exmem_match_2_w && (exmem_wb_se_r == 2'b10)) ? 4'b0010 : 
                   (submem_match_2_w && (sub_wb_sel_r == 2'b00)) ? 4'b0011 : 
                   (submem_match_2_w && (sub_wb_sel_r == 2'b01)) ? 4'b0100 : 
                   (submem_match_2_w && (sub_wb_sel_r == 2'b10)) ? 4'b0101 : 
                   (memwb_match_2_w && (memwb_wb_sel_r == 2'b00)) ? 4'b0110 : 
                   (memwb_match_2_w && (memwb_wb_sel_r == 2'b01)) ? 4'b0111 : 
                   (memwb_match_2_w && (memwb_wb_sel_r == 2'b10)) ? 4'b1000 : 
                   4'b0000;
                                                                                
    assign rs1_w = (se1_w == 4'b1000) ? memwb_pc_r : 
                   (se1_w == 4'b0111) ? memwb_mem_data_r : 
                   (se1_w == 4'b0110) ? memwb_alu_result_r : 
                   (se1_w == 4'b0101) ? sub_mem_pc_r : 
                   (se1_w == 4'b0100) ? load_data_w : 
                   (se1_w == 4'b0011) ? sub_mem_alu_result_r : 
                   (se1_w == 4'b0010) ? exmem_pc_r : 
                   (se1_w == 4'b0001) ? exmem_alu_result_r : rs1_data_r;
                   
    assign rs2_w = (se2_w == 4'b1000) ? memwb_pc_r : 
                   (se2_w == 4'b0111) ? memwb_mem_data_r : 
                   (se2_w == 4'b0110) ? memwb_alu_result_r : 
                   (se2_w == 4'b0101) ? sub_mem_pc_r : 
                   (se2_w == 4'b0100) ? load_data_w : 
                   (se2_w == 4'b0011) ? sub_mem_alu_result_r : 
                   (se2_w == 4'b0010) ? exmem_pc_r : 
                   (se2_w == 4'b0001) ? exmem_alu_result_r : rs2_data_r;

    assign rf_regwrite_w = memwb_regwrite_r;
    assign rf_rd_addr_w = memwb_rd_addr_r;
    assign rf_write_data_w = wb_data_w;
    // ==================== DEBUG OUTPUTS ====================
    assign debug_pc_o            = pc_r;
    assign debug_instr_o         = instruction_r;
    assign debug_if_valid_o      = ifid_valid_instruction_r;
    assign debug_id_pc_o         = ifid_pc_r;
    assign debug_rs1_data_o      = rs1_data_r;
    assign debug_rs2_data_o      = rs2_data_r;
    assign debug_imm_o           = imm_r;
    assign debug_alu_op_o        = alu_op_r;
    assign debug_branch_taken_o  = ex_bj_taken_r;
    assign debug_branch_target_o = ex_pc_bj_r;
    assign debug_alu_result_o    = exmem_alu_result_r;
    assign debug_mem_addr_o      = exmem_alu_result_r;
    assign debug_mem_wdata_o     = exmem_store_data_r;
    assign debug_mem_rdata_o     = load_data_w;
    assign debug_mem_read_o      = exmem_memread_r;
    assign debug_mem_write_o     = exmem_memwrite_r;
    assign debug_wb_data_o       = wb_data_w;
    assign debug_wb_rd_o         = rf_rd_addr_w;
    assign debug_wb_valid_o      = rf_regwrite_w;

endmodule
