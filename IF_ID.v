
module IF_ID(clk, rst, stall, flush, instr_in, pc_in, instr_out, pc_out_i);
input clk, rst, flush, stall;
input [31:0] instr_in, pc_in;
output reg [31:0] instr_out, pc_out_i;


always@(posedge clk or posedge rst)
begin

if(rst) begin
	pc_out_i <= 0; 
	instr_out <= 0;
end

else if(flush) begin
	pc_out_i <= 0; 
	instr_out <= 0;
end

else if(!stall) begin
	pc_out_i <= pc_in;
	instr_out <= instr_in;
end

end
endmodule