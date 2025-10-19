`timescale 1ns/1ps
// Adds PC+4 forwarding for JAL/JALR and blocks EX-stage forwarding of loads.
// Output encoding (3 bits) selects the producer & source:
//   000: no forwarding
//   001: EX/MEM -> ALU result          (memtoreg = 00)
//   010: EX/MEM -> PC+4                (memtoreg = 10)  // JAL/JALR link
//   011: MEM/WB -> ALU result          (memtoreg = 00)
//   100: MEM/WB -> MEM data            (memtoreg = 01)  // loads
//   101: MEM/WB -> PC+4                (memtoreg = 10)

module forwarding_unit (
    input  [4:0] reg_file_read_address_0_ID_EXE,
    input  [4:0] reg_file_read_address_1_ID_EXE,

    input        reg_file_write_EX_MEM,
    input  [4:0] reg_file_write_address_EX_MEM,
    input  [1:0] mux_0_sel_EX_MEM,     // producer's memtoreg in EX/MEM

    input        reg_file_write_MEM_WB,
    input  [4:0] reg_file_write_address_MEM_WB,
    input  [1:0] mux_0_sel_MEM_WB,     // producer's memtoreg in MEM/WB

    output [2:0] forward_mux_0_control,
    output [2:0] forward_mux_1_control
);

    // memtoreg encodings from control unit
    localparam M2R_ALU = 2'b00;
    localparam M2R_MEM = 2'b01;
    localparam M2R_PC4 = 2'b10;

    // --- matches (ignore x0) ---
    wire ex_match_0 = reg_file_write_EX_MEM &&
                      (reg_file_read_address_0_ID_EXE == reg_file_write_address_EX_MEM) &&
                      (reg_file_read_address_0_ID_EXE != 5'b00000);

    wire wb_match_0 = reg_file_write_MEM_WB &&
                      (reg_file_read_address_0_ID_EXE == reg_file_write_address_MEM_WB) &&
                      (reg_file_read_address_0_ID_EXE != 5'b00000);

    wire ex_match_1 = reg_file_write_EX_MEM &&
                      (reg_file_read_address_1_ID_EXE == reg_file_write_address_EX_MEM) &&
                      (reg_file_read_address_1_ID_EXE != 5'b00000);

    wire wb_match_1 = reg_file_write_MEM_WB &&
                      (reg_file_read_address_1_ID_EXE == reg_file_write_address_MEM_WB) &&
                      (reg_file_read_address_1_ID_EXE != 5'b00000);

    // --- Operand 0 forwarding ---
    // Priority: EX/MEM over MEM/WB
    assign forward_mux_0_control =
        // EX/MEM: ALU result is ready in EX stage
        (ex_match_0 && (mux_0_sel_EX_MEM == M2R_ALU)) ? 3'b001 :
        // EX/MEM: PC+4 from JAL/JALR (available alongside EX)
        (ex_match_0 && (mux_0_sel_EX_MEM == M2R_PC4)) ? 3'b010 :
        // MEM/WB: ALU result
        (wb_match_0 && (mux_0_sel_MEM_WB == M2R_ALU)) ? 3'b011 :
        // MEM/WB: MEM data (loads only ready here)
        (wb_match_0 && (mux_0_sel_MEM_WB == M2R_MEM)) ? 3'b100 :
        // MEM/WB: PC+4
        (wb_match_0 && (mux_0_sel_MEM_WB == M2R_PC4)) ? 3'b101 :
        3'b000;

    // --- Operand 1 forwarding ---
    assign forward_mux_1_control =
        (ex_match_1 && (mux_0_sel_EX_MEM == M2R_ALU)) ? 3'b001 :
        (ex_match_1 && (mux_0_sel_EX_MEM == M2R_PC4)) ? 3'b010 :
        (wb_match_1 && (mux_0_sel_MEM_WB == M2R_ALU)) ? 3'b011 :
        (wb_match_1 && (mux_0_sel_MEM_WB == M2R_MEM)) ? 3'b100 :
        (wb_match_1 && (mux_0_sel_MEM_WB == M2R_PC4)) ? 3'b101 :
        3'b000;

endmodule
