module IDEX(clk, flush, RegDst, slide, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Aluop1, Aluop2, Aluop3, RegOut1, RegOut2, Rs, Rt, Rd, Extend, Funct, 
RegDst_, slide_, ALUSrc_, MemtoReg_, RegWrite_, MemRead_, MemWrite_, Aluop1_, Aluop2_, Aluop3_, RegOut1_, RegOut2_, Rs_, Rt_, Rd_, Extend_, Funct_);

input clk, flush, RegDst, slide, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Aluop1, Aluop2, Aluop3;
input [31:0] RegOut1, RegOut2, Extend;
input [4:0] Rs, Rt, Rd;
input [5:0] Funct;
output reg RegDst_, slide_, ALUSrc_, MemtoReg_, RegWrite_, MemRead_, MemWrite_, Aluop1_, Aluop2_, Aluop3_;
output reg [31:0] RegOut1_, RegOut2_, Extend_;
output reg [4:0]  Rs_, Rt_, Rd_;
output reg [5:0] Funct_;

always@(posedge clk) begin
    if(flush) begin
        RegDst_ = 0;
        slide_ = 0;
        ALUSrc_ = 0;
        MemtoReg_ = 0;
        RegWrite_ = 0;
        MemRead_ = 0;
        MemWrite_ = 0;
        Aluop1_ = 0;
        Aluop2_ = 0;
        Aluop3_ = 0;
        RegOut1_ = 0;
        RegOut2_ = 0;
        Extend_ = 0;
        Rs_ = 0;
        Rt_ = 0;
        Rd_ = 0;
        Funct_ = 0;
    end
    else begin
        RegDst_ = RegDst;
        slide_ = slide;
        ALUSrc_ = ALUSrc;
        MemtoReg_ = MemtoReg;
        RegWrite_ = RegWrite;
        MemRead_ = MemRead;
        MemWrite_ = MemWrite;
        Aluop1_ = Aluop1;
        Aluop2_ = Aluop2;
        Aluop3_ = Aluop3;
        RegOut1_ = RegOut1;
        RegOut2_ = RegOut2;
        Extend_ = Extend;
        Rs_ = Rs;
        Rt_ = Rt;
        Rd_ = Rd;
        Funct_ = Funct;
    end
end
endmodule