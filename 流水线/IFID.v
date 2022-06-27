module IFID(IFIDWrite, clk, PC, OpCode, PC_, OpCode_);
input IFIDWrite, clk;
input [31:0] OpCode;
input [31:2] PC;
output reg [31:0] OpCode_;
output reg [31:2] PC_;

always@(posedge clk) begin
    if(IFIDWrite) begin
        OpCode_ = OpCode;
        PC_ = PC;
    end
end
endmodule