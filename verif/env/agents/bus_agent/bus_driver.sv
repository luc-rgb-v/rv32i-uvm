`ifndef BUS_DRIVER
`define BUS_DRIVER

`include "uvm_macros.svh"

class bus_driver extends uvm_driver#(risc_transaction);

  `uvm_component_utils(bus_driver)

  // transaction handles
  risc_transaction req;
  risc_transaction rsp;

  // virtual interface to the DUT (assumed name - change if different)
  virtual bus_if vif;

  // publish what we drove (optional)
  uvm_analysis_port#(risc_transaction) drv2rm_port;

  // constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new

  // build phase - get virtual interface and create analysis port
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual bus_if)::get(this, "", "vif", vif)) begin
      `uvm_fatal("NOVIF", {"Virtual interface not set for: ", get_full_name(), ".vif"})
    end
    drv2rm_port = new("drv2rm_port", this);
  endfunction : build_phase

  // run phase - fetch items and drive them to the DUT
  virtual task run_phase(uvm_phase phase);
    // initialize outputs on interface
    reset_drive();
    forever begin
      // get next sequence item (blocking)
      seq_item_port.get_next_item(req);

      // drive the item to DUT
      drive_item(req);

      // optionally report
      `uvm_info(get_full_name(), $sformatf("Driver drove transaction"), UVM_LOW)
      if (req != null) req.print();

      // publish driven item to analysis port (observer/checkers can use it)
      drv2rm_port.write(req);

      // tell sequencer we're done
      seq_item_port.item_done();
    end
  endtask : run_phase

  // task to actually drive DUT signals (synchronized to DUT clock)
  task drive_item(risc_transaction it);
    // wait until reset deasserted (active-high reset assumed)
    wait (vif.rst_i == 1'b0);

    // make sure we drive on a clock edge to meet timing
    @(posedge vif.clk_i);

    // Drive inputs — adapt field names to your transaction
`ifdef DEBUG_INSTRUCTION
    // If DUT has instruction_i and pc_i ports under DEBUG_INSTRUCTION,
    // drive them from the transaction fields (if present)
    if (it != null) begin
      vif.instruction_i <= it.instruction;
      vif.pc_i          <= it.pc;
    end
`endif

`ifndef MEMDELAY
    // If DUT uses an external stall input (named stall_i in module),
    // drive it if present in the transaction. Otherwise leave default.
    if (it != null) begin
      vif.stall_i <= it.stall;
    end
`endif

    // If you have other external inputs (e.g., memory responses), drive them here
    // e.g. vif.mem_data_i <= it.mem_data;

    // hold values for one cycle (or as your interface requires)
    @(posedge vif.clk_i);

    // Optionally clear single-cycle strobes if needed:
`ifdef DEBUG_INSTRUCTION
    // keep instruction/pc stable as needed, here we keep for one cycle then release
    // (adjust to your bus protocol)
`endif
  endtask : drive_item

  // reset internal outputs/inputs to safe default values
  task reset_drive();
    // if interface has signals, set safe default values
    // do not block; use nonblocking assignment to match driving style
`ifdef DEBUG_INSTRUCTION
    vif.instruction_i <= '0;
    vif.pc_i          <= '0;
`endif

`ifndef MEMDELAY
    vif.stall_i <= 1'b0;
`endif

    // wait a couple clocks to ensure stability
    if (vif != null) begin
      repeat (2) @(posedge vif.clk_i);
    end
  endtask : reset_drive

endclass : bus_driver

`endif
