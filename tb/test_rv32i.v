`timescale 1ns/1ps

module tb_risc_rv32i;

  reg clk = 0;
  reg rst = 1;

`ifndef MEMDELAY
  reg stall_i = 0;
`endif

`ifdef DEBUG
  wire [31:0] pc;
  wire [31:0] ifid_pc;
  wire [31:0] ifid_instruction;
  wire [31:0] idex_imm;
  wire [31:0] idex_rs1_data;
  wire [31:0] idex_rs2_data;
  wire        exif_bj_taken;
  wire [31:0] exif_pc_bj;
  wire [31:0] exmem_alu_result;
  wire [31:0] exmem_rs2_data;
  wire [31:0] memwb_alu_result;
  wire [31:0] memwb_mem_data;
  wire        wb_regwrite;
  wire [4:0]  wb_rd_addr;
  wire [31:0] wb_data;
`endif

`ifdef DEBUG_INSTRUCTION
  reg [31:0] instruction_i = 32'b0;
  reg [31:0] pc_i = 32'b0;
`endif

  // DUT instantiation
  risc_rv32i uut (
      .clk_i(clk),
      .rst_i(rst)
`ifdef DEBUG
    ,.pc(pc)
    ,.ifid_pc(ifid_pc)
    ,.ifid_instruction(ifid_instruction)
    ,.idex_imm(idex_imm)
    ,.idex_rs1_data(idex_rs1_data)
    ,.idex_rs2_data(idex_rs2_data)
    ,.exif_bj_taken(exif_bj_taken)
    ,.exif_pc_bj(exif_pc_bj)
    ,.exmem_alu_result(exmem_alu_result)
    ,.exmem_rs2_data(exmem_rs2_data)
    ,.memwb_alu_result(memwb_alu_result)
    ,.memwb_mem_data(memwb_mem_data)
    ,.wb_regwrite(wb_regwrite)
    ,.wb_rd_addr(wb_rd_addr)
    ,.wb_data(wb_data)
`endif

`ifdef DEBUG_INSTRUCTION
    ,.instruction_i(instruction_i)
    ,.pc_i(pc_i)
`endif

`ifndef MEMDELAY
    ,.stall_i(stall_i)
