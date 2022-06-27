module Forward(EXMEM_RegWrite, MEMWB_RegWrite, EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt, Forward1, Forward2);
input EXMEM_RegWrite, MEMWB_RegWrite;
input [4:0] EXMEM_Rd, MEMWB_Rd, IDEX_Rs, IDEX_Rt;
output reg [1:0] Forward1,Forward2;
initial begin
    Forward1 = 2'b00;
    Forward2 = 2'b00;
end
always@(*) begin
    Forward1 = 2'b00;
    Forward2 = 2'b00;
    

    if(MEMWB_RegWrite&&(MEMWB_Rd != 0)&& !(EXMEM_RegWrite && (EXMEM_Rd != 0) && (EXMEM_Rd != IDEX_Rs)) && (MEMWB_Rd == IDEX_Rs))
    Forward1 =2'b01;
    if(MEMWB_RegWrite&&(MEMWB_Rd != 0)&& !(EXMEM_RegWrite && (EXMEM_Rd != 0) && (EXMEM_Rd != IDEX_Rt)) && (MEMWB_Rd == IDEX_Rt))
    Forward2 =2'b01;
    
    if(EXMEM_RegWrite&&(EXMEM_Rd!=0)&&(EXMEM_Rd == IDEX_Rs))
    Forward1 = 2'b10;
    if(EXMEM_RegWrite&&(EXMEM_Rd!=0)&&(EXMEM_Rd == IDEX_Rt))
    Forward2 = 2'b10;
end
endmodule
