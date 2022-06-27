module EXMEM(clk, MemtoReg, RegWrite, MemWrite, RegOut2, AluOut, Addr, MemtoReg_, RegWrite_, MemWrite_, RegOut2_, AluOut_, Addr_);
input MemtoReg, RegWrite, MemWrite, clk;
input [31:0] RegOut2, AluOut;
input [4:0] Addr;

output reg MemtoReg_, RegWrite_, MemWrite_;
output reg [31:0] RegOut2_, AluOut_;
output reg [4:0] Addr_;

always@(posedge clk) begin
    MemtoReg_ = MemtoReg;
    RegWrite_ = RegWrite;
    MemWrite_ = MemWrite;
    RegOut2_ = RegOut2;
    AluOut_ = AluOut;
    Addr_ = Addr;
end
endmodule