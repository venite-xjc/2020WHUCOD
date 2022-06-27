module Reg(A1, A2, A3, RD1, RD2, a, RD1_, RD2_, RegWrite);
input [4:0] A1, A2, A3;
input [31:0] a, RD1, RD2;
input RegWrite;
output reg [31:0] RD1_, RD2_;

always@(*) begin
    if(RegWrite)begin
        if(A3 == A1)
    RD1_ = a;
    else
    RD1_ = RD1;
    if(A3 == A2)
    RD2_ = a;
    else
    RD2_ = RD2;
    end
end
endmodule
