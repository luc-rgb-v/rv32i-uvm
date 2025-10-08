`timescale 1ns/1ps
// ------------------------------------------------------------
// MEM stage pipeline register (no data memory inside)
// - Passes through EX results and control to WB
// - Latches data from external data memory port
// - Priority: reset > flush > (~stall) update > (stall) hold
//
// memtoreg encoding (from your control unit):
//   2'b00 = ALU result
//   2'b01 = Memory load data
//   2'b10 = PC+4
// ------------------------------------------------------------
module mem_stage (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire        flush_i,
    input  wire        stall_i,

    // From EX stage
    input  wire        regwrite_i,          // bypass: write-enable to RF
    input  wire [4:0]  rd_addr_i,           // bypass: destination reg
    input  wire [1:0]  memtoreg_i,          // bypass: 00=ALU, 01=MEM, 10=PC+4
    input  wire [31:0] pc_address_i,        // bypass: PC for this instr (for PC+4 path)
    input  wire [31:0] alu_result_i,        // bypass: ALU result (also mem addr)
    input  wire        ex_valid_i,

    // From external data memory (already read this cycle)
    input  wire [31:0] data_memory_i,       // load data / raw memory read

    // To WB stage (registered)
    output reg         regwrite_o,
    output reg  [4:0]  rd_addr_o,
    output reg  [1:0]  memtoreg_o,
    output reg  [31:0] pc_address_o,
    output reg  [31:0] alu_result_o,
    output reg  [31:0] data_mem_o

    // Optional: expose a valid flag if your pipeline uses it
    //,output reg         valid_o
);

    // Local task to clear all registered outputs (reset/flush)
    task automatic clear_regs;
    begin
        regwrite_o   <= 1'b0;
        rd_addr_o    <= 5'b0;
        memtoreg_o   <= 2'b0;
        pc_address_o <= 32'b0;
        alu_result_o <= 32'b0;
        data_mem_o   <= 32'b0;
        // valid_o      <= 1'b0;
    end
    endtask

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            clear_regs();
        end else if (flush_i) begin
            // Insert bubble into MEM/WB
            clear_regs();
        end else if (!stall_i && (ex_valid_i == 1'b1)) begin
            // Normal pipeline advance
            regwrite_o   <= regwrite_i;
            rd_addr_o    <= rd_addr_i;
            memtoreg_o   <= memtoreg_i;
            pc_address_o <= pc_address_i;
            alu_result_o <= alu_result_i;
            data_mem_o   <= data_memory_i;
            // valid_o      <= 1'b1;
        end
        // else: stall_i==1 -> hold previous values (no assignments)
    end

endmodule
