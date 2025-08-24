
module pipelined_processor_core (clk, rst);

input clk, rst;

//////////////////////// WIRES OF ALL MODULES ///////////////////////////////

//PC
wire [31:0] pc_in, pc_out;


//i_mem
wire [31:0] instr;

//IF_ID
wire flush;
wire [31:0] instr_IF_ID_out;
wire [31:0] pc_IF_ID_out;

//inst_decode
wire [31:0] imm;
wire [6:0] opcode, func7;
wire [2:0] func3;
wire [4:0] rs1,rs2,rd;

//regFile
wire [31:0] rout1, rout2;
wire [31:0] reg_inp_data;
wire  regWE;

//CU
wire [3:0]alu_op;
wire MR, MW, beq, bneq, bge, blt, jmp, jalr, MemtoReg, aluSrc;


//ID_EX
wire MR_ID_EX_out, MW_ID_EX_out, MemtoReg_ID_EX_out, regWE_ID_EX_out, beq_ID_EX_out, bneq_ID_EX_out, bge_ID_EX_out, blt_ID_EX_out, jmp_ID_EX_out, jalr_ID_EX_out, aluSrc_ID_EX_out;
wire [6:0] opcode_ID_EX_out, func7_ID_EX_out;
wire [31:0] pc_ID_EX_out, imm_ID_EX_out, rout1_ID_EX_out, rout2_ID_EX_out;
wire [2:0] func3_ID_EX_out;
wire [4:0] rs1_ID_EX_out, rs2_ID_EX_out, rd_ID_EX_out;
wire [3:0] alu_op_ID_EX_out;

//ALU
wire [31:0] Result;
wire [31:0] B;

//EX_MEM
wire MR_EX_MEM_out, MW_EX_MEM_out,MemtoReg_EX_MEM_out, jmp_EX_MEM_out, beq_EX_MEM_out , bneq_EX_MEM_out , bge_EX_MEM_out , blt_EX_MEM_out , regWE_EX_MEM_out;
wire [4:0] rd_EX_MEM_out;
wire [31:0] alu_result_EX_MEM_out, rout2_EX_MEM_out, pc_EX_MEM_out;

//data_mem
wire re; 
wire [31:0] read_mem_data;

//MEM_WB
wire MemtoReg_MEM_WB_out, jmp_MEM_WB_out, regWE_MEM_WB_out;
wire [4:0] rd_MEM_WB_out;
wire [31:0] alu_result_MEM_WB_out, read_mem_data_MEM_WB_out, pc_MEM_WB_out;

///// forwardingUnit
wire [1:0] forward_A, forward_B;
wire [31:0] FU_MUX_A, FU_MUX_B;


//Extra wires for PC muxing
wire branch_taken;
wire [31:0] target_branch;
/////////////////////////// INSTANTIATING MODULES ////////////////////////////


////////////// FETCH STAGE /////////////////

///// IF /////

