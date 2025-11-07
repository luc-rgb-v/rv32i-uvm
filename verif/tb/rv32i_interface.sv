`ifndef RISC_V_INTERFACE
`define RISC_V_INTERFACE

//-----------------------------------------------------------------------------
// Interface: riscv_interface
// Description: Interface between RV32I DUT and UVM testbench
//-----------------------------------------------------------------------------

interface riscv_interface(input logic clk_i, rst_i);

  //--------------------------------------------------------------------------
  // DUT I/O Signals
  //--------------------------------------------------------------------------
  // Inputs driven by testbench (if any external stimuli exist)
  logic        clk;
  logic        rst;

  // Debug / Pipeline signals (monitored only)
  logic [31:0] pc;
  logic [31:0] ifid_pc;
  logic [31:0] ifid_instruction;
  logic [31:0] idex_imm;
  logic [31:0] idex_rs1_data;
  logic [31:0] idex_rs2_data;
  logic [31:0] idex_alu_result;
  logic [31:0] exmem_alu_result;
  logic [31:0] exmem_rd_data;
  logic [31:0] memwb_rd_data;

  logic [4:0]  idex_rd_addr;
  logic [4:0]  exmem_rd_addr;
  logic [4:0]  memwb_rd_addr;

  logic        idex_memread;
  logic        idex_memwrite;
  logic        idex_regwrite;
  logic        exmem_memread;
  logic        exmem_memwrite;
  logic        exmem_regwrite;
  logic        memwb_regwrite;

  //--------------------------------------------------------------------------
  // Clocking block for DRIVER
  // (if DUT accepts inputs, e.g., instruction or memory data)
  //--------------------------------------------------------------------------
  clocking dr_cb @(posedge clk_i);
    default input #1step output #1step;
    // Example: testbench drives instruction or memory bus
    // output instr_req;
    // output instr_addr;
    // input  instr_rdata;
  endclocking

  modport DRV (
    clocking dr_cb,
    input clk_i, rst_i
  );

  //--------------------------------------------------------------------------
  // Clocking block for MONITOR
  // Samples all pipeline/debug signals from DUT
  //--------------------------------------------------------------------------
  clocking rc_cb @(negedge clk_i);
    default input #1step output #1step;
    input pc;
    input ifid_pc;
    input ifid_instruction;
    input idex_imm;
    input idex_rs1_data;
    input idex_rs2_data;
    input idex_alu_result;
    input exmem_alu_result;
    input exmem_rd_data;
    input memwb_rd_data;
    input idex_rd_addr;
    input exmem_rd_addr;
    input memwb_rd_addr;
    input idex_memread;
    input idex_memwrite;
    input idex_regwrite;
    input exmem_memread;
    input exmem_memwrite;
    input exmem_regwrite;
    input memwb_regwrite;
  endclocking

  modport RCV (
    clocking rc_cb,
    input clk_i, rst_i
  );

endinterface : riscv_interface

`endif // RISC_V_INTERFACE
