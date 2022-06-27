module mips( clk, rst );
   input   clk;
   input   rst;

wire [29:0] PC;

wire [31:0] OpCode;

wire [31:0] IFID_OpCode;
wire [31:2] IFID_PC;

wire RegDst, Jump, Jr, Jal, bne, slide, ALUSrc, MemtoReg, RegWrite, MemRead, MemWrite, Branch, ALUOp1, ALUOp2, ALUOp3;
wire [1:0] ExtOp;

wire [31:2] NPC;

wire [4:0] Mux1Out;

wire [31:0] Mux2Out;

wire Mux3Out;

wire [31:0] RD1, RD2;

wire [31:0] Imm32;

wire PCWr, flush, IFIDWrite;

wire IDEX_RegDst, IDEX_slide, IDEX_ALUSrc, IDEX_MemtoReg, IDEX_RegWrite, 
      IDEX_MemWrite, IDEX_AluOp1, IDEX_AluOp2, IDEX_AluOp3;
wire IDEX_MemRead;
wire [31:0] IDEX_RD1, IDEX_RD2, IDEX_Imm;
wire [4:0] IDEX_Rs, IDEX_Rd;
wire [4:0] IDEX_Rt;
wire [5:0] IDEX_Funct;

wire [31:0] Mux4Out;

wire [31:0] Mux5Out;

wire [4:0] Mux6Out;

wire [31:0] Mux7Out;

wire [31:0] Mux8Out;

wire [4:0] ALUSignal;

wire [31:0] ALUOut;

wire EXMEM_MemtoReg, EXMEM_RegWrite, EXMEM_MemWrite;
wire [31:0] EXMEM_RD2;
wire [31:0] EXMEM_AluOut;
wire [4:0] EXMEM_Addr;

wire [31:0] DMOut;

wire MEMWB_MemtoReg;
wire MEMWB_RegWrite;
wire [31:0] MEMWB_MemOut, MEMWB_AluOut;
wire [4:0] MEMWB_Addr;

wire [31:0] Mux9Out;

wire [1:0] Forward1, Forward2;





PC U_PC(.clk(clk), .rst(rst), .PCWr(PCWr), .NPC(NPC), .PC(PC));


im_4k U_IM(.addr(PC[9:0]), .dout(OpCode));


IFID U_IFID(.clk(clk), .IFIDWrite(IFIDWrite), .PC(PC), .OpCode(OpCode), .PC_(IFID_PC), .OpCode_(IFID_OpCode));


CTRL U_Ctrl(.Op(IFID_OpCode[31:26]), .Funct(IFID_OpCode[5:0]), .RegDst(RegDst), .Jump(Jump), .Jr(Jr), 
.Jal(Jal), .bne(bne), .slide(slide), .ExtOp(ExtOp), .ALUSrc(ALUSrc), .MemtoReg(MemtoReg), .RegWrite(RegWrite), 
.MemRead(MemRead), .MemWrite(MemWrite), .Branch(Branch), .ALUOp1(ALUOp1), .ALUOp2(ALUOp2), .ALUOp3(ALUOp3));


Npc U_NPC(.PC(IFID_PC), .Jump(Jump), .Jr(Jr), .Jal(Jal), .Branch(Branch), .Zero(RD1 == RD2), .JumpAddr(IFID_OpCode[25:0]), 
.BranchAddr(Imm32), .JrAddr(RD1), .NPC(NPC), .bne(bne));


mux2 #(5) U_Mux1(.d0(MEMWB_Addr), .d1(5'b11111), .s(Jal), .y(Mux1Out));


mux2 #(32) U_Mux2(.d0(Mux9Out), .d1({PC, 2'b00}+4), .s(Jal), .y(Mux2Out));


mux2 #(1) U_Mux3(.d0(MEMWB_RegWrite), .d1(RegWrite), .s(Jal), .y(Mux3Out));


RF U_RF(.A1(IFID_OpCode[25:21]), .A2(IFID_OpCode[20:16]), .A3(Mux1Out), .WD(Mux2Out), .clk(clk), 
.RFWr(Mux3Out), .RD1(RD1), .RD2(RD2));

wire [31:0] RD1_, RD2_;

Reg U_REG(.A1(IFID_OpCode[25:21]), .A2(IFID_OpCode[20:16]), .A3(Mux1Out), .a(Mux2Out), .RegWrite(Mux3Out), .RD1(RD1), .RD2(RD2), .RD1_(RD1_), .RD2_(RD2_));

EXT U_EXT(.Imm16(IFID_OpCode[15:0]), .EXTOp(ExtOp), .Imm32(Imm32));


