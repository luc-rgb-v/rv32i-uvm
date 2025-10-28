`timescale 1ns/1ps

module mimic_pipeline (
    input wire clk_i,
    input wire rst_i
);

`ifdef LOCAL_PARAM
    localparam RESET_PC  = 32'h00000000;
    localparam NOP_INSTR = 32'h00000013;
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

    // --- ALU operation codes
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
    // branch ops (ALU evaluation)
    localparam ALU_BEQ  = 4'b1010;
    localparam ALU_BNE  = 4'b1011;
    localparam ALU_BLT  = 4'b1100;
    localparam ALU_BGE  = 4'b1101;
    localparam ALU_BLTU = 4'b1110;
    localparam ALU_BGEU = 4'b1111;
`endif

`ifdef IF_STAGE
    reg [31:0] pc_r;
    reg valid_pc_r;

    reg [31:0] sub_pc_r;
    reg sub_if_valid_r;

    reg [31:0] instruction_r;
    reg [31:0] ifid_pc_r;
    reg ifid_valid_instruction_r;

    wire stall_pc_w;
    wire take_bj_sig_w;
    wire [31:0] pc_bj_addr_w;
    wire [31:0] next_pc_w = take_bj_sig_w ? pc_bj_addr_w : pc_r + 32'h4;

    wire [31:0] instruction_data_w;
    wire valid_pc_w;
