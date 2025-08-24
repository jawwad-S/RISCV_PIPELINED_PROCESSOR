module EX_MEM (

input clk, rst /*, flush*/, MR_in, MW_in, MemtoReg_in, jmp_in, beq_in, bneq_in, bge_in, blt_in, regWE_in,
input [4:0] rd_in,		//destination reg index for WB stage
input [31:0] alu_result_in, rout2_in, pc_in,

output reg MR_out, MW_out, MemtoReg_out, jmp_out, beq_out, bneq_out, bge_out, blt_out, regWE_out,
output reg [4:0] rd_out,
output reg [31:0] alu_result_out, rout2_out, pc_out
);

always@(posedge clk or posedge rst) begin
if(rst) begin
	MR_out <= 0;
	MW_out <= 0;
	MemtoReg_out <= 0;
	jmp_out <= 0;
	beq_out <= 0;
	bneq_out <= 0;
	bge_out <= 0;
	blt_out <= 0;
	regWE_out <= 0;
	rd_out <= 0;
	alu_result_out <= 0;
	rout2_out <= 0;
	pc_out <= 0;
end

/*else if(flush) begin
	MR_out <= 0;
	MW_out <= 0;
	MemtoReg_out <= 0;
	jmp_out <= 0;
	beq_out <= 0;
	bneq_out <= 0;
	bge_out <= 0;
	blt_out <= 0;
	regWE_out <= 0;
	rd_out <= 0;
	alu_result_out <= 0;
	rout2_out <= 0;
	pc_out <= 0;
end*/


else begin
	MR_out <= MR_in;
	MW_out <= MW_in;
	MemtoReg_out <= MemtoReg_in;
	jmp_out <= jmp_in;
	beq_out <= beq_in;
	bneq_out <= bneq_in;
	bge_out <= bge_in;
	blt_out <= blt_in;
	regWE_out <= regWE_in;
	rd_out <= rd_in;
	alu_result_out <= alu_result_in;
	rout2_out <= rout2_in; 
	pc_out <= pc_in;
     end
end
endmodule

