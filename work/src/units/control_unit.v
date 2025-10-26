`timescale 1ns/1ps
//==========================================
// Control Unit for RV32I SoC (4-bit ALU op)
// - ALU gets branch ops directly (BEQ..BGEU)
// - width_select_o mapping for loads:
//     000=LB, 001=LH, 010=LW, 011=LBU, 100=LHU
//   (stores use: 000=SB, 001=SH, 010=SW)
//==========================================
module control_unit (
    input  wire [31:0] instruction_i,

    // Register file interface
    output wire [4:0]  src1_addr_o,
    output wire [4:0]  src2_addr_o,

    // Immediate output
    output wire [31:0] imm_o,

    // To WB stage
    output wire        regwrite_o,
    output wire [4:0]  rd_addr_o,

    // EX signal
    output wire        jal_o,
    output wire        jalr_o,

    output wire        se_rs1_pc_o, 
    output wire        se_rs2_imm_o,
    output wire [3:0]  aluop_o,            // 4-bit ALU opcode (incl. branches)
    output wire [11:0] csr_addr_o,
    output wire [4:0]  zimm_o,

    // MEM stage control
    output wire        memread_o,
    output wire        memwrite_o,
    output wire [2:0]  width_select_o,     // see mapping above

    // WB stage 
    output wire [1:0]  memtoreg_o,         // 00=ALU, 01=MEM, 10=PC+4
    output wire valid_m_instruction_o
);

    // --- opcode constants (RV32I)
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

    // --- ALU operation codes (4-bit)
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
    // branch ops (ALU evaluates branch-taken internally)
    localparam ALU_BEQ  = 4'b1010;
    localparam ALU_BNE  = 4'b1011;
    localparam ALU_BLT  = 4'b1100;
    localparam ALU_BGE  = 4'b1101;
    localparam ALU_BLTU = 4'b1110;
    localparam ALU_BGEU = 4'b1111;

    // --- instruction fields
    wire [6:0] opcode  = instruction_i[6:0];
    wire [4:0] src1    = instruction_i[19:15];
    wire [4:0] src2    = instruction_i[24:20];
    wire [4:0] rd      = instruction_i[11:7];
    wire [2:0] funct3  = instruction_i[14:12];
    wire [6:0] funct7  = instruction_i[31:25];

    // --- immediates
    wire [31:0] imm_i = {{20{instruction_i[31]}}, instruction_i[31:20]};
    wire [31:0] imm_s = {{20{instruction_i[31]}}, instruction_i[31:25], instruction_i[11:7]};
    wire [31:0] imm_b = {{19{instruction_i[31]}}, instruction_i[31], instruction_i[7],
                         instruction_i[30:25], instruction_i[11:8], 1'b0};
    wire [31:0] imm_u = {instruction_i[31:12], 12'b0};
    wire [31:0] imm_j = {{11{instruction_i[31]}}, instruction_i[31],
                         instruction_i[19:12], instruction_i[20],
                         instruction_i[30:21], 1'b0};
    wire [31:0] shamt_imm = {27'b0, instruction_i[24:20]};

    // --- SYSTEM fields
    wire [11:0] csr_field  = instruction_i[31:20];
    wire [4:0]  zimm_field = instruction_i[19:15];
    
    assign csr_addr_o = (opcode == OPCODE_SYSTEM) ? csr_field  : 12'b0;
    assign zimm_o     = (opcode == OPCODE_SYSTEM) ? zimm_field : 5'b0;
    assign valid_m_instruction_o = (opcode == 7'b0110011) && (funct7 == 7'b0000001);

    // --- imm_o select
    assign imm_o = (opcode == OPCODE_LUI   || opcode == OPCODE_AUIPC) ? imm_u :
                   (opcode == OPCODE_JAL)                              ? imm_j :
                   (opcode == OPCODE_I_JALR)                           ? imm_i :
                   (opcode == OPCODE_B)                                ? imm_b :
                   (opcode == OPCODE_I_LOAD)                           ? imm_i :
                   (opcode == OPCODE_S)                                ? imm_s :
                   (opcode == OPCODE_I_ARITH && (funct3==3'b001 || funct3==3'b101)) ? shamt_imm :
                   (opcode == OPCODE_I_ARITH)                          ? imm_i :
                   32'b0;

    // --- register addresses
    assign src1_addr_o = (opcode == OPCODE_LUI || opcode == OPCODE_AUIPC || opcode == OPCODE_JAL)
                         ? 5'b0 : src1;
    assign src2_addr_o = (opcode == OPCODE_B || opcode == OPCODE_S || opcode == OPCODE_R)
                         ? src2 : 5'b0;

    // --- MEM control
    assign memread_o   = (opcode == OPCODE_I_LOAD);
    assign memwrite_o  = (opcode == OPCODE_S);

    // Custom width mapping:
    // Loads: 000=LB, 001=LH, 010=LW, 011=LBU, 100=LHU
    // Stores: 000=SB, 001=SH, 010=SW (others unused)
    assign width_select_o =
        (opcode == OPCODE_I_LOAD) ? (
            (funct3==3'b000) ? 3'b000 : // LB
            (funct3==3'b001) ? 3'b001 : // LH
            (funct3==3'b010) ? 3'b010 : // LW
            (funct3==3'b100) ? 3'b011 : // LBU (note: RISC-V funct3=100)
            (funct3==3'b101) ? 3'b100 : // LHU (note: RISC-V funct3=101)
                               3'b010   // default LW
        ) :
        (opcode == OPCODE_S) ? (
            (funct3==3'b000) ? 3'b000 : // SB
            (funct3==3'b001) ? 3'b001 : // SH
                               3'b010   // SW
        ) :
        3'b000;

    assign memtoreg_o =
        (opcode == OPCODE_I_LOAD)                             ? 2'b01 : // memory
        ((opcode == OPCODE_JAL) || (opcode == OPCODE_I_JALR)) ? 2'b10 : // PC+4
                                                                2'b00;  // ALU

    // --- branch / jump indicators
    assign jal_o    = (opcode == OPCODE_JAL);
    assign jalr_o   = (opcode == OPCODE_I_JALR);

    // --- ALU src select (typical: reg-imm for I/load/store/jalr/lui/auipc)
    assign se_rs1_pc_o = (opcode == OPCODE_I_ARITH ||
                       opcode == OPCODE_I_LOAD  ||
                       opcode == OPCODE_S       ||
                       opcode == OPCODE_AUIPC   ||
                       opcode == OPCODE_LUI     ||
                       opcode == OPCODE_I_JALR);

    assign se_rs2_imm_o = (opcode == OPCODE_AUIPC);

    // --- reg writeback enables
    wire writes_rd = (opcode == OPCODE_R)        ||
                     (opcode == OPCODE_I_ARITH)  ||
                     (opcode == OPCODE_I_LOAD)   ||
                     (opcode == OPCODE_JAL)      ||
                     (opcode == OPCODE_I_JALR)   ||
                     (opcode == OPCODE_LUI)      ||
                     (opcode == OPCODE_AUIPC)    ||
                     (opcode == OPCODE_SYSTEM); // refine in CSR unit if rd==x0
    assign regwrite_o = writes_rd;
    assign rd_addr_o  = writes_rd ? rd : 5'b0;

    // --- ALU control decode
    // R-type
    wire [3:0] alu_r_type =
        (funct3==3'b000 && funct7==7'b0100000) ? ALU_SUB :
        (funct3==3'b000)                       ? ALU_ADD :
        (funct3==3'b001)                       ? ALU_SLL :
        (funct3==3'b010)                       ? ALU_SLT :
        (funct3==3'b011)                       ? ALU_SLTU:
        (funct3==3'b100)                       ? ALU_XOR :
        (funct3==3'b101 && funct7==7'b0100000) ? ALU_SRA :
        (funct3==3'b101)                       ? ALU_SRL :
        (funct3==3'b110)                       ? ALU_OR  :
        (funct3==3'b111)                       ? ALU_AND :
                                                 ALU_ADD;

    // I-type (arith/logic)
    wire [3:0] alu_i_type =
        (funct3==3'b000)                       ? ALU_ADD :
        (funct3==3'b001)                       ? ALU_SLL :
        (funct3==3'b010)                       ? ALU_SLT :
        (funct3==3'b011)                       ? ALU_SLTU:
        (funct3==3'b100)                       ? ALU_XOR :
        (funct3==3'b101 && instruction_i[30])  ? ALU_SRA :
        (funct3==3'b101)                       ? ALU_SRL :
        (funct3==3'b110)                       ? ALU_OR  :
        (funct3==3'b111)                       ? ALU_AND :
                                                 ALU_ADD;

    // B-type: send explicit branch op to ALU
    wire [3:0] alu_b_type =
        (funct3==3'b000) ? ALU_BEQ  :
        (funct3==3'b001) ? ALU_BNE  :
        (funct3==3'b100) ? ALU_BLT  :
        (funct3==3'b101) ? ALU_BGE  :
        (funct3==3'b110) ? ALU_BLTU :
        (funct3==3'b111) ? ALU_BGEU :
                           ALU_BEQ; // default safe

    assign aluop_o =
        (opcode == OPCODE_R)        ? alu_r_type :
        (opcode == OPCODE_I_ARITH)  ? alu_i_type :
        (opcode == OPCODE_B)        ? alu_b_type :
        (opcode == OPCODE_AUIPC)    ? ALU_ADD :   // typically PC + imm (handled in datapath)
        (opcode == OPCODE_LUI)      ? ALU_ADD :   // pass-through imm (datapath selects)
                                      ALU_ADD;

endmodule
