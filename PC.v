module PC(clk, rst, stall, pc_in, pc_out);

output  reg [31:0] pc_out;
input [31:0] pc_in;
input clk, rst, stall;

//initial 
//pc_out <= 0;

always @(posedge clk or posedge rst) begin
if(rst) 
pc_out <= 0 ;
else if(!stall)
pc_out <= pc_in;	
end
endmodule

