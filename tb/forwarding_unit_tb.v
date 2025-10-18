// forwarding_unit_tb.v
`timescale 1ns/1ps

module forwarding_unit_tb;

    // DUT inputs
    reg  [4:0] reg_file_read_address_0_ID_EXE;
    reg  [4:0] reg_file_read_address_1_ID_EXE;

    reg        reg_file_write_EX_MEM;
    reg  [4:0] reg_file_write_address_EX_MEM;
    reg  [1:0] mux_0_sel_EX_MEM;

    reg        reg_file_write_MEM_WB;
    reg  [4:0] reg_file_write_address_MEM_WB;
    reg  [1:0] mux_0_sel_MEM_WB;

    // DUT outputs
    wire [2:0] forward_mux_0_control;
    wire [2:0] forward_mux_1_control;

    // Instantiate DUT
    forwarding_unit dut (
        .reg_file_read_address_0_ID_EXE(reg_file_read_address_0_ID_EXE),
        .reg_file_read_address_1_ID_EXE(reg_file_read_address_1_ID_EXE),
        .reg_file_write_EX_MEM(reg_file_write_EX_MEM),
        .reg_file_write_address_EX_MEM(reg_file_write_address_EX_MEM),
        .mux_0_sel_EX_MEM(mux_0_sel_EX_MEM),
        .reg_file_write_MEM_WB(reg_file_write_MEM_WB),
        .reg_file_write_address_MEM_WB(reg_file_write_address_MEM_WB),
        .mux_0_sel_MEM_WB(mux_0_sel_MEM_WB),
        .forward_mux_0_control(forward_mux_0_control),
        .forward_mux_1_control(forward_mux_1_control)
    );

    // Task for applying a stimulus
    task check_forward(
        input [4:0] rs0, input [4:0] rs1,
        input we_ex, input [4:0] wa_ex, input [1:0] sel_ex,
        input we_wb, input [4:0] wa_wb, input [1:0] sel_wb,
        input [2:0] exp0, input [2:0] exp1,
        input [255*8-1:0] msg
    );
    begin
        reg_file_read_address_0_ID_EXE = rs0;
        reg_file_read_address_1_ID_EXE = rs1;
        reg_file_write_EX_MEM           = we_ex;
        reg_file_write_address_EX_MEM   = wa_ex;
        mux_0_sel_EX_MEM                = sel_ex;
        reg_file_write_MEM_WB           = we_wb;
        reg_file_write_address_MEM_WB   = wa_wb;
        mux_0_sel_MEM_WB                = sel_wb;

        #1; // wait for combinational logic

        if (forward_mux_0_control !== exp0 || forward_mux_1_control !== exp1) begin
            $display("FAIL: %s", msg);
            $display("   Got f0=%b f1=%b, Expected f0=%b f1=%b",
                forward_mux_0_control, forward_mux_1_control, exp0, exp1);
        end else begin
            $display("PASS: %s", msg);
        end
    end
    endtask

    initial begin
        $display("\n--- Forwarding Unit Testbench ---");

        // 1. No forwarding
        check_forward(5'd1, 5'd2, 0, 5'd3, 2'b00, 0, 5'd4, 2'b00, 3'b000, 3'b000,
                      "No forwarding case");

        // 2. Forward operand0 from EX/MEM (mux_sel=00 → 001)
        check_forward(5'd5, 5'd2, 1, 5'd5, 2'b00, 0, 5'd0, 2'b00, 3'b001, 3'b000,
                      "EX/MEM forwarding operand0 (ALU result)");

        // 3. Forward operand1 from EX/MEM (mux_sel=01 → 010)
        check_forward(5'd3, 5'd7, 1, 5'd7, 2'b01, 0, 5'd0, 2'b00, 3'b000, 3'b010,
                      "EX/MEM forwarding operand1 (different path)");

        // 4. Forward operand0 from MEM/WB (mux_sel=00 → 011)
        check_forward(5'd6, 5'd9, 0, 5'd0, 2'b00, 1, 5'd6, 2'b00, 3'b011, 3'b000,
                      "MEM/WB forwarding operand0");

        // 5. Forward operand1 from MEM/WB (mux_sel=01 → 100)
        check_forward(5'd10, 5'd8, 0, 5'd0, 2'b00, 1, 5'd8, 2'b01, 3'b000, 3'b100,
                      "MEM/WB forwarding operand1 (different path)");

        // 6. Priority check (EX vs WB both match → must choose EX)
        check_forward(5'd11, 5'd12, 1, 5'd11, 2'b00, 1, 5'd11, 2'b00, 3'b001, 3'b000,
                      "Priority EX over WB for operand0");

        // 7. Register x0 (should never forward)
        check_forward(5'd0, 5'd0, 1, 5'd0, 2'b00, 1, 5'd0, 2'b00, 3'b000, 3'b000,
                      "No forwarding for x0");

        $display("--- Testbench Completed ---\n");
        $finish;
    end

endmodule
