`timescale 1ns / 1ps

module rv32i_top_tb;

    // ------------------------------------------------------------------------
    // Clock and Reset
    // ------------------------------------------------------------------------
    reg clk_i;
    reg rst_i;

    // ------------------------------------------------------------------------
    // Optional Interface Signals
    // ------------------------------------------------------------------------
`ifdef FORWARDING_UNIT
    wire [4:0] idex_rs1_addr_w;
    wire [4:0] idex_rs2_addr_w;
`endif

`ifdef FORWARDING_CONTROL
    reg  [2:0]  se0;
    reg  [2:0]  se1;
    reg  [31:0] b;
    reg  [31:0] c;
    reg  [31:0] d;
    reg  [31:0] e;
`endif

`ifdef CONTROL_FLUSH_STALL
    reg stall_if_w;
    reg flush_if_w;
    reg flush_id_w;
    reg stall_id_w;
    reg flush_ex_w;
    reg stall_ex_w;
    reg flush_mem_w;
    reg stall_mem_w;
`endif

`ifdef DEBUG_IF
    wire [31:0] ifid_pc;
    wire [31:0] ifid_instr;
`endif

`ifdef DEBUG_ID
    wire [31:0] idex_rs1_data;
    wire [31:0] idex_rs2_data;
    wire [31:0] idex_imm;
    wire [31:0] idex_pc;
    wire        valid_m_instruction;
    wire [11:0] csr_addr;
    wire [4:0]  zimm;
`endif

`ifdef DEBUG_EX
    wire [31:0] exif_pc_bj;
    wire [31:0] exmem_alu_result;
    wire [31:0] exmem_store_data;
    wire [31:0] exmem_pc;
`endif

`ifdef DEBUG_MEM
    wire [31:0] memwb_mem_data;
    wire [31:0] memwb_alu_result;
    wire [31:0] memwb_pc;
`endif

`ifdef DEBUG_WB
    wire        wbrf_regwrite;
    wire [4:0]  wbrf_rd_addr;
    wire [31:0] wbrf_wdata;
`endif

    // ------------------------------------------------------------------------
    // DUT Instantiation
    // ------------------------------------------------------------------------
    rv32i_top uut (
        .clk_i(clk_i),
        .rst_i(rst_i)
`ifdef FORWARDING_UNIT
        ,.idex_rs1_addr_w(idex_rs1_addr_w),
        .idex_rs2_addr_w(idex_rs2_addr_w)
`endif
`ifdef FORWARDING_CONTROL
        ,.se0(se0),
        .se1(se1),
        .b(b),
        .c(c),
        .d(d),
        .e(e)
`endif
`ifdef CONTROL_FLUSH_STALL
        ,.stall_if_w(stall_if_w),
        .flush_if_w(flush_if_w),
        .flush_id_w(flush_id_w),
        .stall_id_w(stall_id_w),
        .flush_ex_w(flush_ex_w),
        .stall_ex_w(stall_ex_w),
        .flush_mem_w(flush_mem_w),
        .stall_mem_w(stall_mem_w)
`endif
`ifdef DEBUG_IF
        ,.ifid_pc(ifid_pc),
        .ifid_instr(ifid_instr)
`endif
`ifdef DEBUG_ID
        ,.idex_rs1_data(idex_rs1_data),
        .idex_rs2_data(idex_rs2_data),
        .idex_imm(idex_imm),
        .idex_pc(idex_pc),
        .valid_m_instruction(valid_m_instruction),
        .csr_addr(csr_addr),
        .zimm(zimm)
`endif
`ifdef DEBUG_EX
        ,.exif_pc_bj(exif_pc_bj),
        .exmem_alu_result(exmem_alu_result),
        .exmem_store_data(exmem_store_data),
        .exmem_pc(exmem_pc)
`endif
`ifdef DEBUG_MEM
        ,.memwb_mem_data(memwb_mem_data),
        .memwb_alu_result(memwb_alu_result),
        .memwb_pc(memwb_pc)
`endif
`ifdef DEBUG_WB
        ,.wbrf_regwrite(wbrf_regwrite),
        .wbrf_rd_addr(wbrf_rd_addr),
        .wbrf_wdata(wbrf_wdata)
`endif
    );

    // ------------------------------------------------------------------------
    // Clock Generation (10ns period -> 100 MHz)
    // ------------------------------------------------------------------------
    initial clk_i = 0;
    always #5 clk_i = ~clk_i;

    // ------------------------------------------------------------------------
    // Dumpfile + Display
    // ------------------------------------------------------------------------
    initial begin
        $dumpfile("rv32i_top_tb.vcd");
        $dumpvars(0, rv32i_top_tb);
        $display(">> Simulation started: rv32i_top_tb");
    end

    // ------------------------------------------------------------------------
    // Reset + Run Sequence
    // ------------------------------------------------------------------------
    initial begin
        // Default reset and control signal initialization
        rst_i = 1;
`ifdef FORWARDING_CONTROL
        se0 = 3'b000;
        se1 = 3'b000;
        b = 32'h0;
        c = 32'h0;
        d = 32'h0;
        e = 32'h0;
`endif
`ifdef CONTROL_FLUSH_STALL
        stall_if_w  = 0;
        flush_if_w  = 0;
        flush_id_w  = 0;
        stall_id_w  = 0;
        flush_ex_w  = 0;
        stall_ex_w  = 0;
        flush_mem_w = 0;
        stall_mem_w = 0;
`endif

        // Hold reset for 30ns
        #30 rst_i = 0;

        // Let it run for 1 μs (1000ns)
        #1000;
        $display(">> Simulation finished normally.");
        $finish;
    end

endmodule
