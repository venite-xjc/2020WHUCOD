module mips( clk, rst );
   input   clk;
   input   rst;
   
//PC	
	wire [29:0] PC, NPC;
   wire PCWR;
   
//IM	
	wire [9:0]  imAdr;
	wire [31:0] OpCode;
	
//RF
	wire [4:0] gprWeSel,gprReSel1,gprReSel2;
   assign gprReSel1 = OpCode[25:21];
   assign gprReSel2 = OpCode[20:16];
	wire [31:0] gprDataIn;
	wire RFWR;
	wire [31:0] gprDataOut1,gprDataOut2;
	
//Extender
	wire [15:0] extDataIn;
	wire [31:0] extDataOut;
	wire [1:0]  extCtrl;

//DMem
	wire [31:0]  dmDataAdr;
	wire [31:0] dmDataOut, dmDataIn;
	wire memWrite;

//Ctrl
	wire [5:0]		op;
	wire 		jump;						//指令跳转
	wire 		RegDst;						
	wire 		Branch;						//分支
	wire 		MemR;						//读存储器
	wire 		Mem2R;						//数据存储器到寄存器堆
	wire 		MemW;						//写数据存储器
	wire 		RegW;						//寄存器堆写入数据
	wire		Alusrc;						//运算器操作数选择
	// wire 		ExtOp;						//位扩展/符号扩展选择
	wire     Aluop1;						//Alu运算选择
   wire     Aluop2;
   wire     Aluop3;
   wire     Jr;
   wire     Jal;

//Alu1
	wire [31:0] alu1DataIn1, alu1DataIn2;
	wire [31:0]	alu1DataOut;
   wire [4:0]  alu1ctrl;
	wire 		zero;

//AluCtrl
   wire [5:0] funct;
   wire [1:0] ALUOp;
   wire [4:0] aluctrl;

   wire [4:0] mux1tomux4;

   wire [31:0] mux2out;
   wire slide;
   wire bne;
   wire [31:0] mux3tomux6;
   wire [1:0] ExtOp;
   PC U_PC (
      .clk(clk), .rst(rst), .PCWr(1'b1), .NPC(NPC), .PC(PC)
   ); 
   
   im_4k U_IM ( 
      .addr(PC[9:0]) , .dout(OpCode)
   );
   
    
   RF U_RF (
      .A1(gprReSel1), .A2(gprReSel2), .A3(gprWeSel), .WD(gprDataIn), .clk(clk), 
      .RFWr(RegW), .RD1(gprDataOut1), .RD2(gprDataOut2)
   );
   

   alu U_Alu1(
      .A(alu1DataIn1), .B(alu1DataIn2), .ALUOp(alu1ctrl), .C(alu1DataOut), .Zero(zero)
   );

   mux2 #(5) U_Mux1(.d0(OpCode[20:16]), .d1(OpCode[15:11]), .s(RegDst), .y(mux1tomux4));//在rt, rd中选择写寄存器地址

   EXT U_extend(.Imm16(OpCode[15:0]), .EXTOp(ExtOp), .Imm32(extDataOut));

   mux2 #(32) U_Mux2(.d0(gprDataOut2), .d1(extDataOut), .s(ALUSrc), .y(mux2out));//选择alu的输入是寄存器还是立即数
   assign alu1DataIn2 = mux2out;

   dm_4k U_Dmem(.clk(clk), .addr(alu1DataOut[9:0]), .din(gprDataOut2), .DMWr(MemW), .dout(dmDataOut));

   mux2 #(32) U_Mux3(.d0(alu1DataOut), .d1(dmDataOut), .s(Mem2R), .y(mux3tomux6));//选择返回寄存器的结果是mem还是alu计算结果

   mux2 #(5) U_Mux4(.d0(mux1tomux4), .d1(5'b11111), .s(Jal), .y(gprWeSel));//如果是jal，控制写寄存器地址为$ra

   mux2 #(32) U_Mux5(.d0(gprDataOut1), .d1(gprDataOut2), .s(slide), .y(alu1DataIn1));//如果是移位指令，控制alu的第一个输入为被移位数据（第二个输入是位移量）

   mux2 #(32) U_Mux6(.d0(mux3tomux6),.d1({PC, 2'b00}+4), .s(Jal), .y(gprDataIn) );//如果是jal,控制写寄存器数据为当前地址加4

   ALUCtrl U_ALUCtrl(.ALUOp1(Aluop1), .ALUOp2(Aluop2), .ALUOp3(Aluop3), .funct(OpCode[5:0]), .ALUSignal(alu1ctrl));

   Npc U_NPC(.PC(PC), .Jump(Jump), .Jr(Jr), .Jal(Jal), .Branch(Branch), .Zero(zero), 
   .JumpAddr(OpCode[25:0]), .BranchAddr(extDataOut), .JrAddr(gprDataOut1), .NPC(NPC), .bne(bne));
  
   CTRL U_CTRL(.Op(OpCode[31:26]), .Funct(OpCode[5:0]), .RegDst(RegDst), .Jump(Jump), .Jr(Jr), 
   .Jal(Jal), .bne(bne), .slide(slide), .ExtOp(ExtOp), .ALUSrc(ALUSrc), .MemtoReg(Mem2R), .RegWrite(RegW), .MemRead(MemR), 
   .MemWrite(MemW), .Branch(Branch), .ALUOp1(Aluop1), .ALUOp2(Aluop2), .ALUOp3(Aluop3));

endmodule