`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2024 02:27:06
// Design Name: 
// Module Name: Instruction_Memory
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


module Instruction_Memory(clk,reset,PC,Instruction_Code);
input [31:0] PC;
input reset,clk;
output [31:0] Instruction_Code;

reg [7:0]rom[100:0];
assign Instruction_Code={rom[PC+3],rom[PC+2],rom[PC+1],rom[PC]};

always @(posedge clk) begin
    if (reset) begin//write instructions here.format=[imm,rs1,f3,rd,opcode]
    {rom[3], rom[2], rom[1], rom[0] }=32'b0000001_00000_00001_000_00001_1111111;//LV V1,R1;
    {rom[7], rom[6], rom[5], rom[4] }=32'b0000001_00000_00010_000_00010_1111111;//LV V2,R2;
//    {rom[11],rom[10],rom[9], rom[8] }=32'b0000001_00000_00011_000_00011_1111111;//LV V3,R3;
    {rom[11],rom[10],rom[9], rom[8] }=32'b0000000_00010_00001_000_00011_1111111;//Add.V V3,V1,V2;
    {rom[15],rom[14],rom[13],rom[12]}=32'b0100000_00010_00001_000_00100_1111111;//Sub.V V4,V1,V2;
    {rom[19],rom[18],rom[17],rom[16]}=32'b1100000_00010_00001_000_00101_1111111;//Mul.V V5,V1,V2;
    end
end

endmodule
