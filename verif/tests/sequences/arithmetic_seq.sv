`ifndef RISC_V_BASIC_SEQ
`define RISC_V_BASIC_SEQ

//-----------------------------------------------------------------------------
// Sequence: riscv_basic_seq
// Description: Sends randomized RISC-V transactions through the sequencer
//-----------------------------------------------------------------------------

class riscv_basic_seq extends uvm_sequence#(riscv_transaction);

  //--------------------------------------------------------------------------
  // Factory registration
  //--------------------------------------------------------------------------
  `uvm_object_utils(riscv_basic_seq)

  //--------------------------------------------------------------------------
  // Constructor
  //--------------------------------------------------------------------------
  function new(string name = "riscv_basic_seq");
    super.new(name);
  endfunction : new

  //--------------------------------------------------------------------------
  // Body Task
  // Description:
  //   - Randomizes and sends multiple RISC-V instruction transactions
  //   - Uses start_item / finish_item protocol
  //--------------------------------------------------------------------------
  virtual task body();
    `uvm_info(get_type_name(), "Starting riscv_basic_seq ...", UVM_LOW);

    for (int i = 0; i < `NO_OF_TRANSACTIONS; i++) begin
      req = riscv_transaction::type_id::create("req", this);

      start_item(req);
      if (!req.randomize()) begin
        `uvm_error(get_type_name(), "Randomization failed for riscv_transaction")
      end
      else begin
        `uvm_info(get_type_name(), $sformatf("Randomized RISC-V Transaction %0d:", i), UVM_LOW);
        req.print();
      end
      finish_item(req);

      // Wait for driver response (optional)
      get_response(rsp);
    end

    `uvm_info(get_type_name(), "Completed riscv_basic_seq.", UVM_LOW);
  endtask : body

endclass : riscv_basic_seq

`endif // RISC_V_BASIC_SEQ
