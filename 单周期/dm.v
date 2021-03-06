module dm_4k( addr, din, DMWr, clk, dout );//DataMem内存
   
   input  [11:2] addr;
   input  [31:0] din;
   input         DMWr;
   input         clk;
   output [31:0] dout;
   reg [31:0] a;
   reg [31:0] dmem[1023:0];
   
   always @(posedge clk) begin
      a = din;
      if (DMWr)
         dmem[addr] <= a;
         $display("addr=%8X",addr);//addr to DM
         $display("din=%8X",din);//data to DM
         $display("Mem[00-07]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",dmem[0],dmem[1],dmem[2],dmem[3],dmem[4],dmem[5],dmem[6],dmem[7]);
   end // end always
      assign dout = dmem[addr];
         
    
endmodule    
