`ifndef RISC_V_TB_TOP
`define RISC_V_TB_TOP

`include "uvm_macros.svh"
`include "riscv_interface.sv"
import uvm_pkg::*;

// Optional: include your UVM test package
import riscv_test_list::*;

module riscv_tb_top;

  //--------------------------------------------------------------------------
  // Clock / Reset Parameters
  //--------------------------------------------------------------------------
  parameter CLK_PERIOD = 10ns;
  bit clk_i;
  bit rst_i;

  //--------------------------------------------------------------------------
  // Clock Generation
  //--------------------------------------------------------------------------
  initial begin
    clk_i = 0;
    forever #(CLK_PERIOD/2) clk_i = ~clk_i;
  end

  //--------------------------------------------------------------------------
  // Reset Generation
  //--------------------------------------------------------------------------
  initial begin
    rst_i = 1;
    #(CLK_PERIOD * 5);
    rst_i = 0;
  end

  //--------------------------------------------------------------------------
  // Interface Instantiation (connect TB ↔ DUT)
  //--------------------------------------------------------------------------
  riscv_interface riscv_intf(.clk_i(clk_i), .rst_i(rst_i));

  //--------------------------------------------------------------------------
  // DUT Instantiation
  //--------------------------------------------------------------------------
  risc_rv32i dut_inst (
    .clk_i(clk_i),
    .rst_i(rst_i)
`ifdef DEBUG
    ,.pc(riscv_intf.pc)
    ,.ifid_pc(riscv_intf.ifid_pc)
    ,.ifid_instruction(riscv_intf.ifid_instruction)
    ,.idex_imm(riscv_intf.idex_imm)
    ,.idex_rs1_data(riscv_intf.idex_rs1_data)
    ,.idex_rs2_data(riscv_intf.idex_rs2_data)
    ,.exif_bj_taken()             // optional: not yet defined in interface
    ,.exif_pc_bj()
    ,.exmem_alu_result(riscv_intf.exmem_alu_result)
    ,.exmem_rs2_data(riscv_intf.exmem_rd_data)
    ,.memwb_alu_result(riscv_intf.memwb_rd_data)
    ,.memwb_mem_data()
    ,.memwb_pc_plus()
    ,.wb_regwrite(riscv_intf.memwb_regwrite)
    ,.wb_rd_addr(riscv_intf.memwb_rd_addr)
    ,.wb_data()
`endif
`ifdef DEBUG_INSTRUCTION
    ,.instruction_i() // optional — can connect from driver via interface later
    ,.pc_i()
`endif
`ifndef MEMDELAY
    ,.stall_i(1'b0)
`endif
  );

  //--------------------------------------------------------------------------
  // UVM Config-DB Setup
  //--------------------------------------------------------------------------
  initial begin
    uvm_config_db#(virtual riscv_interface)::set(
      null, "*", "intf", riscv_intf
    );
  end

  //--------------------------------------------------------------------------
  // Start UVM Test
  //--------------------------------------------------------------------------
  initial begin
    run_test();
  end

endmodule : riscv_tb_top

`endif // RISC_V_TB_TOP
