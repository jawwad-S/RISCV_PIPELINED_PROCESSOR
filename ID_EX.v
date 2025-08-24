module ID_EX(

input clk, rst, flush, MR_in, MW_in, MemtoReg_in, regWE_in, beq_in, bneq_in, bge_in, blt_in, jmp_in, jalr_in, aluSrc_in,
input [6:0] opcode_in, func7_in,
input [31:0] pc_in, imm_in, rout1_in, rout2_in, 
input [2:0] func3_in,
input [4:0] rs1_in, rs2_in, rd_in,
input [3:0] alu_op_in,


output reg MR_out, MW_out, MemtoReg_out, regWE_out, beq_out, bneq_out, bge_out, blt_out, jmp_out, jalr_out, aluSrc_out,
output reg [6:0] opcode_out, func7_out,
output reg [31:0] pc_out, imm_out, rout1_out, rout2_out, 
output reg [2:0] func3_out,
output reg [4:0] rs1_out, rs2_out, rd_out,
output reg [3:0] alu_op_out
);


always@(posedge clk or posedge rst) begin
if(rst) begin
	MR_out <= 0;
	MW_out <= 0;
	MemtoReg_out <= 0;
	regWE_out  <= 0;
	beq_out  <= 0;
	bneq_out <= 0;
	bge_out  <= 0;
	blt_out  <= 0;
	jmp_out  <= 0;
	jalr_out <= 0;
	opcode_out <= 0;
	func7_out  <= 0;
	pc_out    <= 0;
	imm_out   <= 0;
	rout1_out <= 0;
	rout2_out <= 0;
	func3_out <= 0;
	rs1_out <= 0;
	rs2_out <= 0;
	rd_out  <= 0;
	alu_op_out <= 0;
	aluSrc_out <= 0;
end

else if(flush) begin
	MR_out <= 0;
	MW_out <= 0;
	MemtoReg_out <= 0;
	regWE_out  <= 0;
	beq_out  <= 0;
	bneq_out <= 0;
	bge_out  <= 0;
	blt_out  <= 0;
	jmp_out  <= 0;
	jalr_out <= 0;
	opcode_out <= 0;
	func7_out  <= 0;
	pc_out    <= 0;
	imm_out   <= 0;
	rout1_out <= 0;
	rout2_out <= 0;
	func3_out <= 0;
	rs1_out <= 0;
	rs2_out <= 0;
	rd_out  <= 0;
	alu_op_out <= 0;
	aluSrc_out <= 0;
end


else begin


	MR_out <= MR_in;
	MW_out <= MW_in;
	MemtoReg_out <= MemtoReg_in;
	regWE_out  <= regWE_in;
	beq_out  <= beq_in;
	bneq_out <= bneq_in;
	bge_out  <= bge_in;
	blt_out  <= blt_in;
	jmp_out  <= jmp_in;
	jalr_out <= jalr_in;
	opcode_out <= opcode_in;
	func7_out  <= func7_in;
	pc_out    <= pc_in;
	imm_out   <= imm_in;
	rout1_out <= rout1_in;
	rout2_out <= rout2_in;
	func3_out <= func3_in;
	rs1_out <= rs1_in;
	rs2_out <= rs2_in;
	rd_out  <= rd_in;
	alu_op_out <= alu_op_in;
	aluSrc_out <= aluSrc_in;
end
end
endmodule