`endif
  );
  
    always #5 clk = ~clk;

    initial begin
    `ifdef DEBUG_INSTRUCTION
        instruction_i = 32'b0;
        pc_i = 32'b0;
    `endif
        $dumpfile("risc_rv32i_tb_dump.vcd");
        $dumpvars(0,tb_risc_rv32i);
    end

    initial begin
    #20; rst = 0;
    end 
   
    initial begin
        $readmemh("instruction.mem", uut.instruction_mems_r);
        #1;
        $display("Index 0: %h", uut.instruction_mems_r[0]);
        $display("Index 1: %h", uut.instruction_mems_r[1]);
        $display("Index 2: %h", uut.instruction_mems_r[2]);
        $display("Index 3: %h", uut.instruction_mems_r[3]);
    end
    
    integer if_log, id_log, ex_log, mem_log, wb_log, branch_jump, forwarding_unit, flush_stall;
    
    initial begin
        if_log  = $fopen("if_stage.log", "w");
        id_log = $fopen("id_stage.log", "w");
        ex_log= $fopen("ex_stage.log", "w");
        mem_log = $fopen("mem_stage.log", "w");
        wb_log= $fopen("write_back.log", "w");
        branch_jump = $fopen("branch_jump.log", "w");
        forwarding_unit= $fopen("forwarding_unit.log", "w");
        flush_stall = $fopen("flush_stall.log", "w");
    end
    
    initial begin
        $fdisplay(if_log, "wire [31:0] if_pc_w;");
        $fdisplay(id_log, "wire [31:0] if_instruction_w;");
        $fdisplay(ex_log, "wire [31:0] if_pc_bj_w;");
        $fdisplay(mem_log, "wire if_bj_taken_w;");
        $fdisplay(wb_log, "wire if_bj_taken_w;");
        $fdisplay(branch_jump, "wire if_bj_taken_w;");
        $fdisplay(forwarding_unit, "wire if_bj_taken_w;");
        $fdisplay(flush_stall, "wire if_bj_taken_w;");
    end

    always @(posedge clk) begin
        $fdisplay(if_log,
          "[%0t][IF-SIGNAL] PC_NEXT=%h PC=%h | INSTR=%h | if_pc_bj_w=%h | if_bj_taken_w=%b",
          $time,
          uut.if_pc_w,
          uut.if_pc_next_w,
          uut.if_instruction_w,
          uut.if_pc_bj_w,
          uut.if_bj_taken_w
        );
    end
    
    always @(posedge clk) begin
        $fdisplay(id_log,
          "[%0t][ID-SIGNAL] PC=%h INSTR=%h | RS1_ADDR=%h RS1_ADDR=%h | RS1_DATA=%h RS2_DATA=%h | IMM=%h | JAL=%b JALR=%b ALU_SRC1_SE=%b ALU_SRC2_SE=%b ALU_OP=%b | MEMREAD=%b MEMWRITE=%b WIDTH_SE=%b | REGWRITE=%b WB_SE=%b RD_ADDR=%b",
          $time,
          uut.id_pc_w,
          uut.id_instruction_w,
          uut.id_rs1_addr_w,
          uut.id_rs2_addr_w,
          uut.rf_rs1_data_w,
          uut.rf_rs2_data_w,
          uut.id_imm_w,
          uut.id_jal_w,
          uut.id_jalr_w,
          uut.id_se_alu_src1_w,
          uut.id_se_alu_src2_w,
          uut.id_aluop_w,
          uut.id_memread_w,
          uut.id_memwrite_w,
          uut.id_width_se_w,
          uut.id_regwrite_w,
          uut.id_wb_se_w,
          uut.id_rd_addr_w
        );
    end
    
    always @(posedge clk) begin
        $fdisplay(ex_log,
          "[%0t][EX-SIGNAL] RS1_DATA=%h RS2_DATA=%h | OPERAND1=%h OPERAND2=%h ALU_OP=%h | ALU_RESULT=%h | BJ_PC=%h BJ_TAKEN=%h |",
          $time,
          uut.ex_rs1_data_w,
          uut.ex_rs2_data_w,
          uut.ex_operand_a_w,
          uut.ex_operand_b_w,
          uut.ex_aluop_w,
          uut.ex_alu_result_w,
          uut.ex_pc_bj_w,
          uut.ex_bj_taken_w
        );
    end
    
    always @(posedge clk) begin
        $fdisplay(mem_log,
          "[%0t][MEM-SIGNAL] MEMREAD=%h MEMWRITE=%h | WIDTH_SE=%h OFFSET=%h | ALU_RESULT=%h RS2_DATA=%h | MEM_ADDR=%h DIN0=%b DIN1=%b DIN2=%b DIN3=%h | LOAD_DATA=%h",
          $time,
          uut.mem_memread_w,
          uut.mem_memwrite_w,
          uut.mem_width_se_w,
          uut.mem_off_set_w,
          uut.mem_alu_result_w,
          uut.mem_rs2_data_w,
          uut.mem_addr_w,
          uut.din0,
          uut.din1,
          uut.din2,
          uut.din3,
          uut.load_data_w
        );
    end

    always @(posedge clk) begin
        $fdisplay(wb_log,
          "[%0t][WB-SIGNAL] SEL=%h | ALU=%h MEM=%h PC+4=%h | REG_WRITE=%h RD_ADDR=%h | WB_DATA=%h",
          $time,
          uut.wb_sel_w,
          uut.wb_alu_result_w,
          uut.wb_mem_data_w,
          uut.wb_pc_plus_w,
          uut.wb_regwrite_w,
          uut.wb_rd_addr_w,
          uut.wb_data_w,
        );
    end

    always @(posedge clk) begin
        $fdisplay(branch_jump,
          "[%0t][BRANCH-JUMP] IFPC=%h IFINSTR=%h | IDPC=%h IDINSTR=%h IDJAL=%b IDJALR=%b IDALU=%b IDIMM=%h| JAL=%b JALR=%b BRANCH=%b BJTAKEN=%b BJPC=%h ALUOP=%h OPERAND_A=%h OPERAND_B=%h RESULT=%h",
          $time,
          uut.if_pc_w,
          uut.if_instruction_w,
          uut.id_pc_w,
          uut.id_instruction_w,
          uut.id_jal_w,
          uut.id_jalr_w,
          uut.id_aluop_w,
          uut.id_imm_w,
          uut.ex_jal_w,
          uut.ex_jalr_w,
          uut.ex_alu_branch_taken_w,
          uut.ex_bj_taken_w,
          uut.ex_pc_bj_w,
          uut.ex_aluop_w,
          uut.ex_operand_a_w,
          uut.ex_operand_b_w,
          uut.ex_alu_result_w
        );
    end

    always @(posedge clk) begin
        $fdisplay(forwarding_unit,
          "[%0t][FORWARDING-UNIT] MUX1=%h MUX2=%h | SRC1=%h  SRC2=%h | MEMWB_PC+4=%h MEMWB_MEM_DATA=%h MEMWB_ALU=%h | EXMEM_PC=%h EXMEM_ALU=%h | EX_RS1=%h EX_RS2%h",
          $time,
          uut.forward_mux_1_w,
          uut.forward_mux_2_w,
          uut.forward_src_1_w,
          uut.forward_src_2_w,
          uut.memwb_pc_plus_r,
          uut.memwb_mem_data_r,
          uut.memwb_alu_result_r,
          uut.exmem_pc_plus_r,
          uut.exmem_alu_result_r,
          uut.ex_rs1_data_w,
          uut.ex_rs2_data_w
        );
    end

    always @(posedge clk) begin
        $fdisplay(flush_stall,
          "[%0t][FLUSH] IFID=%b IDEX=%b EXMEM=%b |[STALL] PC=%b IFID=%b IDEX=%b EXMEM=%b | MEM_MEMREAD=%b IF_BJ_TAKEN=%b",
          $time,
          uut.flush_ifid,
          uut.flush_idex,
          uut.flush_exmem,
          uut.stall_pc,
          uut.stall_ifid,
          uut.stall_idex,
          uut.stall_exmem,
          uut.mem_memread_w,
          uut.if_bj_taken_w
        );
    end


    initial begin
        #800;
        $fclose(if_log);
        $fclose(if_log);
        $fclose(if_log);
        $fclose(if_log);
        $writememh("regfile_dump.mem", uut.registers);
        $finish;
    end
    
endmodule
