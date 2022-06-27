module MEMWB(clk, MemtoReg, RegWrite, MemOut, AluOut, Addr, MemtoReg_, RegWrite_, MemOut_, AluOut_, Addr_);

input clk, MemtoReg, RegWrite;
input [31:0] MemOut, AluOut;
input [4:0] Addr;
output reg MemtoReg_, RegWrite_;
output reg [31:0] MemOut_, AluOut_;
output reg [4:0] Addr_;

always@(posedge clk) begin
    MemtoReg_ = MemtoReg;
    RegWrite_ = RegWrite;
    MemOut_ = MemOut;
    AluOut_ = AluOut;
    Addr_ = Addr;
end
endmodule
