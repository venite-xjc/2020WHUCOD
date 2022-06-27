`include "instruction_def.v"
`include "ctrl_encode_def.v"
module CTRL(Op, Funct, RegDst, Jump, Jr, Jal, bne, slide, ExtOp, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3);
  input [5:0] Op, Funct;
  output reg [1:0] ExtOp;
  output RegDst, Jump, Jr, Jal, bne, slide, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3;
  reg RegDst, Jump, Jr, Jal, bne, slide, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3;
  
  always @(*) begin
    case(Op)
      `INSTR_RTYPE_OP: 
        begin
            if(Funct == `INSTR_JR_FUNCT)
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0000000000;
            else if(Funct == `INSTR_SLL_FUNCT||Funct == `INSTR_SRL_FUNCT ||Funct == `INSTR_SRA_FUNCT)
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b1101000100;
            else
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b1001000100;
        end  
      `INSTR_LW_OP: 
        begin
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0111100000;
        end
      `INSTR_SW_OP: 
        begin
            {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b1111010000;
        end
      `INSTR_BEQ_OP: 
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0000001010;
      end
      `INSTR_ORI_OP:
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0101000110;
      end
      `INSTR_BNE_OP:
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0000001010;
      end
      `INSTR_J_OP:
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0000000000;
      end
      `INSTR_JAL_OP:
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0001000000;
      end
      `INSTR_SLTI_OP:
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0101000001;
      end
      `INSTR_ADDI_OP:
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0101000011;
      end
      `INSTR_LUI_OP:
      begin
          {RegDst, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3} = 10'b0101000101;
      end
    endcase
    if(Op == `INSTR_BNE_OP)
        bne = 1'b1;
    else
        bne = 1'b0;
    if(Op == `INSTR_J_OP)
        Jump = 1'b1;
        else
        Jump = 1'b0;
    if(Op == `INSTR_JAL_OP)
        Jal = 1'b1;
        else
        Jal = 1'b0;
    if(Op == `INSTR_RTYPE_OP&&Funct == `INSTR_JR_FUNCT)
        Jr = 1'b1;
        else
        Jr = 1'b0;
    if(Op == `INSTR_RTYPE_OP&&(Funct == `INSTR_SLL_FUNCT||Funct == `INSTR_SRL_FUNCT ||Funct == `INSTR_SRA_FUNCT))
        slide = 1'b1;
        else
        slide = 1'b0;
    if(Op == `INSTR_ORI_OP)
        ExtOp = `EXT_ZERO;
        else
        ExtOp = `EXT_SIGNED;
  end
  
endmodule

