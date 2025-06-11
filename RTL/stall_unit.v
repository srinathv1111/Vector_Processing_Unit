`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05.09.2024 21:58:50
// Design Name: 
// Module Name: stall_unit
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


module stall_unit (opcode,VLS_done,VRB_done,stall);
input [6:0] opcode;
input VLS_done,VRB_done;
output reg stall;

always @(*) begin
    if (opcode==7'b1111111 && VRB_done!=1) stall=1;
    else stall=0;
end
endmodule
