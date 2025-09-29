`timescale 1ns/1ps
module data_mem_rv32i (
    input  wire        clk,
    input  wire        we,             // write enable
    input  wire        re,             // read enable
    input  wire [2:0]  width_sel,      // 000=LB,001=LH,010=LW,011=LBU,100=LHU
    input  wire [8:0]  addr,           // BYTE address (not word index)
    input  wire [31:0] wdata,          // write data
    output reg  [31:0] rdata           // async read data
);
    localparam DEPTH_WORDS = 128;     // 128 words => 512 bytes (addr[8:0] covers 0..511)
    localparam MISALIGNED_ZERO = 1;
    // Little-endian word RAM
    reg [31:0] mem [0:DEPTH_WORDS-1];

    // decode
    wire [6:0] word_idx = addr[8:2];    // 0..127
    wire [1:0] byte_ofs = addr[1:0];

    // ---------------------------
    // synchronous write (byte lanes)
    // ---------------------------
    always @(posedge clk) begin
        if (we) begin
            case (width_sel)
                3'b000, 3'b011: begin // SB
                    case (byte_ofs)
                        2'd0: mem[word_idx][7:0]   <= wdata[7:0];
                        2'd1: mem[word_idx][15:8]  <= wdata[7:0];
                        2'd2: mem[word_idx][23:16] <= wdata[7:0];
                        2'd3: mem[word_idx][31:24] <= wdata[7:0];
                    endcase
                end
                3'b001, 3'b100: begin // SH (requires addr[0]==0)
                    if (byte_ofs[0] == 1'b0) begin
                        if (byte_ofs[1] == 1'b0) begin
                            // ofs 0: low halfword
                            mem[word_idx][15:0] <= wdata[15:0];
                        end else begin
                            // ofs 2: high halfword
                            mem[word_idx][31:16] <= wdata[15:0];
                        end
                    end
                    // else misaligned: ignore or handle separately
                end
                3'b010: begin // SW (requires addr[1:0]==0)
                    if (byte_ofs == 2'b00) begin
                        mem[word_idx] <= wdata;
                    end
                    // else misaligned: ignore or handle separately
                end
                default: begin
                    // default: no-op or full word write
                end
            endcase
        end
    end

    // ---------------------------
    // asynchronous read
    // ---------------------------
    wire [31:0] rword = mem[word_idx];

    always @* begin
        if (!re) begin
            rdata = 32'b0;
        end else begin
            case (width_sel)
                3'b000: begin // LB
                    case (byte_ofs)
                        2'd0: rdata = {{24{rword[7]}},   rword[7:0]};
                        2'd1: rdata = {{24{rword[15]}},  rword[15:8]};
                        2'd2: rdata = {{24{rword[23]}},  rword[23:16]};
                        2'd3: rdata = {{24{rword[31]}},  rword[31:24]};
                    endcase
                end
                3'b011: begin // LBU
                    case (byte_ofs)
                        2'd0: rdata = {24'b0, rword[7:0]};
                        2'd1: rdata = {24'b0, rword[15:8]};
                        2'd2: rdata = {24'b0, rword[23:16]};
                        2'd3: rdata = {24'b0, rword[31:24]};
                    endcase
                end
                3'b001: begin // LH
                    if (byte_ofs[0]) begin
                        rdata = MISALIGNED_ZERO ? 32'b0 : 32'hxxxx_xxxx;
                    end else if (byte_ofs[1] == 1'b0) begin
                        rdata = {{16{rword[15]}}, rword[15:0]};     // ofs 0
                    end else begin
                        rdata = {{16{rword[31]}}, rword[31:16]};    // ofs 2
                    end
                end
                3'b100: begin // LHU
                    if (byte_ofs[0]) begin
                        rdata = MISALIGNED_ZERO ? 32'b0 : 32'hxxxx_xxxx;
                    end else if (byte_ofs[1] == 1'b0) begin
                        rdata = {16'b0, rword[15:0]};               // ofs 0
                    end else begin
                        rdata = {16'b0, rword[31:16]};              // ofs 2
                    end
                end
                3'b010: begin // LW
                    if (byte_ofs != 2'b00) begin
                        rdata = MISALIGNED_ZERO ? 32'b0 : 32'hxxxx_xxxx;
                    end else begin
                        rdata = rword;
                    end
                end
                default: rdata = 32'b0;
            endcase
        end
    end
endmodule
