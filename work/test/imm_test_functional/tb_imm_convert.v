`timescale 1ns / 1ps

module tb_imm_decoder;
    reg [31:0] instruction;
    wire [31:0] imm_i;
    wire [31:0] imm_s;
    wire [31:0] imm_b;
    wire [31:0] imm_j;
    wire [31:0] imm_u;
    wire [31:0] shamt_imm;
    
    imm_decoder uut (
        .instruction_r(instruction),
        .imm_i(imm_i),
        .imm_s(imm_s),
        .imm_b(imm_b),
        .imm_j(imm_j),
        .imm_u(imm_u),
        .shamt_imm(shamt_imm)
    );
    task instr; input [31:0] a; begin
            instruction = a;
            #10;
        end
    endtask 
    
    
    initial begin
        $dumpfile("imm_test_functional.vcd");
        $dumpvars(0, tb_imm_decoder);
    end
    
    initial begin
        $monitor("%0t: instruction = %0h, imm_i = %0h, imm_s = %0h, imm_b = %0h, imm_j = %0h, imm_u = %0h, shamt_imm = %0h", $time, instruction, imm_i, imm_s, imm_b, imm_j, imm_u, shamt_imm);
        instr(32'h00A00093);
        instr(32'hFFB08113);
        instr(32'h07F00193);
        instr(32'h06400213);
        instr(32'h00822283);
        instr(32'h00C00313);
        instr(32'h000303E7);
        instr(32'h00100413);
        instr(32'h00341493);
        instr(32'h00145513);
        instr(32'h0C800593);
        instr(32'h0015A023);
        instr(32'h00500613);
        instr(32'h00500693);
        instr(32'h00D60463);
        instr(32'h00000713);
        instr(32'h02A00793);
        instr(32'h0080086F);
        instr(32'h00000893);
        instr(32'h07B00913);
        instr(32'h123459B7);
        instr(32'h12345A17);
        
        instr(32'h0015A0A3);
        instr(32'h0015A123);
        instr(32'h0015A223);

        $finish;
    end
endmodule