//PC muxing logic
//assign pc_in = pc_out + 4;
assign pc_in = (jalr_ID_EX_out) ? ((pc_out + rout1_ID_EX_out) & ~32'b1)
		:(branch_taken || jmp_ID_EX_out) ? target_branch : pc_out + 4;

//PC
PC PC_inst (
	.clk(clk),
	.rst(rst),
	.pc_in(pc_in),
	.pc_out(pc_out),
	.stall(stall)
);

//i_mem
i_mem imem_inst (
	.PC(pc_out),
	.instr(instr)
);


///// IF_ID /////
IF_ID IF_ID_inst (
	.clk(clk),
	.rst(rst),
	.flush(flush),
	.instr_in(instr),
	.pc_in(pc_out),
	.instr_out(instr_IF_ID_out),
	.pc_out_i(pc_IF_ID_out),
	.stall(stall)
);

////////////// DECODE STAGE /////////////////

///// ID /////
inst_decode i_decode_instn (
	.instr(instr_IF_ID_out),
	.imm(imm),
	.opcode(opcode),
	.func7(func7),
	.func3(func3),
	.rs1(rs1),
	.rs2(rs2),
	.rd(rd)
);

///// CU /////
CU CU_inst (
	.opcode(opcode),
	.func7(func7),
	.func3(func3),
	.alu_op(alu_op),
	.MR(MR),
	.MW(MW),
	.MemtoReg(MemtoReg),
	.regWE(regWE),
	.beq(beq),
	.bneq(bneq),
	.bge(bge),
	.blt(blt),
	.jmp(jmp),
	.jalr(jalr),
	.aluSrc(aluSrc),
	.stall(stall)
);

///// regFile /////
regFile regFile_inst (
	.clk(clk),
	.rst(rst),
	.we(regWE_MEM_WB_out),
	.rs1(rs1),
	.rs2(rs2),
	.rd(rd_MEM_WB_out),
	.rout1(rout1),
	.rout2(rout2),
	.inp_data(reg_inp_data)
);
		

///// ID_EX /////
ID_EX ID_EX_inst (
	.clk(clk),
	.rst(rst),
	.flush(flush),
	.MR_in(MR),
	.MW_in(MW),
	.MemtoReg_in(MemtoReg),
	.regWE_in(regWE),
	.beq_in(beq),
	.bneq_in(bneq),
	.bge_in(bge),
	.blt_in(blt),
	.jmp_in(jmp),
	.jalr_in(jalr),
	.opcode_in(opcode),
	.func7_in(func7),
	.pc_in(pc_out),
	.imm_in(imm),
	.rout1_in(rout1),
	.rout2_in(rout2),
	//.reg_inp_data_in(reg_inp_data),
	.func3_in(func3),
	.rs1_in(rs1),
	.rs2_in(rs2),
	.rd_in(rd),
	.aluSrc_in(aluSrc),
	.alu_op_in(alu_op),
	.MR_out(MR_ID_EX_out),
	.MW_out(MW_ID_EX_out),
	.MemtoReg_out(MemtoReg_ID_EX_out),
	.regWE_out(regWE_ID_EX_out),
	.beq_out(beq_ID_EX_out),
	.bneq_out(bneq_ID_EX_out),
	.bge_out(bge_ID_EX_out),
	.blt_out(blt_ID_EX_out),
	.jmp_out(jmp_ID_EX_out),
	.jalr_out(jalr_ID_EX_out),
	.opcode_out(opcode_ID_EX_out),
	.func7_out(func7_ID_EX_out),
	.pc_out(pc_ID_EX_out),
	.imm_out(imm_ID_EX_out),
	.rout1_out(rout1_ID_EX_out),
	.rout2_out(rout2_ID_EX_out),
	//.reg_inp_data_out(reg_inp_data_ID_EX_out),
	.func3_out(func3_ID_EX_out),
	.rs1_out(rs1_ID_EX_out),
	.rs2_out(rs2_ID_EX_out),
	.rd_out(rd_ID_EX_out),
	.alu_op_out(alu_op_ID_EX_out),
	.aluSrc_out(aluSrc_ID_EX_out)
);

HDU HDU_inst (
	.rs1(rs1),
	.rs2(rs2),
	.rd(rd_ID_EX_out),
	.MR(MR_ID_EX_out),
	.stall(stall)
);

////////////// EXECUTE STAGE /////////////////

///// ALU /////

//muxing logic 
assign B = (!aluSrc_ID_EX_out ) ? FU_MUX_B : imm_ID_EX_out;

//Instantiation
ALU alu_inst (
	.alu_op(alu_op_ID_EX_out),
	.A(FU_MUX_A),
	.B(B),
	.Result(Result)
);

assign branch_taken = ((beq_ID_EX_out && rout1_ID_EX_out == rout2_ID_EX_out)) 
		       || ((bneq_ID_EX_out && rout1_ID_EX_out != rout2_ID_EX_out))
		       || ((blt_ID_EX_out && $signed(rout1_ID_EX_out) < $signed(rout2_ID_EX_out)))
		       || ((bge_ID_EX_out && $signed(rout1_ID_EX_out) > $signed(rout2_ID_EX_out)));


///// flush /////
flush flush_inst (
	.branch_taken(branch_taken),
	.jmp(jmp_ID_EX_out),
	.flush(flush)
);

//PC branc cal
assign target_branch = pc_ID_EX_out + imm_ID_EX_out;

///// EX_MEM /////
EX_MEM EX_MEM_inst (
	.clk(clk),
	.rst(rst),
	//.flush(flush),
	.MR_in(MR_ID_EX_out),
	.MW_in(MW_ID_EX_out),
	.MemtoReg_in(MemtoReg_ID_EX_out),
	.jmp_in(jmp_ID_EX_out),
	/*.beq_in(beq_ID_EX_out),
	.bneq_in(bneq_ID_EX_out),
	.bge_in(bge_ID_EX_out),
	.blt_in(blt_ID_EX_out),*/
	.regWE_in(regWE_ID_EX_out),
	.rd_in(rd_ID_EX_out),
	.alu_result_in(Result),
	.rout2_in(FU_MUX_B),
	//.reg_inp_data_in(reg_inp_data_ID_EX_out),
	.pc_in(pc_ID_EX_out),
	.MR_out(MR_EX_MEM_out),
	.MW_out(MW_EX_MEM_out),
	.MemtoReg_out(MemtoReg_EX_MEM_out),
	.jmp_out(jmp_EX_MEM_out),
	/*.beq_out(beq_EX_MEM_out),
	.bneq_out(bneq_EX_MEM_out),
	.blt_out(blt_EX_MEM_out),
	.bge_out(bge_EX_MEM_out),*/
	.regWE_out(regWE_EX_MEM_out),
	.rd_out(rd_EX_MEM_out),
	.alu_result_out(alu_result_EX_MEM_out),
	.rout2_out(rout2_EX_MEM_out),
	//.reg_inp_data_out(reg_inp_data_EX_MEM_out),
	.pc_out(pc_EX_MEM_out)
);


////////////// MEMORY STAGE /////////////////

///// data_mem /////
data_mem data_mem_inst (
	.clk(clk),
	.data(rout2_EX_MEM_out),
	.addrs(alu_result_EX_MEM_out),
	.we(MW_EX_MEM_out),
	.re(MR_EX_MEM_out),
	.data_out(read_mem_data)
);

///// MEM_WB /////
MEM_WB MEM_WB_inst (
	.clk(clk),
	.rst(rst),
	.MemtoReg_in(MemtoReg_EX_MEM_out),
	.jmp_in(jmp_EX_MEM_out),
	.regWE_in(regWE_EX_MEM_out),
	.rd_in(rd_EX_MEM_out),
	.alu_result_in(alu_result_EX_MEM_out),
	//.reg_inp_data_in(reg_inp_data_EX_MEM_out),
	.read_mem_data_in(read_mem_data),
	.pc_in(pc_EX_MEM_out),
	.MemtoReg_out(MemtoReg_MEM_WB_out),
	.jmp_out(jmp_MEM_WB_out),
	.regWE_out(regWE_MEM_WB_out),
	.rd_out(rd_MEM_WB_out),
	.alu_result_out(alu_result_MEM_WB_out),
	//.reg_inp_data_out(reg_inp_data_MEM_WB_out),
	.read_mem_data_out(read_mem_data_MEM_WB_out),
	.pc_out(pc_MEM_WB_out)
	
);

////////////// Write Back STAGE /////////////////

///// WB muxing /////
assign reg_inp_data = (jmp_MEM_WB_out) ? pc_MEM_WB_out : 
					 (MemtoReg_MEM_WB_out) ? read_mem_data_MEM_WB_out : 
					  alu_result_MEM_WB_out;

//pls just kill me alr...i am tired of fixing LW and SW, this is my last hope 
// Fowarding Unit
forwardingUnit FU_inst (
	.rs1(rs1_ID_EX_out),
	.rs2(rs2_ID_EX_out),
	.rd_EX_MEM(rd_EX_MEM_out),
	.rd_MEM_WB(rd_MEM_WB_out),
	.regWE_EX_MEM(regWE_EX_MEM_out), 
	.regWE_MEM_WB(regWE_MEM_WB_out),
	.Forward_A(forward_A),
	.Forward_B(forward_B)
);

//FU MUXES ADN THEIR LOGIC
assign FU_MUX_A = (forward_A == 2'b10) ? alu_result_EX_MEM_out:
		  (forward_A == 2'b01) ? reg_inp_data:
		   rout1_ID_EX_out;

assign FU_MUX_B = (forward_B == 2'b10) ? alu_result_EX_MEM_out:
		  (forward_B == 2'b01) ? reg_inp_data:
		   rout2_ID_EX_out;
	
//Debug
always@(posedge clk) begin
if(regWE_MEM_WB_out)
$display("Writing to REG[%0d] = %h", rd_MEM_WB_out, reg_inp_data);
if(MW_EX_MEM_out)
$display("Writing to MEM[%0d] = %h", alu_result_EX_MEM_out, rout2_EX_MEM_out);

 $display("PC: %h, Instruction: %h", pc_out, instr_IF_ID_out);
end

endmodule


