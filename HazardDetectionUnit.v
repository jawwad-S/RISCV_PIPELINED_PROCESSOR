module HDU(rs1, rs2, rd, MR, stall);

input [4:0] rs1, rs2, rd;
input MR;
output reg stall;

always @(*) begin
if(MR && ((rd == rs1) || (rd == rs2)))
stall <= 1'b1;
else 
stall <= 1'b0;
end
endmodule
