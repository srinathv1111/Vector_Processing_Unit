`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2024 01:56:46
// Design Name: 
// Module Name: Vector_Reg_Write
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Vector_Reg_Write(clk,pc_rst,VRW_Ena,VLR,
VResult_0,VResult_1,VResult_2,VResult_3,VResult_4,VResult_5,VResult_6,VResult_7,
Write_Data,VRW_done,VRW_start);
input clk;
input [1:0]pc_rst;
input VRW_Ena;
input [31:0] VLR;
input [31:0] VResult_0,VResult_1,VResult_2,VResult_3,VResult_4,VResult_5,VResult_6,VResult_7;
output reg[31:0] Write_Data;
output VRW_done; output reg VRW_start;
reg [6:0]count;



always @(posedge clk) begin
    if (VRW_start && ~VRW_done) begin
        count<=(count<VLR)?count+1:0;
    end
    VRW_start<=(VRW_done)?0:VRW_start;
end

always@(*) begin
case(count)
    0:Write_Data=VResult_0;
    1:Write_Data=VResult_1;
    2:Write_Data=VResult_2;
    3:Write_Data=VResult_3;
    4:Write_Data=VResult_4;
    5:Write_Data=VResult_5;
    6:Write_Data=VResult_6;
    7:Write_Data=VResult_7;
    default:Write_Data=0;
endcase
end

always @(pc_rst) begin
    count<=0;
//    VRW_done<=0;
end

always @(posedge clk) begin
    if (VRW_Ena && !VRW_done)VRW_start<=1;
    else VRW_start<=0;
end

always @(posedge VRW_done) begin
    VRW_start<=0;
end

assign VRW_done=(count==(VLR-1))?1:0;

endmodule
