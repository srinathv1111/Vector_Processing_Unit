`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2024 21:26:19
// Design Name: 
// Module Name: Data_Memory
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


module Data_Memory(clk,rst,Address, Write_Data, Mem_Write, Mem_Read, Read_Data_Mem);
input [31:0] Address, Write_Data;
input Mem_Write,Mem_Read,clk,rst;
output reg [31:0] Read_Data_Mem;

reg [31:0] mem [0:30];
integer i;
 
always @(negedge clk) begin
    if (Mem_Write) mem[Address]=Write_Data;
end
always @(*) begin
    if (Mem_Read) Read_Data_Mem=mem[Address];
end

always @(posedge clk or posedge rst) begin
    if (rst) begin
        for (i=0;i<31;i=i+1)
        mem[i]=i;
    end
end


endmodule
