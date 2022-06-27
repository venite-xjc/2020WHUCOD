module PC( clk, rst, PCWr, NPC, PC );
           
   input         clk;
   input         rst;
   input         PCWr;
   input  [31:2] NPC;
   output [31:2] PC;
   
   reg [31:2] PC;
   reg [1:0] tmp;
               
   always @(*) begin
      if ( rst ) 
         {PC, tmp} <= 32'h0000_3000;   
      else if ( PCWr ) 
         PC <= NPC;
      $display("PC = %8X", {PC, 2'b00});
   end // end always
           
endmodule
