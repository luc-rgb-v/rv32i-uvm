`ifndef BUS_MONITOR
`define BUS_MONITOR

`include "uvm_macros.svh"

class bus_monitor extends uvm_monitor;

  // ============================================================
  // Virtual interface connected to DUT signals
  // ============================================================
  virtual bus_if vif;

  // ============================================================
  // Analysis port — sends observed transactions to scoreboard
  // ============================================================
  uvm_analysis_port#(bus_transaction) mon2sb_port;

  // ============================================================
  // Local transaction handle
  // ============================================================
  bus_transaction act_trans;

  // ============================================================
  // UVM factory registration
  // ============================================================
  `uvm_component_utils(bus_monitor)

  // ============================================================
  // Constructor
  // ============================================================
  function new(string name, uvm_component parent);
    super.new(name, parent);
    mon2sb_port = new("mon2sb_port", this);
  endfunction : new

  // ============================================================
  // Build phase — get virtual interface
  // ============================================================
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual bus_if)::get(this, "", "vif", vif))
      `uvm_fatal("NOVIF", {"Virtual interface not set for: ", get_full_name(), ".vif"})
  endfunction : build_phase

  // ============================================================
  // Run phase — continuously capture DUT outputs
  // ============================================================
  virtual task run_phase(uvm_phase phase);
    // wait for reset release before monitoring
    wait (vif.rst_i == 1'b0);

    forever begin
      @(posedge vif.clk_i);
      collect_transaction();
    end
  endtask : run_phase

  // ============================================================
  // Collect one transaction snapshot from DUT signals
  // ============================================================
  task collect_transaction();
    act_trans = bus_transaction::type_id::create("act_trans", this);

`ifdef DEBUG
    act_trans.pc_out          = vif.pc;
    act_trans.ifid_pc         = vif.ifid_pc;
    act_trans.ifid_instruction= vif.ifid_instruction;
    act_trans.idex_imm        = vif.idex_imm;
    act_trans.idex_rs1_data   = vif.idex_rs1_data;
    act_trans.idex_rs2_data   = vif.idex_rs2_data;
    act_trans.exif_bj_taken   = vif.exif_bj_taken;
    act_trans.exif_pc_bj      = vif.exif_pc_bj;
    act_trans.exmem_alu_result= vif.exmem_alu_result;
    act_trans.exmem_rs2_data  = vif.exmem_rs2_data;
    act_trans.memwb_alu_result= vif.memwb_alu_result;
    act_trans.memwb_mem_data  = vif.memwb_mem_data;
    act_trans.memwb_pc_plus   = vif.memwb_pc_plus;
    act_trans.wb_regwrite     = vif.wb_regwrite;
    act_trans.wb_rd_addr      = vif.wb_rd_addr;
    act_trans.wb_data         = vif.wb_data;
`endif

`ifdef DEBUG_INSTRUCTION
    act_trans.instruction = vif.instruction_i;
    act_trans.pc          = vif.pc_i;
`endif

`ifndef MEMDELAY
    act_trans.stall = vif.stall_i;
`endif

    // Send observed transaction to the scoreboard
    mon2sb_port.write(act_trans);

    `uvm_info(get_full_name(),
      $sformatf("MONITOR captured transaction @time %0t", $time),
      UVM_LOW)
  endtask : collect_transaction

endclass : bus_monitor

`endif
