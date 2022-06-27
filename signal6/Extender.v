
module Extender(ExtOut,DataIn,ExtOp);//这是符号拓展，如果extop为1，则为0拓展，其他情况下为符号拓展

	input [15:0] DataIn;
	input ExtOp;
	output reg[31:0] ExtOut;
	
	integer i;					//逻辑计数
	
	always@(DataIn or ExtOp)
	begin
		if(ExtOp == 1)
			begin
				for(i=0;i<32;i=i+1)
				begin
					if(i<16)
						ExtOut[i] = DataIn[i];
					else
						ExtOut[i] = 0;
				end	
			end
		else
			begin
				for(i=0;i<32;i=i+1)
				begin
					if(i<16)
						ExtOut[i] = DataIn[i];
					else
						ExtOut[i] = DataIn[15];
				end
			end
	end
endmodule