`ifndef bus_TRANSACTION
`define bus_TRANSACTION

//----------------------------------------------------------------------
// Transaction class for risc_rv32i DUT
//----------------------------------------------------------------------

class bus_transaction extends uvm_sequence_item;

  // ================================================================
  //  Transaction fields (represent DUT inputs and expected outputs)
  // ================================================================

  // Inputs to DUT (driven by driver)
`ifdef DEBUG_INSTRUCTION
  rand bit [31:0] instruction;   // instruction to feed DUT (instruction_i)
  rand bit [31:0] pc;            // program counter input (pc_i)
`endif

`ifndef MEMDELAY
  rand bit stall;                // external stall input (stall_i)
`endif

  // DUT outputs (sampled by monitor)
`ifdef DEBUG
  bit [31:0] pc_out;
  bit [31:0] ifid_pc;
  bit [31:0] ifid_instruction;
  bit [31:0] idex_imm;
  bit [31:0] idex_rs1_data;
  bit [31:0] idex_rs2_data;
  bit        exif_bj_taken;
  bit [31:0] exif_pc_bj;
  bit [31:0] exmem_alu_result;
  bit [31:0] exmem_rs2_data;
  bit [31:0] memwb_alu_result;
  bit [31:0] memwb_mem_data;
  bit [31:0] memwb_pc_plus;
  bit        wb_regwrite;
  bit [4:0]  wb_rd_addr;
  bit [31:0] wb_data;
`endif

  // ================================================================
  //  Register fields with factory + enable automation for UVM
  // ================================================================
  `uvm_object_utils_begin(bus_transaction)
`ifdef DEBUG_INSTRUCTION
    `uvm_field_int(instruction, UVM_ALL_ON)
    `uvm_field_int(pc, UVM_ALL_ON)
`endif
`ifndef MEMDELAY
    `uvm_field_int(stall, UVM_ALL_ON)
`endif
`ifdef DEBUG
    `uvm_field_int(pc_out, UVM_ALL_ON)
    `uvm_field_int(ifid_pc, UVM_ALL_ON)
    `uvm_field_int(ifid_instruction, UVM_ALL_ON)
    `uvm_field_int(idex_imm, UVM_ALL_ON)
    `uvm_field_int(idex_rs1_data, UVM_ALL_ON)
    `uvm_field_int(idex_rs2_data, UVM_ALL_ON)
    `uvm_field_int(exif_bj_taken, UVM_ALL_ON)
    `uvm_field_int(exif_pc_bj, UVM_ALL_ON)
    `uvm_field_int(exmem_alu_result, UVM_ALL_ON)
    `uvm_field_int(exmem_rs2_data, UVM_ALL_ON)
    `uvm_field_int(memwb_alu_result, UVM_ALL_ON)
    `uvm_field_int(memwb_mem_data, UVM_ALL_ON)
    `uvm_field_int(memwb_pc_plus, UVM_ALL_ON)
    `uvm_field_int(wb_regwrite, UVM_ALL_ON)
    `uvm_field_int(wb_rd_addr, UVM_ALL_ON)
    `uvm_field_int(wb_data, UVM_ALL_ON)
`endif
  `uvm_object_utils_end

  // ================================================================
  // Constructor
  // ================================================================
  function new(string name = "bus_transaction");
    super.new(name);
  endfunction

  // ================================================================
  // Constraints for randomized fields
  // ================================================================
`ifdef DEBUG_INSTRUCTION
  constraint instr_range_c {
    instruction inside {[32'h0000_0000 : 32'hFFFF_FFFF]};
  }
  constraint pc_range_c {
    pc inside {[32'h0000_0000 : 32'hFFFF_FFFF]};
  }
`endif

`ifndef MEMDELAY
  constraint stall_c { stall inside {0,1}; }
`endif

  // ================================================================
  // post_randomize() — optional debug print after randomization
  // ================================================================
  function void post_randomize();
    `uvm_info("bus_TX", $sformatf("Post-randomize: instruction=0x%08h pc=0x%08h stall=%0b",
`ifdef DEBUG_INSTRUCTION
    instruction, pc,
`else
    32'h0, // filler
`endif
`ifndef MEMDELAY
    stall
`else
    1'b0
`endif
), UVM_LOW)
  endfunction

endclass : bus_transaction

`endif