Hazard U_Hazard(.IDEX_MemRead(IDEX_MemRead), .IDEX_Rt(IDEX_Rt), .IFID_Rs(IFID_OpCode[25:21]), .IFID_Rt(IFID_OpCode[20:16]), 
.PCWr(PCWr), .flush(flush), .IFIDWrite(IFIDWrite));


IDEX U_IDEX(.clk(clk), .flush(flush), .RegDst(RegDst), .slide(slide), .ALUSrc(ALUSrc), 
.MemtoReg(MemtoReg), .RegWrite(RegWrite), .MemRead(MemRead), .MemWrite(MemWrite), 
.Aluop1(ALUOp1), .Aluop2(ALUOp2), .Aluop3(ALUOp3), .RegOut1(RD1_), .RegOut2(RD2_), 
.Rs(IFID_OpCode[25:21]), .Rt(IFID_OpCode[20:16]), .Rd(IFID_OpCode[15:11]), 
.Extend(Imm32), .Funct(IFID_OpCode[5:0]), 
.RegDst_(IDEX_RegDst), .slide_(IDEX_slide), .ALUSrc_(IDEX_ALUSrc), .MemtoReg_(IDEX_MemtoReg), 
.RegWrite_(IDEX_RegWrite), .MemRead_(IDEX_MemRead), .MemWrite_(IDEX_MemWrite), .Aluop1_(IDEX_AluOp1), 
.Aluop2_(IDEX_AluOp2), .Aluop3_(IDEX_AluOp3), .RegOut1_(IDEX_RD1), .RegOut2_(IDEX_RD2), 
.Rs_(IDEX_Rs), .Rt_(IDEX_Rt), .Rd_(IDEX_Rd), .Extend_(IDEX_Imm), .Funct_(IDEX_Funct));


mux3 #(32) U_Mux4(.d0(IDEX_RD1), .d1(Mux9Out), .d2(EXMEM_AluOut), .s(Forward1), .y(Mux4Out));


mux3 #(32) U_Mux5(.d0(IDEX_RD2), .d1(Mux9Out), .d2(EXMEM_AluOut), .s(Forward2), .y(Mux5Out));


mux2 #(5) U_Mux6(.d0(IDEX_Rt), .d1(IDEX_Rd), .s(IDEX_RegDst), .y(Mux6Out));


mux2 #(32) U_Mux7(.d0(Mux4Out), .d1(Mux5Out), .s(IDEX_slide), .y(Mux7Out));


mux2 #(32) U_Mux8(.d0(Mux5Out), .d1(IDEX_Imm), .s(IDEX_ALUSrc), .y(Mux8Out));


ALUCtrl U_ALUCtrl(.ALUOp1(IDEX_AluOp1), .ALUOp2(IDEX_AluOp2), .ALUOp3(IDEX_AluOp3), .funct(IDEX_Funct), .ALUSignal(ALUSignal));


alu U_ALU(.A(Mux7Out), .B(Mux8Out), .ALUOp(ALUSignal), .C(ALUOut), .Zero());


EXMEM U_EXMEM(.clk(clk), .MemtoReg(IDEX_MemtoReg), .RegWrite(IDEX_RegWrite), .MemWrite(IDEX_MemWrite), 
.RegOut2(Mux5Out), .AluOut(ALUOut), .Addr(Mux6Out), .MemtoReg_(EXMEM_MemtoReg), 
.RegWrite_(EXMEM_RegWrite), .MemWrite_(EXMEM_MemWrite), .RegOut2_(EXMEM_RD2), 
.AluOut_(EXMEM_AluOut), .Addr_(EXMEM_Addr));


dm_4k U_DM(.addr(EXMEM_AluOut[9:0]), .din(EXMEM_RD2), .DMWr(EXMEM_MemWrite), 
.clk(clk), .dout(DMOut));


MEMWB U_MEMWB(.clk(clk), .MemtoReg(EXMEM_MemtoReg), .RegWrite(EXMEM_RegWrite), 
.MemOut(DMOut), .AluOut(EXMEM_AluOut), .Addr(EXMEM_Addr), .MemtoReg_(MEMWB_MemtoReg), 
.RegWrite_(MEMWB_RegWrite), .MemOut_(MEMWB_MemOut), .AluOut_(MEMWB_AluOut), 
.Addr_(MEMWB_Addr));


mux2 #(32) U_Mux9(.d0(MEMWB_AluOut), .d1(MEMWB_MemOut), .s(MEMWB_MemtoReg), .y(Mux9Out));


Forward U_Forward(.EXMEM_RegWrite(EXMEM_RegWrite), .MEMWB_RegWrite(MEMWB_RegWrite), 
.EXMEM_Rd(EXMEM_Addr), .MEMWB_Rd(MEMWB_Addr), .IDEX_Rs(IDEX_Rs), .IDEX_Rt(IDEX_Rt), .Forward1(Forward1), .Forward2(Forward2));


endmodule