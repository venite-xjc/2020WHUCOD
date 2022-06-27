`include "ctrl_encode_def.v"
module alu (A, B, ALUOp, C, Zero);
           
   input  [31:0] A, B;
   input  [4:0]  ALUOp;
   output [31:0] C;
   output        Zero;
   
   reg [31:0] C;
       
   always @(*) begin
      case ( ALUOp )
         `ALUOp_ADDU: C = A + B;
         `ALUOp_SUBU: C = A - B;
         `ALUOp_OR  : C = A | B;  //增加了或运算
         `ALUOp_ADD : C = $signed(A) + $signed(B) ;
         `ALUOp_NOP : C = A;                                  
         `ALUOp_SUB : C = $signed(A) - $signed(B);    
         `ALUOp_AND : C = A & B;                      
         `ALUOp_SLT : C = ($signed(A) < $signed(B)) ? 32'd1 : 32'd0;   
         `ALUOp_SLL : C = A << B[10:6];                    
         `ALUOp_SRL : C = A >> B[10:6];                   
         `ALUOp_SRA : C = ( $signed(A) ) >>> B[10:6];
         `ALUOp_LUI : C = {B[15:0], 16'b0000000000000000};              
         default:   ;
      endcase
   end // end always;
   
   assign Zero = (A == B) ? 1 : 0;

endmodule
    
