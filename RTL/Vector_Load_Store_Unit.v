module Vector_Load_Store_Unit (clk,rst,PC,vls_enable,VLR,Starting_Address,Memory_Address,Load_Store,Read_VData,Vector_Bus,start,done);
input [1:0]PC;
input clk,rst,vls_enable;
input [31:0] VLR;
input [31:0] Starting_Address;
input Load_Store;
input [31:0] Read_VData;
output reg [31:0] Memory_Address;
output [31:0]Vector_Bus;
output reg start,done;

reg [6:0]count;

always @(posedge clk) begin
    if (vls_enable) begin
        if (count<(VLR)) begin
            Memory_Address<=Memory_Address+1;
            count<=count+1;
            done<=(count==(VLR-1))?1:0;
            start<=(count<VLR)?1:0;
        end
    end
end
always @(posedge done) begin
    start<=0;
end
always @(posedge vls_enable) begin
    start<=1;
    Memory_Address <= Starting_Address-1;
end

always @(PC) begin
    count<=0;
    done<=0;
    Memory_Address <= Starting_Address;
end

assign Vector_Bus=Read_VData;
endmodule