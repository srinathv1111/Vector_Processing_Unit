`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2024 17:59:30
// Design Name: 
// Module Name: VALU_Block
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


module VALU_Block(ena,
read_v1_0,read_v1_1,read_v1_2,read_v1_3,read_v1_4,read_v1_5,read_v1_6,read_v1_7,
read_v2_0,read_v2_1,read_v2_2,read_v2_3,read_v2_4,read_v2_5,read_v2_6,read_v2_7,
VALU_Sel,VResult_0,VResult_1,VResult_2,VResult_3,VResult_4,VResult_5,VResult_6,VResult_7);
input [7:0] ena;
input [31:0]read_v1_0,read_v1_1,read_v1_2,read_v1_3,read_v1_4,read_v1_5,read_v1_6,read_v1_7,
read_v2_0,read_v2_1,read_v2_2,read_v2_3,read_v2_4,read_v2_5,read_v2_6,read_v2_7;
input [2:0] VALU_Sel;
output [31:0]VResult_0,VResult_1,VResult_2,VResult_3,VResult_4,VResult_5,VResult_6,VResult_7;

Vector_ALU VA1(ena[0],read_v1_0,read_v2_0,VALU_Sel,VResult_0);
Vector_ALU VA2(ena[1],read_v1_1,read_v2_1,VALU_Sel,VResult_1);
Vector_ALU VA3(ena[2],read_v1_2,read_v2_2,VALU_Sel,VResult_2);
Vector_ALU VA4(ena[3],read_v1_3,read_v2_3,VALU_Sel,VResult_3);
Vector_ALU VA5(ena[4],read_v1_4,read_v2_4,VALU_Sel,VResult_4);
Vector_ALU VA6(ena[5],read_v1_5,read_v2_5,VALU_Sel,VResult_5);
Vector_ALU VA7(ena[6],read_v1_6,read_v2_6,VALU_Sel,VResult_6);
Vector_ALU VA8(ena[7],read_v1_7,read_v2_7,VALU_Sel,VResult_7);

endmodule
