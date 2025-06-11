`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 26.08.2024 21:22:39
// Design Name: 
// Module Name: Sign_Extender
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


module Sign_Extender(Instruction_Code,Imm_Sel,Extended_Value);
input [31:0] Instruction_Code;
input Imm_Sel;
output reg [31:0] Extended_Value;

wire [11:0]Imm_I,Imm_S;

assign Imm_I=Instruction_Code[31:20];
assign Imm_S={Instruction_Code[31:25],Instruction_Code[11:7]};

always @(*) begin
    case(Imm_Sel)
    0: Extended_Value={{20{Instruction_Code[31]}},Imm_I};//Load, I type
    1: Extended_Value={{20{Instruction_Code[31]}},Imm_S};//Store
//    2: Extended_Value={{27{Imm_I[4]}},{Imm_I[4:0]}} ;//slli,srli,srai if (funct3==1||funct3==5)
    endcase
end
endmodule
