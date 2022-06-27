module Npc(PC, Jump, Jr, Jal, Branch, Zero, JumpAddr, BranchAddr, JrAddr, NPC, bne);
    input [31:2] PC;
    input Jump, Jr, Jal, Branch, Zero, bne;
    input [25:0] JumpAddr;
    input [31:0] BranchAddr;
    input [31:0] JrAddr;
    output reg [31:2] NPC;

    reg [31:0] PC_, temp;
    

    always@(*) begin
        PC_ = {PC, 2'b00};
        PC_ = PC_+4;
        if(Jump||Jal) begin
            temp = {PC_[31:28], JumpAddr, 2'b00};
        end
        else if(Branch&&Zero) begin
            temp = BranchAddr << 2;
            temp = temp+PC_;
        end
        else if(Branch&&!Zero&&bne) begin
            temp = BranchAddr << 2;
            temp = temp+PC_;
        end
        else if(Jr) begin
            temp = JrAddr;
        end
        else begin
            temp = PC_;
        end
        NPC = temp[31:2];
    end
endmodule

