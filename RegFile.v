module regFile(rout1, rout2, rs1, rs2, rd, inp_data, clk, rst, we);

output [31:0] rout1, rout2;

input [4:0] rd, rs1, rs2;
input [31:0] inp_data;
input clk, rst, we;

reg [31:0] regMem [0:31];

integer i;

initial begin
for(i = 0; i < 31; i=i+1) begin
regMem[i] = 32'd0;
end
end

always@(posedge clk or posedge rst) begin
if(rst) begin

for(i = 0; i <= 31; i=i+1) begin
regMem[i] <= 0;
	end
end
else if(we && (rd != 0)) begin
regMem[rd] <= inp_data;
//$display("Data written in REG: %h at reg# %h", inp_data, rd);
end
end

assign rout1 = (rs1 != 0) ? regMem[rs1] : 0;
assign rout2 = (rs2 != 0) ? regMem[rs2] : 0;

endmodule


