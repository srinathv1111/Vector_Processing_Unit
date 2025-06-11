module Vector_Register_Block (clk,rst,PC,VLR,stall,start,vreg_write,write_vdata,rsv1,rsv2,rvd,
read_v1_0,read_v1_1,read_v1_2,read_v1_3,read_v1_4,read_v1_5,read_v1_6,read_v1_7,
read_v2_0,read_v2_1,read_v2_2,read_v2_3,read_v2_4,read_v2_5,read_v2_6,read_v2_7,done);
input clk,rst,start,vreg_write;
output done;
input [31:0] VLR;
input [31:0] write_vdata;
input [2:0]rsv1,rsv2,rvd;
output [31:0]read_v1_0;
output [31:0]read_v1_1;
output [31:0]read_v1_2;
output [31:0]read_v1_3;
output [31:0]read_v1_4;
output [31:0]read_v1_5;
output [31:0]read_v1_6;
output [31:0]read_v1_7;
output [31:0]read_v2_0;
output [31:0]read_v2_1;
output [31:0]read_v2_2;
output [31:0]read_v2_3;
output [31:0]read_v2_4;
output [31:0]read_v2_5;
output [31:0]read_v2_6;
output [31:0]read_v2_7;
input stall;
input [1:0]PC;
reg [31:0]VRegs[0:7][0:7];
reg [31:0]tmp_reg[0:7];
reg [6:0]count=0;
reg done;
reg init;

always @(negedge clk) begin
    if (init && vreg_write) begin
        if (count<(VLR)) begin
            count<=count+1;
            tmp_reg[count]<=write_vdata;
            done<=0;
        end
        else if (count==(VLR)) done<=1;
    end
end

always @(posedge rst or posedge start) begin
    if (rst) begin
        done<=0;
        count <= 7'b0;
    end 
    if (start) begin
        init=1;
    end   
end

always @(posedge done) begin
    if (done) init=0;
    VRegs[rvd][0]<=tmp_reg[0];
    VRegs[rvd][1]<=tmp_reg[1];
    VRegs[rvd][2]<=tmp_reg[2];
    VRegs[rvd][3]<=tmp_reg[3];
    VRegs[rvd][4]<=tmp_reg[4];
    VRegs[rvd][5]<=tmp_reg[5];
    VRegs[rvd][6]<=tmp_reg[6];
    VRegs[rvd][7]<=tmp_reg[7];
end
always @(PC) begin
        if (stall==0 && done==1) done<=0;
end
always @(PC) begin
    count<=0;
    tmp_reg[0]<='bx;
    tmp_reg[1]<='bx;
    tmp_reg[2]<='bx;
    tmp_reg[3]<='bx;
    tmp_reg[4]<='bx;
    tmp_reg[5]<='bx;
    tmp_reg[6]<='bx;
    tmp_reg[7]<='bx;
end
assign read_v1_0=VRegs[rsv1][0];
assign read_v1_1=VRegs[rsv1][1];
assign read_v1_2=VRegs[rsv1][2];
assign read_v1_3=VRegs[rsv1][3];
assign read_v1_4=VRegs[rsv1][4];
assign read_v1_5=VRegs[rsv1][5];
assign read_v1_6=VRegs[rsv1][6];
assign read_v1_7=VRegs[rsv1][7];
assign read_v2_0=VRegs[rsv2][0];
assign read_v2_1=VRegs[rsv2][1];
assign read_v2_2=VRegs[rsv2][2];
assign read_v2_3=VRegs[rsv2][3];
assign read_v2_4=VRegs[rsv2][4];
assign read_v2_5=VRegs[rsv2][5];
assign read_v2_6=VRegs[rsv2][6];
assign read_v2_7=VRegs[rsv2][7];
endmodule