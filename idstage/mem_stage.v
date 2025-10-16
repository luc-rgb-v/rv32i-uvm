`timescale 1ns/1ps
module mem_stage (
    input  wire        clk_i,
    input  wire        rst_i,
    input  wire        flush_i,
    input  wire        stall_i,

    // From EX
    input  wire        regwrite_i,
    input  wire [4:0]  rd_addr_i,
    input  wire [1:0]  memtoreg_i,
    input  wire [31:0] pc_address_i,
    input  wire [31:0] alu_result_i,
    input  wire [31:0] store_data_i,
    input  wire        memread_i,
    input  wire        memwrite_i,
    input  wire [1:0]  mem_size_i,      // 00=byte,01=half,10=word
    input  wire        mem_unsigned_i,
    input  wire        ex_valid_i,

    // To WB
    output reg         regwrite_o,
    output reg  [4:0]  rd_addr_o,
    output reg  [1:0]  memtoreg_o,
    output reg  [31:0] pc_address_o,
    output reg  [31:0] alu_result_o,
    output reg  [31:0] mem_data_o,
    output reg         mem_valid_o
);

    // ==========================================================
    // BRAM interface
    // ==========================================================
    wire mem_en = (memread_i | memwrite_i) & ~stall_i;
    wire [12:0] addr = alu_result_i[14:2];
    wire [1:0]  byte_off = alu_result_i[1:0];

    // Write-enable mask
    wire [3:0] wea = memwrite_i ?
                     (mem_size_i == 2'b00 ? (4'b0001 << byte_off) :
                      mem_size_i == 2'b01 ? (byte_off[1] ? 4'b1100 : 4'b0011) :
                      mem_size_i == 2'b10 ? 4'b1111 : 4'b0000)
                     : 4'b0000;

    wire [31:0] mem_dout;

    blk_mem_gen_1 data_mem (
        .clka(clk_i),
        .ena(mem_en),
        .wea(wea),
        .addra(addr),
        .dina(store_data_i),
        .douta(mem_dout)
    );

    // ==========================================================
    // BRAM read latency: capture output + offset
    // ==========================================================
    reg [31:0] mem_dout_q;
    reg [1:0]  byte_off_q;

    always @(posedge clk_i) begin
        mem_dout_q <= mem_dout;
        byte_off_q <= byte_off;
    end

    // ==========================================================
    // Stage 1: align control (EX → MEM)
    // ==========================================================
    reg regwrite_d1, memread_d1, memwrite_d1;
    reg [4:0] rd_addr_d1;
    reg [1:0] memtoreg_d1, mem_size_d1;
    reg [31:0] pc_address_d1, alu_result_d1;
    reg mem_unsigned_d1, ex_valid_d1;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            regwrite_d1 <= 0;
            memread_d1 <= 0;
            memwrite_d1 <= 0;
            rd_addr_d1 <= 0;
            memtoreg_d1 <= 0;
            pc_address_d1 <= 0;
            alu_result_d1 <= 0;
            mem_size_d1 <= 0;
            mem_unsigned_d1 <= 0;
            ex_valid_d1 <= 0;
        end else if (~stall_i & ~flush_i) begin
            regwrite_d1 <= regwrite_i;
            memread_d1  <= memread_i;
            memwrite_d1 <= memwrite_i;
            rd_addr_d1  <= rd_addr_i;
            memtoreg_d1 <= memtoreg_i;
            pc_address_d1 <= pc_address_i;
            alu_result_d1 <= alu_result_i;
            mem_size_d1 <= mem_size_i;
            mem_unsigned_d1 <= mem_unsigned_i;
            ex_valid_d1 <= ex_valid_i;
        end else if (flush_i) begin
            memread_d1 <= 0;
            memwrite_d1 <= 0;
            regwrite_d1 <= 0;
            ex_valid_d1 <= 0;
        end
    end

    // ==========================================================
    // Stage 2: align with BRAM data (1 more delay)
    // ==========================================================
    reg regwrite_d2, memread_d2, memwrite_d2;
    reg [4:0] rd_addr_d2;
    reg [1:0] memtoreg_d2, mem_size_d2;
    reg [31:0] pc_address_d2, alu_result_d2;
    reg mem_unsigned_d2, ex_valid_d2;
    reg [1:0] byte_off_d2;

    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i) begin
            regwrite_d2 <= 0;
            memread_d2  <= 0;
            memwrite_d2 <= 0;
            rd_addr_d2  <= 0;
            memtoreg_d2 <= 0;
            pc_address_d2 <= 0;
            alu_result_d2 <= 0;
            mem_size_d2 <= 0;
            mem_unsigned_d2 <= 0;
            ex_valid_d2 <= 0;
            byte_off_d2 <= 0;
        end else if (~stall_i) begin
            regwrite_d2 <= regwrite_d1;
            memread_d2  <= memread_d1;
            memwrite_d2 <= memwrite_d1;
            rd_addr_d2  <= rd_addr_d1;
            memtoreg_d2 <= memtoreg_d1;
            pc_address_d2 <= pc_address_d1;
            alu_result_d2 <= alu_result_d1;
            mem_size_d2 <= mem_size_d1;
            mem_unsigned_d2 <= mem_unsigned_d1;
            ex_valid_d2 <= ex_valid_d1;
            byte_off_d2 <= byte_off_q; // one more delay to match data
        end
    end

    // ==========================================================
    // Data extraction
    // ==========================================================
    wire [7:0] byte_sel =
        (byte_off_d2 == 2'd0) ? mem_dout_q[7:0]   :
        (byte_off_d2 == 2'd1) ? mem_dout_q[15:8]  :
        (byte_off_d2 == 2'd2) ? mem_dout_q[23:16] :
                                mem_dout_q[31:24];

    wire [15:0] half_sel =
        (byte_off_d2[1]) ? mem_dout_q[31:16] : mem_dout_q[15:0];

    wire [31:0] load_byte = mem_unsigned_d2 ?
                            {24'd0, byte_sel} :
                            {{24{byte_sel[7]}}, byte_sel};

    wire [31:0] load_half = mem_unsigned_d2 ?
                            {16'd0, half_sel} :
                            {{16{half_sel[15]}}, half_sel};

    wire [31:0] load_word = mem_dout_q;

    wire [31:0] load_data =
        memread_d2 ? ((mem_size_d2 == 2'b00) ? load_byte :
                      (mem_size_d2 == 2'b01) ? load_half :
                      (mem_size_d2 == 2'b10) ? load_word : 32'd0)
                    : 32'd0;

    // ==========================================================
    // Outputs to WB
    // ==========================================================
    always @(posedge clk_i or posedge rst_i) begin
        if (rst_i || flush_i) begin
            regwrite_o <= 0;
            rd_addr_o  <= 0;
            memtoreg_o <= 0;
            pc_address_o <= 0;
            alu_result_o <= 0;
            mem_data_o <= 0;
            mem_valid_o <= 0;
        end else if (~stall_i) begin
            regwrite_o   <= regwrite_d2;
            rd_addr_o    <= rd_addr_d2;
            memtoreg_o   <= memtoreg_d2;
            pc_address_o <= pc_address_d2;
            alu_result_o <= alu_result_d2;
            mem_data_o   <= load_data;
            mem_valid_o  <= ex_valid_d2 & (memread_d2 | memwrite_d2);
        end
    end

endmodule
