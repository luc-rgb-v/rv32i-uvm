`ifndef BUS_AGENT 
`define BUS_AGENT

class bus_agent extends uvm_agent;
  ///////////////////////////////////////////////////////////////////////////////
  // Declaration of UVC components such as.. driver,monitor,sequencer..etc
  ///////////////////////////////////////////////////////////////////////////////
  bus_driver    driver;
  bus_sequencer sequencer;
  bus_monitor   monitor;
  ///////////////////////////////////////////////////////////////////////////////
  // Declaration of component utils 
  ///////////////////////////////////////////////////////////////////////////////
  `uvm_component_utils(bus_agent)
  ///////////////////////////////////////////////////////////////////////////////
  // Method name : new 
  // Description : constructor
  ///////////////////////////////////////////////////////////////////////////////
  function new (string name, uvm_component parent);
    super.new(name, parent);
  endfunction : new
  ///////////////////////////////////////////////////////////////////////////////
  // Method name : build-phase 
  // Description : construct the components such as.. driver,monitor,sequencer..etc
  ///////////////////////////////////////////////////////////////////////////////
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    driver = bus_driver::type_id::create("driver", this);
    sequencer = bus_sequencer::type_id::create("sequencer", this);
    monitor = bus_monitor::type_id::create("monitor", this);
  endfunction : build_phase
  ///////////////////////////////////////////////////////////////////////////////
  // Method name : connect_phase 
  // Description : connect tlm ports ande exports (ex: analysis port/exports) 
  ///////////////////////////////////////////////////////////////////////////////
  function void connect_phase(uvm_phase phase);
      driver.seq_item_port.connect(sequencer.seq_item_export);
  endfunction : connect_phase
 
endclass : bus_agent

`endif
