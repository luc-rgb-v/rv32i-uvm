`timescale 1ns/1ps
// ============================================================================
// hazard_control_unit
// - Generates stall/flush for a 5-stage RV32I pipeline
// - Assumes: forwarding resolves ALU hazards; only true stall is load-use
// - IF stage self-flushes on take_b_j_sig_i (from EX), so we only flush ID/EX
// ============================================================================
// Inputs:
//   id_valid_i            : IF/ID holds a valid instruction
//   id_rs1_addr_i/rs2     : source regs of the instruction currently in ID
//   ex_valid_i            : ID/EX holds a valid instruction
//   ex_rd_addr_i          : destination reg of the instruction in EX
//   ex_memread_i          : the EX instruction is a load (will read DMEM)
//   ex_take_b_j_i         : branch/jump is taken in EX (redirect)
//
// Outputs:
//   stall_if_o            : hold PC and IF/ID
//   stall_id_o            : hold IF/ID (decode)
//   flush_id_ex_o         : bubble the ID/EX register (insert NOP into EX)
// ============================================================================
module hazard_control_unit (
    // IDs
    input  wire        id_valid_i,
    input  wire [4:0]  id_rs1_addr_i,
    input  wire [4:0]  id_rs2_addr_i,

    // EXs
    input  wire        ex_valid_i,
    input  wire [4:0]  ex_rd_addr_i,
    input  wire        ex_memread_i,      // 1 when EX is a load
    input  wire        ex_take_b_j_i,     // 1 when EX resolves a taken branch/jump

    // control outs
    output wire        stall_if_o,
    output wire        stall_id_o,
    output wire        flush_id_ex_o
);

    // ---------------------------
    // Load–use hazard detection:
    // ID uses rs1/rs2 that match EX.rd of a LOAD
    // ---------------------------
    wire rs1_dep = id_valid_i && ex_valid_i &&
                   (id_rs1_addr_i != 5'd0) &&
                   (id_rs1_addr_i == ex_rd_addr_i);

    wire rs2_dep = id_valid_i && ex_valid_i &&
                   (id_rs2_addr_i != 5'd0) &&
                   (id_rs2_addr_i == ex_rd_addr_i);

    wire load_use_hazard = ex_memread_i && (rs1_dep || rs2_dep);

    // ---------------------------
    // Stalls and flushes
    // ---------------------------
    // On load-use:
    //   - stall IF & ID  (hold PC and IF/ID)
    //   - flush ID/EX    (insert a bubble into EX)
    //
    // On taken branch/jump:
    //   - IF already self-flushes (via your IF core)
    //   - also flush ID/EX to kill the wrong-path instruction in ID
    // ---------------------------
    assign stall_if_o    = load_use_hazard;
    assign stall_id_o    = load_use_hazard;
    assign flush_id_ex_o = load_use_hazard | ex_take_b_j_i;

endmodule
