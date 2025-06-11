`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 30.04.2024 16:24:20
// Design Name: 
// Module Name: RISC
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



module RISC_Core(clk_S,clk_V,reset,PC,Instruction_Code,ALU_Result,Write_Data);

input clk_S,reset,clk_V;
output [31:0] PC;
output [31:0] Instruction_Code;
output [31:0] ALU_Result,Write_Data;
wire [4:0]rs1,rs2,rd,rd_in2,rd_in;
wire [6:0]opcode;
wire [2:0] funct3;wire Imm_Sel;
wire [6:0] funct7;
wire [31:0] PC_Next,PC_Final;
wire [31:0] ALU_Result,Write_Data,read_data1,read_data2,Read_Data_Mem;
wire  Reg_Write,ALU_Src;
wire [3:0]ALU_Sel;
wire Zero;
wire [31:0] Extended_Value,alu_b;
wire Mem_Write,Mem_Read,Mem_to_Reg;
/////////////////////////////////////////////////////////////
wire [31:0] VLR,Write_ALU_Data,VData_In,VData_Out,write_vdata,write_vdata_final,Memory_Address,Vector_Address;
wire [2:0]rsv1,rsv2,rvd;
wire VLS_start,VLS_done,VRB_done,VRW_start,VRW_done;
wire VLS_enable,vreg_write,VRW_enable;
wire stall;
wire RLS_Sel;
wire sel_start,final_start;
wire [1:0] PC_rst;
wire [2:0] VALU_Sel;
wire [7:0] VALU_Ena;
//wire [(8*32)-1:0] read_v1,read_v2,VResult;
wire [31:0] read_v1_0,read_v1_1,read_v1_2,read_v1_3,read_v1_4,read_v1_5,read_v1_6,read_v1_7,
read_v2_0,read_v2_1,read_v2_2,read_v2_3,read_v2_4,read_v2_5,read_v2_6,read_v2_7,
VALU_Sel,VResult_0,VResult_1,VResult_2,VResult_3,VResult_4,VResult_5,VResult_6,VResult_7;
/////////////////////////////////////////////////////////////
PC P(clk_S,reset,PC_Final,PC);
PC_Adder PA(PC,4,PC_Next);
mux_2x1 pc_mux (PC,PC_Next,~stall,PC_Final);
/////////////////////////////////////////////////////////////
Instruction_Memory IM (clk_S,reset,PC,Instruction_Code);

Register_Bank RB(clk_S,reset,rs1,rs2,rd,Reg_Write,Write_Data,read_data1,read_data2,VLR);

ALU A(read_data1,alu_b,ALU_Sel,ALU_Result,Zero);
mux_2x1 ALU_B(read_data2,Extended_Value,ALU_Src,alu_b);

Control_Unit CU (PC,opcode,funct3,funct7,ALU_Sel,Reg_Write,ALU_Src,Imm_Sel,Mem_to_Reg,Mem_Read,Mem_Write
        ,VLR,VLS_done,VRB_done,VRW_done,VALU_Sel,VS_ADDR_Sel,VALU_Ena,VLS_enable,VW_Ena,
        vreg_write,Load_Store,VRW_enable,RLS_Sel,sel_start);
Sign_Extender SIGN(Instruction_Code,Imm_Sel,Extended_Value);

Data_Memory DM (clk_S,reset,Memory_Address,ALU_Result, Mem_Write, Mem_Read, Read_Data_Mem);
mux_2x1 MEM_REG (ALU_Result,Read_Data_Mem,Mem_to_Reg,Write_Data);

assign {funct7,rs2,rs1,funct3,rd,opcode}=Instruction_Code;//R-type

/////////////////////////////////////////////////////////////////////////////
Vector_Load_Store_Unit VLS(clk_V,reset,PC_rst,VLS_enable,VLR,read_data1,Vector_Address,Load_Store,VData_In,VData_Out,VLS_start,VLS_done);
mux_2x1 VA_SA(read_data2,Vector_Address,VS_ADDR_Sel,Memory_Address);

Vector_Register_Block VRB (clk_V,reset,PC_rst,VLR,stall,final_start,vreg_write,write_vdata_final,rsv1,rsv2,rvd,
read_v1_0,read_v1_1,read_v1_2,read_v1_3,read_v1_4,read_v1_5,read_v1_6,read_v1_7,
read_v2_0,read_v2_1,read_v2_2,read_v2_3,read_v2_4,read_v2_5,read_v2_6,read_v2_7,VRB_done);

VALU_Block VALUB(VALU_Ena,
read_v1_0,read_v1_1,read_v1_2,read_v1_3,read_v1_4,read_v1_5,read_v1_6,read_v1_7,
read_v2_0,read_v2_1,read_v2_2,read_v2_3,read_v2_4,read_v2_5,read_v2_6,read_v2_7,
VALU_Sel,VResult_0,VResult_1,VResult_2,VResult_3,VResult_4,VResult_5,VResult_6,VResult_7);

Vector_Reg_Write VRW(clk_V,PC_rst,VRW_enable,VLR,
VResult_0,VResult_1,VResult_2,VResult_3,VResult_4,VResult_5,VResult_6,VResult_7,
Write_ALU_Data,VRW_done,VRW_start);

mux_2x1 mux_RLS(Write_ALU_Data,write_vdata,RLS_Sel,write_vdata_final);
stall_unit VSU (opcode,VLS_done,VRB_done,stall);
/////////////////////////////////////////////////////////////////////////////
assign VData_In=(Load_Store)?Read_Data_Mem:'h0;
assign write_vdata=(Load_Store)?VData_Out:'h0;
assign rsv1=Instruction_Code[17:15];
assign rsv2=Instruction_Code[22:20];
assign rvd=Instruction_Code[9:7];
assign PC_rst=PC[3:2];
assign final_start=sel_start?VRW_start:VLS_start;
/////////////////////////////////////////////////////////////////////////////////

///////////////////////////////////////////////////////////////////////////////////////////
endmodule

