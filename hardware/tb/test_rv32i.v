`timescale 1ns/1ps

module tb_risc_rv32i;

  reg clk = 0;
  reg rst = 1;

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
        
    end 
   
    initial begin
        $readmemh("test_46.mem", uut.instruction_mems_r);
        #1;
        $display("Index 0: %h", uut.instruction_mems_r[0]);
        $display("Index 1: %h", uut.instruction_mems_r[1]);
        $display("Index 2: %h", uut.instruction_mems_r[2]);
        $display("Index 3: %h", uut.instruction_mems_r[3]);
        #400;
        $writememh("regfile_dump.mem", uut.registers);
    end
    
    integer ex_log, mem_log, misc_log;
    
    initial begin
        ex_log  = $fopen("ex_stage.log",  "w");
        mem_log = $fopen("mem_stage.log", "w");
        misc_log= $fopen("misc.log",      "w");
    end
    
    always @(posedge clk) begin
        $fdisplay(ex_log,
          "[%0t][IF->EX] PC=%h INST=%h | RS1=%0d RS2=%0d RD=%0d | SRC1=%b SRC2=%b ALUOP=%h IMM=%h | JAL=%b JALR=%b",
          $time,
          ifid_pc, ifid_instruction,
          ex_rs1_addr, ex_rs2_addr, ex_rd_addr,
          ex_alu_src1, ex_alu_src2, ex_aluop, ex_imm,
          ex_jal, ex_jalr
        );
    end

    always @(posedge clk) begin
        $fdisplay(mem_log,
          "[%0t][IF->MEM] PC=%h INST=%h | MEMR=%b MEMW=%b WIDTH=%b WBSEL=%b REGW=%b",
          $time,
          ifid_pc, ifid_instruction,
          ex_memread, ex_memwrite, ex_width_se, ex_wb_se, ex_regwrite
        );
    end
    
    always @(posedge clk) begin
        $fdisplay(misc_log,
          "[%0t][MISC] PC=%h INST=%h | RF_WE=%b RF_RD=%0d RF_WDATA=%h | EX_PC=%h RS1_DATA=%h RS2_DATA=%h",
          $time,
          ifid_pc, ifid_instruction,
          rf_reg_write, rf_rd_addr, rf_rd_data,
          ex_pc, ex_rs1_data, ex_rs2_data
        );
    end
    
        
    always @(posedge clk) begin
        $fdisplay(if_log,
          "[%0t][IF] PC=%h NEXT=%h INST=%h | BJ_PC=%h BJ_TAKEN=%b | STALL=%b FLUSH=%b",
          $time,
          uut.if_pc_w,
          uut.if_pc_next_w,
          uut.if_instruction_w,
          uut.if_pc_bj_w,
          uut.if_bj_taken_w,
          uut.stall_ifid,
          uut.flush_ifid
        );
    end
    
    initial begin
        #400;
        $fclose(if_log);
        $fclose(if_log);
        $fclose(if_log);
        $fclose(if_log);
        $writememh("regfile_dump.mem", uut.registers);
        $finish;
    end
    
endmodule
