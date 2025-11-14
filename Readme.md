# Advance Topic in ICC - RV32I UVM Projects

This repository contains UVM and Verilog-based projects for the RV32I processor, including examples of arithmetic, load/store, and branch unit verification using UVM methodology. It also includes reference designs, testbenches, and supporting tools.
- **Tuan, An, Tan**: Used **EDA Playground** to develop UVM 1.2 testbenches for the **RV32I DUT**. Each focused on different modules:
  - Tuan: Branch unit verification
  - An: Arithmetic unit verification
  - Tan: Load/Store unit verification  

- **Luc**: Implemented a **UVM environment in Vivado**, integrating the **Spike RV32I reference model** into the simulation flow.  

- **Memory Handling**: All memory initialization and instruction files were collaboratively used to create the UVM environment. Tasks were distributed among team members to ensure proper coverage and verification workflow.  
---

## Project Structure

.
├── Other
│ ├── Adder_4_bit.zip # Example 4-bit adder project
│ └── uvm_forwarding.rar # UVM forwarding unit example
├── Readmem.md # Documentation of memory contents
├── UVM_An_arithmetic
│ └── uvm_An_arithmetic.zip # UVM project for arithmetic unit
├── UVM_Luc_src
│ ├── run
│ │ ├── run.command # Command to run simulation
│ │ └── run.tcl # TCL script for simulation
│ ├── src
│ │ └── rv32i.v # RV32I RTL source
│ ├── tb
│ │ ├── instruction.mem # Instruction memory
│ │ ├── test_46.mem # Test program memory
│ │ └── test_rv32i.v # Simple testbench
│ └── verif
│ ├── env
│ │ ├── agents
│ │ │ └── bus_agent # Bus agent files
│ │ ├── ref_model # Reference model files
│ │ └── top # Environment top and scoreboard
│ ├── tb
│ │ ├── rv32i_interface.sv # Interface definition
│ │ └── rv32i_tb_top.sv # Top-level UVM testbench
│ └── tests # UVM test sequences and tests
├── UVM_Tan_load_store
│ └── UVM_TAN.zip # Load/store unit UVM project
├── UVM_Tuan_branch
│ └── uvm_Tuan_branch.zip # Branch unit UVM project
└── Vivado
└── rv32i_uvm.rar # Vivado project for RV32I with UVM
---

## Features

- **UVM Testbenches**: Comprehensive environment for RV32I functional verification.
- **RTL Designs**: RV32I processor and modules including ALU, forwarding, and load/store units.
- **Reference Models**: For comparison and scoreboard checking.
- **Test Sequences**: Arithmetic, branch, and load/store sequences included.
- **Simulation Scripts**: TCL and command-line scripts for running simulations.
- **Memory Initialization**: Preloaded instruction memories for tests.

---

## Usage

1. **Unzip the desired project** from the `UVM_*` or `Other` folders.
2. **Open your simulator** (e.g., QuestaSim, VCS, or Vivado).
3. **Run the simulation** using either:
   - The `run.command` file (Unix-based systems), or  
   - The provided TCL scripts.
4. **Observe waveforms** and test results to verify module functionality.
5. **Add new tests** in `verif/tests` and update `test_list.sv` to include them.

---

## Notes

- Ensure your simulator supports **SystemVerilog and UVM 1.2**.
- The `instruction.mem` and `test_*.mem` files are used to preload instruction memory for testing.
- The `Readmem.md` contains descriptions of memory contents used in tests.

---

## References

- RISC-V RV32I ISA specification: [https://riscv.org/](https://riscv.org/)
- UVM 1.2 User Guide: [https://accellera.org/downloads/standards/uvm](https://accellera.org/downloads/standards/uvm)
