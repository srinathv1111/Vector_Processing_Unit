`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2024 16:37:01
// Design Name: 
// Module Name: Register_Bank
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


module Register_Bank(clk,reset,rs1,rs2,rd,Reg_Write,Write_Data,read_data1,read_data2,VLR);
input [4:0] rs1,rs2,rd;
input Reg_Write;
input clk,reset;
input [31:0] Write_Data;

output [31:0]read_data1,read_data2;

output [31:0] VLR;//assume reg number 31 for Vector Length

reg [31:0] Registers [0:31];

assign read_data1=Registers[rs1];
assign read_data2=Registers[rs2];

always @(posedge clk) begin
    if (reset) begin
        for (int i=0;i<32;i++)
        Registers[i]=i;
        Registers[31]=8;
    end
end

always @(negedge clk) begin
    if (Reg_Write) Registers[rd]=Write_Data; 
end

assign VLR=Registers[31];

endmodule
