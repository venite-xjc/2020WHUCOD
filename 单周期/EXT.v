`include "ctrl_encode_def.v"
module EXT( Imm16, EXTOp, Imm32 );
    
   input  [15:0] Imm16;
   input  [1:0]  EXTOp;
   output [31:0] Imm32;
   
   reg [31:0] Imm32;
    
   always @(*) begin
      case (EXTOp)
         `EXT_ZERO:    Imm32 = {16'd0, Imm16};//高16位直接拓展为0
         `EXT_SIGNED:  Imm32 = {{16{Imm16[15]}}, Imm16};//高16位拓展为原最高位
         `EXT_HIGHPOS: Imm32 = {Imm16, 16'd0};//原16位至于高位，低16位拓展为0
         default: ;
      endcase
   end // end always
    
endmodule
