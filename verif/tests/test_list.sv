`ifndef RISC_V_TEST_LIST
`define RISC_V_TEST_LIST

package riscv_test_list;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  //--------------------------------------------------------------------------
  // Import RISC-V environment and sequence packages
  //--------------------------------------------------------------------------
  import riscv_env_pkg::*;
  import riscv_seq_list::*;

  //--------------------------------------------------------------------------
  // Include all RISC-V test files here
  //--------------------------------------------------------------------------
  `include "riscv_basic_test.sv"

endpackage : riscv_test_list

`endif // RISC_V_TEST_LIST
