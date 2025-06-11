`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2024 03:07:17
// Design Name: 
// Module Name: ALU
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


module ALU(a,b,ALU_Sel,ALU_Result,Z);

input signed [31:0] a,b;
input [3:0]ALU_Sel;
output reg signed [31:0] ALU_Result;
output Z;

always @(*) begin
    case(ALU_Sel)
    0:ALU_Result=a+b;//add
    1:ALU_Result=a-b;//sub
    2:ALU_Result=a^b;//xor
    3:ALU_Result=a|b;//or
    4:ALU_Result=a&b;//and
    5:ALU_Result=a<<b[4:0];//sll
    6:ALU_Result=a>>b[4:0];//srl
    7:ALU_Result=a>>>b[4:0];//sra
    default:ALU_Result=32'bx;
    endcase
end
assign Z=(ALU_Result==0)?1:0;
endmodule
