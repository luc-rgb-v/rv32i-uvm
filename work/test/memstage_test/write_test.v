` timescale 1ns / 1ps
//================= 
// 17/10/2025
// mem_stage.v
//=================

module memstage (
    input wire clk_i,
    input wire rst_i,
    input wire stall_i,
    input wire flush_i,

    // From EX
    input  wire        regwrite_i,
    input  wire [4:0]  rd_addr_i,
    input  wire [1:0]  memtoreg_i,      // 00=ALU, 01=MEM, 10=PC+4
    input  wire [31:0] pc_address_i,
    input  wire [31:0] alu_result_i,    // byte address
    input  wire [31:0] store_data_i,
    input  wire        memread_i,
    input  wire        memwrite_i,
    input  wire [2:0]  funct3_i,        // LB/LH/LW/LBU/LHU and SB/SH/SW
    input  wire        ex_valid_i,

    // To WB (MEM/WB register outputs)
    output reg         regwrite_o,
    output reg  [4:0]  rd_addr_o,
    output reg  [1:0]  memtoreg_o,
    output reg  [31:0] pc_address_o,    // PC for PC+4 path
    output reg  [31:0] alu_result_o,    // ALU result path
    output reg  [31:0] mem_data_o,      // memory read data (already extended)
    output reg         mem_valid_o,     // 1 when this MEM/WB entry is valid
);

    // ---------- funct3 ----------
    localparam [2:0] F3_LB  = 3'b000;
    localparam [2:0] F3_LH  = 3'b001;
    localparam [2:0] F3_LW  = 3'b010;
    localparam [2:0] F3_LBU = 3'b100;
    localparam [2:0] F3_LHU = 3'b101;

    localparam [2:0] F3_SB  = 3'b000;
    localparam [2:0] F3_SH  = 3'b001;
    localparam [2:0] F3_SW  = 3'b010;

    // ---------- EX supregister (1-cycle) ----------
    reg         s_regwrite;
    reg  [4:0]  s_rd_addr;
    reg  [1:0]  s_memtoreg;
    reg  [31:0] s_pc_address;
    reg  [31:0] s_alu_result;
    reg  [31:0] s_store_data;
    reg         s_memread;
    reg         s_memwrite;
    reg  [2:0]  s_funct3;
    reg         s_valid;
   
    always @ (posedge clk_i or posedge rst_i) begin 
        s_regwrite      <= regwrite_i;
        s_rd_addr       <= rd_addr_i;
        s_memtoreg      <= memtoreg_i;
        s_pc_address    <= pc_address_i;
        s_alu_result    <= alu_result_i;
        s_valid         <= ex_valid_i;
    end

    wire [12:0] memory_address = alu_result_i[14:2];
    wire [1:0] off_set = alu_result_i[1:0];

    // ---------- alignment check ----------
    // wire misalign_h = memwrite_i ? (funct3_i == F3_SH && alu_result_i[0]) : 1'b0;
    // wire misalign_w = memwrite_i ? (funct3_i == F3_SW && |alu_result_i[1:0]) : 1'b0;
    // wire misaligned = misalign_h | misalign_w;
    wire start_mem = ex_valid_i & (memread_i | memwrite_i); // & ~misaligned;
    
    // ---------- write enables ----------
    wire we0 = start_mem & memwrite_i &
               ( (funct3_i == F3_SW) |
                 (funct3_i == F3_SH && off_set[1] == 1'b0) |
                 (funct3_i == F3_SB && off_set == 2'b00) );
    wire we1 = start_mem & memwrite_i &
               ( (funct3_i == F3_SW) |
                 (funct3_i == F3_SH && off_set[1] == 1'b0) |
                 (funct3_i == F3_SB && off_set == 2'b01) );
    wire we2 = start_mem & memwrite_i &
               ( (funct3_i == F3_SW) |
                 (funct3_i == F3_SH && off_set[1] == 1'b1) |
                 (funct3_i == F3_SB && off_set == 2'b10) );
    wire we3 = start_mem & memwrite_i &
               ( (funct3_i == F3_SW) |
                 (funct3_i == F3_SH && off_set[1] == 1'b1) |
                 (funct3_i == F3_SB && off_set == 2'b11) );
    
    // ---------- bank enables ----------
    wire ena0 = start_mem;
    wire ena1 = start_mem;
    wire ena2 = start_mem;
    wire ena3 = start_mem;
    
    // ---------- write data ----------
    wire [7:0] din0 = (funct3_i == F3_SW) ? store_data_i[7:0] :
                      (funct3_i == F3_SH && off_set[1] == 1'b0) ? store_data_i[7:0] :
                      (funct3_i == F3_SB && off_set == 2'b00) ? store_data_i[7:0] : 8'h00;
    wire [7:0] din1 = (funct3_i == F3_SW) ? store_data_i[15:8] :
                      (funct3_i == F3_SH && off_set[1] == 1'b0) ? store_data_i[15:8] :
                      (funct3_i == F3_SB && off_set == 2'b01) ? store_data_i[7:0] : 8'h00;
    wire [7:0] din2 = (funct3_i == F3_SW) ? store_data_i[23:16] :
                      (funct3_i == F3_SH && off_set[1] == 1'b1) ? store_data_i[7:0] :
                      (funct3_i == F3_SB && off_set == 2'b10) ? store_data_i[7:0] : 8'h00;
    wire [7:0] din3 = (funct3_i == F3_SW) ? store_data_i[31:24] :
                      (funct3_i == F3_SH && off_set[1] == 1'b1) ? store_data_i[15:8] :
                      (funct3_i == F3_SB && off_set == 2'b11) ? store_data_i[7:0] : 8'h00;
    
    // 4 banks
    wire [7:0] dout0, dout1, dout2, dout3;
    blk_mem_gen_2 u_dmem0 (.clka(clk_i), .ena(ena0), .wea({we0}), .addra(memory_address), .dina(din0), .douta(dout0));
    blk_mem_gen_2 u_dmem1 (.clka(clk_i), .ena(ena1), .wea({we1}), .addra(memory_address), .dina(din1), .douta(dout1));
    blk_mem_gen_2 u_dmem2 (.clka(clk_i), .ena(ena2), .wea({we2}), .addra(memory_address), .dina(din2), .douta(dout2));
    blk_mem_gen_2 u_dmem3 (.clka(clk_i), .ena(ena3), .wea({we3}), .addra(memory_address), .dina(din3), .douta(dout3));

    wire [31:0] lb_data  = (off_set[1:0] == 2'b00) ? {{24{dout0[7]}}, dout0} :
                           (off_set[1:0] == 2'b01) ? {{24{dout1[7]}}, dout1} :
                           (off_set[1:0] == 2'b10) ? {{24{dout2[7]}}, dout2} :
                           {{24{dout3[7]}}, dout3}; // LB: Sign-extend selected byte
    
    wire [31:0] lh_data  = (off_set[1]) ? {{16{dout3[7]}}, dout3, dout2} :
                           {{16{dout1[7]}}, dout1, dout0}; // LH: Sign-extend halfword
    
    wire [31:0] lw_data  = {dout3, dout2, dout1, dout0}; 
    
    wire [31:0] lbu_data = (off_set[1:0] == 2'b00) ? {24'b0, dout0} :
                           (off_set[1:0] == 2'b01) ? {24'b0, dout1} :
                           (off_set[1:0] == 2'b10) ? {24'b0, dout2} :
                           {24'b0, dout3}; // LBU: Zero-extend selected byte
    
    wire [31:0] lhu_data = (off_set[1]) ? {16'b0, dout3, dout2} :
                       {16'b0, dout1, dout0}; // LHU: Zero-extend halfword

    wire [31:0] load_data = (funct3 == F3_LB)  ? lb_data  :
                            (funct3 == F3_LH)  ? lh_data  :
                            (funct3 == F3_LW)  ? lw_data  :
                            (funct3 == F3_LBU) ? lbu_data :
                            (funct3 == F3_LHU) ? lhu_data :
                            32'b0;

    always (posedge clk_i or posedge rst_i) begin
        alu_result_o    <= s_alu_result;
        rd_addr_o       <= 
        memtoreg_o      <=
        pc_address_o    <= 
        alu_result_o    <=
        mem_data_o      <=
        mem_valid_o     <=
    end

endmodule