`endif

`ifdef IF_STAGE
    always @ (posedge clk_i or posedge rst_i) begin
        if (rst_i)
            pc_r <= 32'h00;
        else if (stall_pc_w)
            pc_r <= pc_r;
            valid_pc_r <= 0;
        else begin
            pc_r <= next_pc_w;
            valid_pc_r <= 1;
        end

    end

    instruction_mem uut (
    .clka(clk_i),
    .ena(1),
    .wea(0),
    .addra(pc_r[12:0]),
    .dina(32'h0),
    .douta(instruction_data_w)
    );

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            sub_pc_r <= 32'h0;
            sub_if_valid_r <= 0;
        else if (stall_sub_if)
            sub_pc_r <= sub_pc_r;
            sub_if_valid_r <= sub_if_valid_r;
        else if (flush_sub_if)
            sub_pc_r <= 32'h0;
            sub_if_valid_r <= 0;
        else
            sub_pc_r <= pc_r;
            sub_if_valid_r <= valid_pc_r;
    end

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            instruction_r <= 32'b0;
            ifid_pc_r <= 32'b0;
            ifid_valid_instruction_r <= 0;
        else if (stall_if)
            instruction_r <= instruction_r;
            ifid_pc_r <= ifid_pc_r;
            ifid_valid_instruction_r <= ifid_valid_instruction_r;

        else if (flush_if)
            instruction_r <= 32'b0;
            ifid_pc_r <= 32'b0;
            ifid_valid_instruction_r <= 0;
        else
            instruction_r <= instruction_data_w;
            ifid_pc_r <= sub_pc_r;
            ifid_valid_instruction_r <= sub_if_valid_r;
     end

`endif

`ifdef ID_STAGE
    reg jal_r, jalr_r, se_rs1_pc_r, se_rs2_imm_r;
    reg [3:0] alu_op_r;
    reg [31:0] rs1_data_r, rs2_data_r, imm_r;
    reg [4:0] rs1_addr_r, rs2_addr_r;

    reg idex_memread_r, idex_memwrite_r;
    reg [2:0] idex_width_se_r;

    reg [1:0] idex_wb_se_r;

    reg idex_regwrite_r;
    reg [4:0] idex_rd_addr_r;
    reg [1:0] idex_wb_se_r;

    reg [31:0] idex_pc_r;
    reg id_valid_r;
    reg valid_m_instruction_r;
    reg [11:0] csr_addr_r;
    reg [4:0] zimm_r;

    wire [6:0] id_opcode_w = instruction_r[6:0];
    wire [4:0] id_src1_w   = instruction_r[19:15];
    wire [4:0] id_src2_w   = instruction_r[24:20];
    wire [4:0] id_rd_w     = instruction_r[11:7];
    wire [2:0] id_funct3_w = instruction_r[14:12];
    wire [6:0] id_funct7_w = instruction_r[31:25];

    wire [31:0] id_imm_i_w = {{20{instruction_r[31]}}, instruction_r[31:20]};
    wire [31:0] id_imm_s_w= {{20{instruction_r[31]}}, instruction_r[31:25], instruction_r[11:7]};
    wire [31:0] id_imm_b_w = {{19{instruction_r[31]}}, instruction_r[31], instruction_r[7], instruction_r[30:25], instruction_r[11:8], 1'b0};
    wire [31:0] id_imm_j_w = {{11{instruction_r[31]}}, instruction_r[31], instruction_r[19:12], instruction_r[20], instruction_r[30:21], 1'b0};
    wire [31:0] id_imm_u_w = {instruction_r[31:12], 12'b0};
    wire [31:0] id_shamt_imm_w = {27'b0, instruction_r[24:20]};

    `ifdef EXTRA_SUPPORT
        // --- SYSTEM fields
        wire [11:0] id_csr_field_w  = instruction_r[31:20];
        wire [4:0]  id_zimm_field_w = instruction_r[19:15];

        wire [11:0] id_csr_addr_w;
        wire [4:0]  id_zimm_w;
        wire valid_m_instruction;

        wire id_csr_addr_w = (id_opcode_w == OPCODE_SYSTEM) ? id_csr_field_w  : 12'b0;
        wire id_zimm_w     = (id_opcode_w == OPCODE_SYSTEM) ? id_csr_field_w : 5'b0;
        wire valid_m_instruction = (id_opcode_w == 7'b0110011) && (id_funct7_w == 7'b0000001);
    `endif

    wire id_jal_w   = (id_opcode_w == OPCODE_JAL);
    wire id_jalr_w  = (id_opcode_w == OPCODE_I_JALR);

    // --- imm_w select
    wire id_imm_w = (id_opcode_w == OPCODE_LUI || id_opcode_w == OPCODE_AUIPC) ? id_imm_u :
                      (id_opcode_w == OPCODE_JAL)                                ? id_imm_j :
                      (id_opcode_w == OPCODE_I_JALR)                             ? id_imm_i :
                      (id_opcode_w == OPCODE_B)                                  ? id_imm_b :
                      (id_opcode_w == OPCODE_I_LOAD)                             ? id_imm_i :
                      (id_opcode_w == OPCODE_S)                                  ? id_imm_s :
                      (id_opcode_w == OPCODE_I_ARITH && (id_funct3_w == 3'b001 || id_funct3_w == 3'b101)) ? shamt_id_imm :
                      (id_opcode_w == OPCODE_I_ARITH)                            ? id_imm_i :
                      32'b0;

    // --- register addresses
    wire id_src1_addr_w = (id_opcode_w == OPCODE_LUI || id_opcode_w == OPCODE_AUIPC || id_opcode_w == OPCODE_JAL || id_opcode_w == OPCODE_FENCE || (id_opcode_w == OPCODE_SYSTEM && (id_funct3_w == 3'b001 || id_funct3_w == 3'b010 || id_funct3_w == 3'b011))) ? 5'b0 : id_src1_w;
    wire id_src2_addr_w = (id_opcode_w == OPCODE_B || id_opcode_w == OPCODE_S || id_opcode_w == OPCODE_R) ? id_src2_w : 5'b0;

    wire id_se_alu_src1_w = (id_opcode_w == OPCODE_AUIPC);  // MUX = 0 : rs1 ; MUX = 1 : PC
    wire id_se_alu_src2_w = (id_opcode_w == OPCODE_R) || (id_opcode_w == OPCODE_B); // MUX = 0 : imm ; MUX = 1 : rs2

    // --- MEM control
    wire id_memread_w  = (id_opcode_w == OPCODE_I_LOAD);
    wire id_memwrite_w = (id_opcode_w == OPCODE_S);

    // Loads: 000=LB, 001=LH, 010=LW, 100=LBU, 101=LHU
    // Stores: 000=SB, 001=SH, 010=SW (others unused)
    wire id_width_select_w = (id_opcode_w == OPCODE_I_LOAD) ? ((id_funct3_w == 3'b000) ? 3'b000 : (id_funct3_w == 3'b001) ? 3'b001 : (id_funct3_w == 3'b010) ? 3'b010 : (id_funct3_w == 3'b100) ? 3'b100 : (id_funct3_w == 3'b101) ? 3'b101 : 3'b010 :
                               (id_opcode_w == OPCODE_S) ? ((id_funct3_w == 3'b000) ? 3'b000 : (id_funct3_w == 3'b001) ? 3'b001 : 3'b010) : 3'b000;

    // wb_se = 01 memory; 10 PC + 4; 00 ALU
    wire id_wb_se_w = (id_opcode_w == OPCODE_I_LOAD) ? 2'b01 : ((id_opcode_w == OPCODE_JAL) || (id_opcode_w == OPCODE_I_JALR)) ? 2'b10 : 2'b00;

    // --- reg writeback enables
    wire id_writes_rd_w = (id_opcode_w == OPCODE_R)        ||
                          (id_opcode_w == OPCODE_I_ARITH)  ||
                          (id_opcode_w == OPCODE_I_LOAD)   ||
                          (id_opcode_w == OPCODE_JAL)      ||
                          (id_opcode_w == OPCODE_I_JALR)   ||
                          (id_opcode_w == OPCODE_LUI)      ||
                          (id_opcode_w == OPCODE_AUIPC)    ||
                          (id_opcode_w == OPCODE_SYSTEM); // refine in CSR unit if rd == x0

    wire id_rd_addr_w  = id_writes_rd_w ? id_rd_w : 5'b0;

    // --- ALU control decode
    wire [3:0] id_alu_r_type_w = (id_funct3_w == 3'b000 && id_funct7_w == 7'b0100000) ? ALU_SUB :
                                 (id_funct3_w == 3'b000)                         ? ALU_ADD :
                                 (id_funct3_w == 3'b001)                         ? ALU_SLL :
                                 (id_funct3_w == 3'b010)                         ? ALU_SLT :
                                 (id_funct3_w == 3'b011)                         ? ALU_SLTU:
                                 (id_funct3_w == 3'b100)                         ? ALU_XOR :
                                 (id_funct3_w == 3'b101 && id_funct7_w == 7'b0100000) ? ALU_SRA :
                                 (id_funct3_w == 3'b101)                         ? ALU_SRL :
                                 (id_funct3_w == 3'b110)                         ? ALU_OR  :
                                 (id_funct3_w == 3'b111)                         ? ALU_AND : ALU_ADD;

    wire [3:0] id_alu_i_type_w = (id_funct3_w == 3'b000)                         ? ALU_ADD :
                                 (id_funct3_w == 3'b001)                         ? ALU_SLL :
                                 (id_funct3_w == 3'b010)                         ? ALU_SLT :
                                 (id_funct3_w == 3'b011)                         ? ALU_SLTU:
                                 (id_funct3_w == 3'b100)                         ? ALU_XOR :
                                 (id_funct3_w == 3'b101 && instruction_i[30])    ? ALU_SRA :
                                 (id_funct3_w == 3'b101)                         ? ALU_SRL :
                                 (id_funct3_w == 3'b110)                         ? ALU_OR  :
                                 (id_funct3_w == 3'b111)                         ? ALU_AND : ALU_ADD;

    wire [3:0] id_alu_b_type_w = (id_funct3_w == 3'b000) ? ALU_BEQ  :
                                 (id_funct3_w == 3'b001) ? ALU_BNE  :
                                 (id_funct3_w == 3'b100) ? ALU_BLT  :
                                 (id_funct3_w == 3'b101) ? ALU_BGE  :
                                 (id_funct3_w == 3'b110) ? ALU_BLTU :
                                 (id_funct3_w == 3'b111) ? ALU_BGEU : ALU_BEQ; // default safe

    wire id_aluop_w = (id_opcode_w == OPCODE_R)        ? id_alu_r_type_w :
                        (id_opcode_w == OPCODE_I_ARITH)  ? id_alu_i_type_w :
                        (id_opcode_w == OPCODE_B)        ? id_alu_b_type_w :
                        (id_opcode_w == OPCODE_AUIPC)    ? ALU_ADD :          // typically PC + imm
                        (id_opcode_w == OPCODE_LUI)      ? ALU_ADD : ALU_ADD; // default
`endif

`ifdef REGISTER_FILE
    reg [31:0] rf_registers_r [0:31];

    wire rf_regwrite_w;
    wire [4:0] rf_rs1_addr_w;
    wire [4:0] rf_rs2_addr_w;
    wire [4:0] rf_rd_addr_w;

    wire [31:0] rf_write_data_w;
    wire [31:0] rf_rs1_data_w;
    wire [31:0] rf_rs2_data_w;
`endif

`ifdef REGISTER_FILE
    assign rf_rs1_data_w = rf_registers_r[rf_rs1_addr_w];
    assign rf_rs2_data_w = rf_registers_r[rf_rs2_addr_w];

    always @(posedge clk_i) begin
        if (rst_i) rf_registers_r <= 32'h0;
        if (rf_regwrite_w && rf_rd_addr_w != 5'b0) rf_registers_r[rf_rd_addr_w] <= rf_write_data_w;
    end
`endif

`ifdef INITIAL_REG_FILE
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            rf_registers_r[i] = 32'b0;
        end
    end
`endif

    task reset_id_regs;
        begin
            jal_r                  <= 1'b0;
            jalr_r                 <= 1'b0;
            se_rs1_pc_r            <= 1'b0;
            se_rs2_imm_r           <= 1'b0;
            alu_op_r               <= 4'b0;
            rs1_data_r             <= 32'b0;
            rs2_data_r             <= 32'b0;
            imm_r                  <= 32'b0;
            rs1_addr_r             <= 5'b0;
            rs2_addr_r             <= 5'b0;
            idex_memread_r         <= 1'b0;
            idex_memwrite_r        <= 1'b0;
            idex_width_se_r        <= 3'b0;
            idex_wb_se_r           <= 2'b0;
            idex_regwrite_r        <= 1'b0;
            idex_rd_addr_r         <= 5'b0;
            idex_pc_r              <= 32'b0;
            id_valid_r             <= 1'b0;
            valid_m_instruction_r  <= 1'b0;
            csr_addr_r             <= 12'b0;
            zimm_r                 <= 5'b0;
        end
    endtask

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            reset_id_regs();
        else if (flush_id)
            reset_id_regs();
        else if (~stall_id) begin
            jal_r                  <= 1'b0;
            jalr_r                 <= 1'b0;
            se_rs1_pc_r            <= 1'b0;
            se_rs2_imm_r           <= 1'b0;
            alu_op_r               <= 4'b0;
            rs1_data_r             <= 32'b0;
            rs2_data_r             <= 32'b0;
            imm_r                  <= 32'b0;
            rs1_addr_r             <= 5'b0;
            rs2_addr_r             <= 5'b0;
            idex_memread_r         <= 1'b0;
            idex_memwrite_r        <= 1'b0;
            idex_width_se_r        <= 3'b0;
            idex_wb_se_r           <= 2'b0;
            idex_regwrite_r        <= 1'b0;
            idex_rd_addr_r         <= 5'b0;
            idex_pc_r              <= 32'b0;
            id_valid_r             <= 1'b0;
            valid_m_instruction_r  <= 1'b0;
            csr_addr_r             <= 12'b0;
            zimm_r                 <= 5'b0;
        end
    end
`endif

`ifdef EX_STAGE
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            ex_stage_r <= 16'h00;
        else if (stall_ex)
            ex_stage_r <= ex_stage_r;
        else if (flush_ex)
            ex_stage_r <= 16'h00;
        else
            ex_stage_r <= id_stage_r;
    end
`endif

`ifdef MEM_STAGE
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            sub_mem_r <= 16'h0;
        else if (stall_sub_mem)
            sub_mem_r <= sub_mem_r;
        else if (flush_sub_mem)
            sub_mem_r <= 16'h0;
        else
            sub_mem_r <= ex_stage_r;
    end

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            data_mem_r <= 8'h0;
        else
            data_mem_r <= ex_stage_r[8:0];
    end

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i)
            mem_stage_r <= 24'h00;
        else if (flush_mem)
            mem_stage_r <= 24'h00;
        else
            mem_stage_r <= {sub_mem_r, data_mem_r};
    end
`endif

    assign reg_file_o = reg_file_r;

endmodule
