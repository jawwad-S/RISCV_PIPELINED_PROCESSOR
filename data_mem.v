module data_mem(data_out,data,addrs,we,re,clk);

input [31:0]data;
input [31:0]addrs;
input clk,we,re;
output reg [31:0] data_out;

reg [31:0]data_mem[0:2**6-1];

integer i;
initial begin
for(i = 0; i < 2**13; i=i+1) begin
data_mem[i] = 32'd0;
end
end

//Read op wont be in clk as it will cause time delay in instr of both Read mem and write reg 
always@(*) begin
if(re) begin
data_out <= data_mem[addrs[31:2]]; 	end
//for debug
//$display("Data read from mem: addrs:%h, data: %h", addrs, data_out); end
else 
data_out <= 32'd0;
end
always@(posedge clk)
begin

//if(re)
//data_out <= data_mem[addrs[31:2]];

 if(we) begin
data_mem[addrs[31:2]] <= data;
//for debug
//$display("Data written in mem: addrs:%h, data: %h", addrs, data);
end
end
endmodule


