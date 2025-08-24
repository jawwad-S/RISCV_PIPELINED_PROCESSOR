module forwardingUnit(rs1, rs2, rd_EX_MEM, rd_MEM_WB, regWE_EX_MEM, regWE_MEM_WB, Forward_A, Forward_B);

input [4:0] rs1, rs2, rd_EX_MEM, rd_MEM_WB;
input regWE_EX_MEM, regWE_MEM_WB;
output reg [1:0] Forward_A, Forward_B;

always@(*) begin
//Default
Forward_A = 2'b00;
Forward_B = 2'b00;


if(regWE_EX_MEM & (rd_EX_MEM == rs1))
Forward_A = 2'b10;
else if(regWE_MEM_WB & (rd_MEM_WB == rs1))
Forward_A = 2'b01;
else 
Forward_A = 2'b00;


if(regWE_EX_MEM & (rd_EX_MEM == rs2))
Forward_B = 2'b10;
else if(regWE_MEM_WB & (rd_MEM_WB == rs2))
Forward_B = 2'b01;
else 
Forward_B = 2'b00;
end
endmodule

