`timescale 1ns/1ps

module mimic_pipeline (
    input wire clk,
    input wire rst,
    
    input wire flush_sub_if,
    input wire flush_if,
    input wire flush_id,
    input wire flush_ex,
    input wire flush_sub_mem,
    input wire flush_mem,

    input wire stall_pc,
    input wire stall_sub_if,
    input wire stall_if,
    input wire stall_id,
    input wire stall_ex,
    input wire stall_sub_mem,

    output wire [7:0] pc_o,
    output wire [7:0] instruction_data_o,
    output wire [15:0] if_stage_o,
    output wire [15:0] id_stage_o,
    output wire [15:0] ex_stage_o,
    output wire [7:0] data_mem_o,
    output wire [23:0] mem_stage_o,
    output wire [23:0] reg_file_o
);

    reg [7:0] pc_r;
    reg [15:0] if_stage_r;
    reg [15:0] id_stage_r;
    reg [15:0] ex_stage_r;
    reg [7:0] data_mem_r;
    reg [24:0] mem_stage_r;
    reg [24:0] reg_file_r;

    reg [7:0] sub_if_r;
    reg [15:0] sub_mem_r;
    
    wire [7:0] instruction_data;
    wire jump = ex_stage_o[10] & ~ex_stage_o[9] & ex_stage_o[8];
    //wire jump = (ex_stage_o[15:13] == 3'b101)
    
    blk_mem_gen_0 uut (
    .clka(clk),
    .ena(1),
    .wea(0),
    .addra(pc_r[3:0]),
    .dina(8'h0),
    .douta(instruction_data)
    );

    always @(posedge clk or posedge rst) begin
        if (rst)
            pc_r <= 8'h00;
        else if (stall_pc)
            pc_r <= pc_r;
        else begin
            if (pc_r == 10) pc_r <= 0;
            else begin if (jump) pc_r = 8'h07; else pc_r <= pc_r + 1; end
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            sub_if_r <= 8'h0;
        else if (stall_sub_if)
            sub_if_r <= sub_if_r;
        else if (flush_sub_if)
            sub_if_r <= 8'h0;
        else
            sub_if_r <= pc_r;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            if_stage_r <= 16'h00;
        else if (stall_if)
            if_stage_r <= if_stage_r;
        else if (flush_if)
            if_stage_r <= 16'h00;
        else
            if_stage_r <= {sub_if_r, instruction_data};
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            id_stage_r <= 16'h00;
        else if (stall_id)
            id_stage_r <= id_stage_r;
        else if (flush_id)
            id_stage_r <= 16'h00;
        else begin
            id_stage_r <= if_stage_r;
        end
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            ex_stage_r <= 16'h00;
        else if (stall_ex)
            ex_stage_r <= ex_stage_r;
        else if (flush_ex)
            ex_stage_r <= 16'h00;
        else
            ex_stage_r <= id_stage_r;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            sub_mem_r <= 16'h0;
        else if (stall_sub_mem)
            sub_mem_r <= sub_mem_r;
        else if (flush_sub_mem)
            sub_mem_r <= 16'h0;
        else
            sub_mem_r <= ex_stage_r;
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            data_mem_r <= 8'h0;
        else
            data_mem_r <= ex_stage_r[8:0];
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            mem_stage_r <= 24'h00;
        else if (flush_mem)
            mem_stage_r <= 24'h00;
        else
            mem_stage_r <= {sub_mem_r, data_mem_r};
    end

    always @(posedge clk or posedge rst) begin
        if (rst)
            reg_file_r <= 24'h00;
        else
            reg_file_r <= mem_stage_r;
    end

    assign pc_o = pc_r;
    assign instruction_data_o = instruction_data;
    assign if_stage_o = if_stage_r;
    assign id_stage_o = id_stage_r;
    assign ex_stage_o = ex_stage_r;
    assign data_mem_o = data_mem_r;
    assign mem_stage_o = mem_stage_r;
    assign reg_file_o = reg_file_r;

endmodule
