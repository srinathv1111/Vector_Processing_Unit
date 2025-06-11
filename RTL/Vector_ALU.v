`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.08.2024 02:51:16
// Design Name: 
// Module Name: Vector_ALU
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


module Vector_ALU(ena,a,b,sel,VALU_Result);
input ena;
input [31:0]a,b;
input [2:0] sel;
output [31:0] VALU_Result;
//output N,Z,C,V;
reg [32:0] Result;
always @(*) begin
    if (ena)
        case(sel)
        0:Result=a+b;//add
        1:Result=a-b;//sub
        2:Result=a*b;//xor
        3:Result=255-1;
//    3:VALU_Result=a|b;//or
//    4:ALU_Result=a&b;//and
//    5:ALU_Result=a<<b[4:0];//sll
//    6:ALU_Result=a>>b[4:0];//srl
//    7:ALU_Result=a>>>b[4:0];//sra
        default:Result=0;
        endcase
    else Result=0;
end
assign VALU_Result=Result[31:0];
//assign N=(VALU_Result<0)?1:0;
//assign Z=(VALU_Result==0)?1:0;
//assign C=Result[32];
//assign V=(Result>32'hFFFF_FFFF)?1:0;
endmodule
