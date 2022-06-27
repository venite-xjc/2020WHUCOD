module Hazard(IDEX_MemRead, IDEX_Rt, IFID_Rs, IFID_Rt, PCWr, flush, IFIDWrite);

input IDEX_MemRead;
input [4:0] IDEX_Rt, IFID_Rs, IFID_Rt, IDEX_Rt;
output reg PCWr, flush, IFIDWrite;
initial begin
    PCWr = 0;
    IFIDWrite = 1;
    flush = 0;
end
always@(*) begin
    
    if(IDEX_MemRead&&((IDEX_Rt == IFID_Rs)||(IDEX_Rt == IFID_Rt))) begin
        PCWr = 0;
        IFIDWrite = 0;
        flush = 1;
    end
    else begin
        PCWr = 1;
        IFIDWrite = 1;
        flush = 0;
    end
end
endmodule