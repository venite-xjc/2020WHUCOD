module im_4k( addr, dout );//读取32位机器码，指令内存
    
    input [9:0] addr;
    output [31:0] dout;
    
    reg [31:0] imem[10230:0];
    initial begin
    // imem[0] = 32'h341d000c;
    // imem[1] = 32'h34021234;
    // imem[2] = 32'h34033456;
    // imem[3] = 32'h00432021;
    // imem[4] = 32'h00643023;
    // imem[5] = 32'hac020000;
    // imem[6] = 32'hac030004;
    // imem[7] = 32'hafa40004;
    // imem[8] = 32'h8c050000;
    // imem[9] = 32'h10450001;
    // imem[10] = 32'h8fa30004;
    // imem[11] = 32'h8c050004;
    // imem[12] = 32'h1065fffd;
    // imem[13] = 32'h00c23023;
    // imem[14] = 32'hafa6fffc;
    // imem[15] = 32'h1063fff0;
    end
    assign dout = imem[addr];
    always@(*) begin
        $display("imaddr=%8X",addr);//addr to DM
        $display("imdout=%8X",dout);//data to DM
        $display("Mem[3072-3079]=%8X, %8X, %8X, %8X, %8X, %8X, %8X, %8X",imem[3072],imem[3073],imem[3074],imem[3075],imem[3076],imem[3077],imem[3078],imem[3079]);
    end
    
endmodule    
