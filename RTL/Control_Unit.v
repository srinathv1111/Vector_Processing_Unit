`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09.02.2024 03:29:17
// Design Name: 
// Module Name: Control_Unit
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


module Control_Unit (PC,opcode,funct3,funct7,ALU_Sel,Reg_Write,ALU_Src,Imm_Sel,Mem_to_Reg,Mem_Read,Mem_Write
        ,VLR,VLS_done,VRB_done,VRW_done,VALU_Sel,VS_ADDR_Sel,VALU_Ena,VLS_Enable,VW_Ena,
        vreg_write,Load_Store,VRW_Ena,RLS_Sel,sel_start);
input [6:0]opcode;
input [6:0]funct7;
input [2:0] funct3;
input [31:0] PC;
output reg [3:0] ALU_Sel;
output reg Reg_Write,ALU_Src,Mem_to_Reg,Mem_Read,Mem_Write;
output reg Imm_Sel;
///////////////////////////////////////////////////////////////////////////
input VLS_done,VRB_done,VRW_done;
input [31:0] VLR;
output reg [2:0]VALU_Sel;
output reg VLS_Enable,VW_Ena,vreg_write,Load_Store,VRW_Ena,VS_ADDR_Sel;
//output reg VLS_rst,VRB_rst;
output reg [7:0] VALU_Ena;
output reg RLS_Sel,sel_start;
//////////////////////////////////////////////////////////////////////////

parameter R=7'b0110011,I= 7'b0010011, Load=7'b0000011, Store=7'b0100011,Vec=7'b1111111;

always@(PC,opcode,funct3,funct7) begin
    Mem_Read=0;
    case(opcode)
    R: begin
        case ({funct3,funct7})
            {3'h0,7'h00}:ALU_Sel<=0;//add
            {3'h0,7'h20}:ALU_Sel<=1;//sub
            {3'h4,7'h00}:ALU_Sel<=2;//xor
            {3'h6,7'h00}:ALU_Sel<=3;//or
            {3'h7,7'h00}:ALU_Sel<=4;//and
            {3'h1,7'h00}:ALU_Sel<=5;//sll
            {3'h5,7'h00}:ALU_Sel<=6;//srl
            {3'h5,7'h20}:ALU_Sel<=7;//sra
        endcase
        Reg_Write<=1;
        Mem_Read<=0;
        Mem_Write<=0;
        Mem_to_Reg<=0;
        Imm_Sel<=1'bx;
        ALU_Src<=0;
        VALU_Ena<=0;VLS_Enable<=0;VW_Ena<=0;vreg_write<=0;VRW_Ena<=0;VS_ADDR_Sel<=0;sel_start<=1'bx;
    end
    
    I: begin
            casex({funct3,funct7})
            {3'h0,7'hzz}:begin ALU_Sel<=0; Imm_Sel<=0;end //addi
            {3'h4,7'hzz}:begin ALU_Sel<=2; Imm_Sel<=0;end//xori
            {3'h6,7'hzz}:begin ALU_Sel<=3; Imm_Sel<=0;end//ori
            {3'h7,7'hzz}:begin ALU_Sel<=4; Imm_Sel<=0;end//andi
            {3'h1,7'h00}:begin ALU_Sel<=5; Imm_Sel<=0;end//slli
            {3'h5,7'h00}:begin ALU_Sel<=6; Imm_Sel<=0;end //srli
            {3'h5,7'h20}:begin ALU_Sel<=7; Imm_Sel<=0;end//srai
            endcase
            Reg_Write<=1;
            ALU_Src<=1;
            Mem_to_Reg<=0;
            Mem_Read<=0;
            Mem_Write<=0;
            VALU_Ena<=0;VLS_Enable<=0;VW_Ena<=0;vreg_write<=0;VRW_Ena<=0;VS_ADDR_Sel<=0;sel_start<=1'bx;
    end
    
    Load: begin //lw
            if (funct3==2) begin 
                Mem_Read<=1;
                Mem_Write<=0;
                Mem_to_Reg<=1;
                Reg_Write<=1;
                ALU_Sel<=0;
                Imm_Sel<=0;
                ALU_Src<=1;
                VALU_Ena<=0;VLS_Enable<=0;VW_Ena<=0;vreg_write<=0;VRW_Ena<=0;VS_ADDR_Sel<=0;sel_start<=1'bx;
            end
        end
    Store:begin //sw
            if (funct3==2) begin 
                Mem_Read<=0;
                Mem_Write<=1;
                Mem_to_Reg<=0;
                Reg_Write<=0;
                ALU_Sel<=0;
                Imm_Sel<=1;
                ALU_Src<=1;
                VALU_Ena<=0;VLS_Enable<=0;VW_Ena<=0;vreg_write<=0;VRW_Ena<=0;VS_ADDR_Sel<=0;sel_start<=1'bx;
            end
        end
    Vec: begin
               Reg_Write<=0;
               ALU_Sel<=4'bx;
               Mem_Write<=0;
               Mem_to_Reg<=1'bx;
               Imm_Sel<='bx;
               ALU_Src<=1'bx;
              case (funct7)
              7'b0000001:begin Load_Store<=1; //Load.Vec
                               VLS_Enable<=1;
                               vreg_write<=1; 
                               RLS_Sel<=1;
                               VS_ADDR_Sel<=1;
                               Mem_Read<=1;
                               sel_start<=0;
                               VALU_Ena<=0;
                         end
              7'b0000000:begin Mem_Read<=0;VALU_Sel<=0; VRW_Ena<=1; RLS_Sel<=0; VLS_Enable<=0; RLS_Sel<=0;//Add.Vec
                        case(VLR) ('d1):VALU_Ena<=8'b1;
                                  ('d2):VALU_Ena<=8'b11;
                                  ('d3):VALU_Ena<=8'b111;
                                  ('d4):VALU_Ena<=8'b1111;
                                  ('d5):VALU_Ena<=8'b11111;
                                  ('d6):VALU_Ena<=8'b111111;
                                  ('d7):VALU_Ena<=8'b1111111;
                                  ('d8):VALU_Ena<=8'b11111111;
                                  default:VALU_Ena<=0;
                        endcase
                        VS_ADDR_Sel<='bx;
                        sel_start<=1;
                        end//add 
              7'b0100000:begin Mem_Read<=0;VALU_Sel<=1; VRW_Ena<=1; RLS_Sel<=0; VLS_Enable<=0; RLS_Sel<=0;//Sub.Vec
                                  case(VLR) ('d1):VALU_Ena<=8'b1;
                                            ('d2):VALU_Ena<=8'b11;
                                            ('d3):VALU_Ena<=8'b111;
                                            ('d4):VALU_Ena<=8'b1111;
                                            ('d5):VALU_Ena<=8'b11111;
                                            ('d6):VALU_Ena<=8'b111111;
                                            ('d7):VALU_Ena<=8'b1111111;
                                            ('d8):VALU_Ena<=8'b11111111;
                                            default:VALU_Ena<=0;
                                  endcase
                                  VS_ADDR_Sel<='bx;
                                  sel_start<=1;
                         end//sub
              7'b1100000:begin Mem_Read<=0;VALU_Sel<=2; VRW_Ena<=1; RLS_Sel<=0; VLS_Enable<=0; RLS_Sel<=0;//Add.Vec
                                            case(VLR) ('d1):VALU_Ena<=8'b1;
                                                      ('d2):VALU_Ena<=8'b11;
                                                      ('d3):VALU_Ena<=8'b111;
                                                      ('d4):VALU_Ena<=8'b1111;
                                                      ('d5):VALU_Ena<=8'b11111;
                                                      ('d6):VALU_Ena<=8'b111111;
                                                      ('d7):VALU_Ena<=8'b1111111;
                                                      ('d8):VALU_Ena<=8'b11111111;
                                                      default:VALU_Ena<=0;
                                            endcase
                                            VS_ADDR_Sel<='bx;
                                            sel_start<=1;
                                            end//mul
              endcase
        end
        
    default: begin 
       Reg_Write<=0;
       ALU_Sel<=4'bx;
       Mem_Read<=0;
       Mem_Write<=0;
       Mem_to_Reg<=1'bx;
       Imm_Sel<='bx;
       ALU_Src<=1'bx;
       VALU_Ena<=0;VLS_Enable<=0;VW_Ena<=0;vreg_write<=0;VRW_Ena<=0;VS_ADDR_Sel<=0;sel_start<=1'bx;
       end
    endcase
end

endmodule
