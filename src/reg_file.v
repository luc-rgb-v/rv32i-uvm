`timescale 1ns / 1ps

module reg_file (
    input wire clk,                  // Clock signal
    input wire [4:0] rs1_i,            // Source register 1 address
    input wire [4:0] rs2_i,            // Source register 2 address
    input wire [4:0] rd_i,             // Destination register address
    input wire [31:0] wd_i,            // Write data (to register rd)
    input wire reg_write_i,            // Control signal for register write
    output wire [31:0] rs1_data_o,     // Data from register rs1
    output wire [31:0] rs2_data_o      // Data from register rs2
);

    // 32 registers, each 32 bits wide
    reg [31:0] registers [0:31];

    // Read logic for registers
    assign rs1_data_o = registers[rs1_i];
    assign rs2_data_o = registers[rs2_i];

    // Write logic
    always @(posedge clk) begin
        if (reg_write_i && rd_i != 5'b00000)  // Prevent writing to x0 (register 0)
            registers[rd_i] <= wd_i;
    end
    
    integer i;
    
    initial begin
        for (i = 0; i < 32; i = i + 1) begin
            registers[i] = 32'b0;
        end
    end
    
    `ifndef SYNTHESIS
    task dump_regs;
        integer i;
        begin
            $display("=== Register File Dump ===");
            for (i = 0; i < 32; i = i + 1)
                $display("x%0d = 0x%08h", i, registers[i]);
        end
    endtask
    `endif
    

endmodule
