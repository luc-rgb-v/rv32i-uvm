
    always @ (posedge clk_i) begin
      if (valid_pc || rst_i)
        stall_instr <= 32'b0;
      else if (mem_memread_w)
        stall_instr <= instruction_i;
    end

    always @ (posedge clk_i) begin
      if (mem_memread_w || if_bj_taken_w || rst_i)
        valid_pc <= 0;
      else
        valid_pc <= 1;
    end


    always @ (posedge clk_i or posedge rst_i) begin
        if (rst_i || if_bj_taken_w) begin
            pc_sub_r <= 32'b0;
        end else if (~mem_memread_w) begin
            pc_sub_r <= if_pc_w;
        end
    end

    always @ (posedge clk_i or posedge rst_i) begin
        if (rst_i || if_bj_taken_w) begin
            reset_if_stage();
        end else if (~mem_memread_w) begin
            ifid_instruction_r <= valid_pc ? instruction_i : stall_instr;
            ifid_pc_r <= pc_sub_w;
        end
    end