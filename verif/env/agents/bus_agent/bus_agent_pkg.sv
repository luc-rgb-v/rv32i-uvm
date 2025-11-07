`ifndef BUS_AGENT_PKG
`define BUS_AGENT_PKG

package bus_agent_pkg;
 
   import uvm_pkg::*;
   `include "uvm_macros.svh"

   //////////////////////////////////////////////////////////
   // include Agent components : driver,monitor,sequencer
   /////////////////////////////////////////////////////////
  `include "bus_defines.svh"
  `include "bus_transaction.sv"
  `include "bus_sequencer.sv"
  `include "bus_driver.sv"
  `include "bus_monitor.sv"
  `include "bus_agent.sv"

endpackage

`endif


