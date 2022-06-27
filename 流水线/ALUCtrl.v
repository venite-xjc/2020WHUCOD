`include "ctrl_encode_def.v"
`include "instruction_def.v"
module ALUCtrl(ALUOp1, ALUOp2, ALUOp3, funct, ALUSignal);
    input ALUOp1;
    input ALUOp2;
    input ALUOp3;
    input [5:0] funct;
    output reg [4:0] ALUSignal;

    always @(*) begin
        if({ALUOp1, ALUOp2, ALUOp3} == 3'b000)
            ALUSignal = `ALUOp_ADD;
        if({ALUOp1, ALUOp2, ALUOp3} == 3'b010)
            ALUSignal = `ALUOp_SUB;
        if({ALUOp1, ALUOp2, ALUOp3} == 3'b001)    
            ALUSignal = `ALUOp_SLT;
        if({ALUOp1, ALUOp2, ALUOp3} == 3'b011)
            ALUSignal = `ALUOp_ADD;
        if({ALUOp1, ALUOp2, ALUOp3} == 3'b101)
            ALUSignal = `ALUOp_LUI;
        if({ALUOp1, ALUOp2, ALUOp3} == 3'b110)
            ALUSignal = `ALUOp_OR;
        if({ALUOp1, ALUOp2, ALUOp3} == 3'b100)
        case(funct) 
            `INSTR_ADD_FUNCT:
            ALUSignal = `ALUOp_ADDU;
            `INSTR_ADDU_FUNCT:
            ALUSignal = `ALUOp_ADDU;
            `INSTR_SUB_FUNCT:
            ALUSignal = `ALUOp_SUB;
            `INSTR_SUBU_FUNCT:
            ALUSignal = `ALUOp_SUBU;
            `INSTR_AND_FUNCT:
            ALUSignal = `ALUOp_AND;
            `INSTR_NOR_FUNCT:
            ALUSignal = `ALUOp_NOP;
            `INSTR_OR_FUNCT:
            ALUSignal = `ALUOp_OR;
            `INSTR_XOR_FUNCT:
            ALUSignal = `ALUOp_XOR;
            `INSTR_SLT_FUNCT:
            ALUSignal = `ALUOp_SLT;
            `INSTR_SLTU_FUNCT:
            ALUSignal = `ALUOp_SLTU;
            `INSTR_SLL_FUNCT:
            ALUSignal = `ALUOp_SLL;
            `INSTR_SRL_FUNCT:
            ALUSignal = `ALUOp_SRL;
            `INSTR_SRA_FUNCT:
            ALUSignal = `ALUOp_SRA;
        endcase
	end
endmodule