`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2024 02:15:23
// Design Name: 
// Module Name: PC
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


module PC(input clk,input reset,input [31:0]pc_in,output reg[31:0]pc_out);
always@(posedge clk or posedge reset) begin
    if (reset) pc_out=0;
    else pc_out=pc_in;
end
endmodule
