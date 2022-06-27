

module IM(OpCode,ImAdress);//这是读指令的，输出32位机器码
	input [4:0] ImAdress;
	
	output [31:0]  OpCode;
	
	reg[31:0] Opcode;
	
	reg [31:0]  IMem[1024:0];
	
	always@(ImAdress)
	begin
		     Opcode = IMem[ImAdress];	
	end
	assign OpCode = Opcode;
endmodule