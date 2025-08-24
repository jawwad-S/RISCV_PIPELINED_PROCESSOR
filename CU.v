module CU (stall, alu_op,MR,MW,jmp, jalr/*regSEL,immSEL*/,regWE,/*inst,pcSEL,rs1SEL,rs2SEL,clk,rst,*/beq, bneq, bge, blt, opcode, func3, func7, MemtoReg, aluSrc);

//input [31:0]inst;
input [6:0] opcode, func7;
input [2:0] func3;
input stall;
//input clk,rst;

//output reg[4:0] regSEL, rs1SEL, rs2SEL;
output reg[3:0]alu_op;
output reg MR, MW, regWE,beq, bneq, bge, blt, jmp, jalr/*pcSEL, regSEL, rs1SEL, rs2SEL*/, MemtoReg,aluSrc;
//output reg [2:0] immSEL;

/*wire [6:0]opcode,func7;
wire [2:0] func3;

assign opcode = inst[6:0];
assign func3 = inst[14:12];
assign func7 = inst[31:25];*/

initial
begin
	alu_op = 4'b0000;
		//func3 = 3'b000;
	MR = 1'b0;
	MW = 1'b0;
	beq  = 1'b0;
	bneq = 1'b0;
	bge  = 1'b0;
	blt  = 1'b0; 	
	jmp  = 1'b0;
	jalr = 1'b0;
	aluSrc = 1'b0;
	MemtoReg = 1'b0;
end

always @(*)
begin
case(opcode) 

// R TYPE INSTRUCTIONS
7'b0110011:
case(func3)
3'b0: begin 
if(func7==7'b0000000) begin	//ADD	
alu_op <= 4'b0000;
regWE  <= 1'b1;
//MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;  end 

else if(func7==7'b0000010) begin	//SUB	
alu_op <= 4'b0001;
regWE  <= 1'b1;
//MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;  end 

end
3'b100: begin //XOR
alu_op <= 4'b0110;
regWE  <= 1'b1;
//MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;
end
3'b110: begin //OR
alu_op <= 4'b0101;
regWE  <= 1'b1;
//MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0; 
end
3'b111: begin //AND
alu_op <= 4'b0100;
regWE  <= 1'b1;
//MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;
end
3'b001: begin //SLL
alu_op <= 4'b0111;
regWE  <= 1'b1;
//MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;
end
3'b101: begin //SRL
alu_op <= 4'b1000;
regWE  <= 1'b1;
//MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;
end
/*3'b110: begin //XOR
alu_op <= 4'b0000;
regWE  <= 1'b1;
MemtoReg <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;
end*/
endcase// end of case3

//B TYPE INSTRUCTIONS
7'b1100011: 
case(func3) 
3'b0: begin // BEQ
alu_op <= 4'b1001;
regWE  <= 1'b0;
//MemtoReg <= 1'bx;
MR <= 1'b0;
MW <= 1'b0;
	beq  = 1'b1;
	bneq = 1'b0;
	bge  = 1'b0;
	blt  = 1'b0;
end
3'b001: begin // BNEQ
alu_op <= 4'b1001;
regWE  <= 1'b0;
//MemtoReg <= 1'bx;
MR <= 1'b0;
MW <= 1'b0;
	beq  = 1'b0;
	bneq = 1'b1;
	bge  = 1'b0;
	blt  = 1'b0;
end
3'b100: begin //BLT
alu_op <= 4'b1010;
regWE  <= 1'b0;
//MemtoReg <= 1'bx;
MR <= 1'b0;
MW <= 1'b0;
	beq  = 1'b0;
	bneq = 1'b0;
	bge  = 1'b0;
	blt  = 1'b1;
end
3'b101: begin //BGE
alu_op <= 4'b1011;
regWE  <= 1'b0;
//MemtoReg <= 1'bx;
MR <= 1'b0;
MW <= 1'b0;
	beq  = 1'b0;
	bneq = 1'b0;
	bge  = 1'b1;
	blt  = 1'b0;
end
endcase //end of case func3

//I TYPE INSTRCTIONS
7'b1100111:
case(func3)
3'b0: begin		//jalr
alu_op <= 4'b0000;
regWE  <= 1'b1;
jmp <= 1'b0;
MR <= 1'b0;
MW <= 1'b0;
jalr <= 1'b1;
end
endcase //end of case func3

7'b0010011: begin
aluSrc <= 1'b1;
case(func3)
3'b0: begin	//ADDI
alu_op <= 4'b0000;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end

3'b100: begin	//XORI
alu_op <= 4'b0110;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end

3'b110: begin	//OR_I
alu_op <= 4'b0101;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end

3'b111: begin	//AND_I
alu_op <= 4'b0100;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end

3'b001: begin    // SLL_I
alu_op <= 4'b0111;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end

3'b101: begin	//SRL_I
alu_op <= 4'b1000;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end

3'b010: begin	//SLT_I
alu_op <= 4'b1110;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end
endcase //end of case func3
end

7'b0000011: begin
aluSrc <= 1'b1;
case(func3)
3'b0: begin	//LB
alu_op <= 4'b0000;
regWE  <= 1'b1;
MemtoReg <= 1'b1;
MR <= 1'b1;
MW <= 1'b0;
end

3'b001: begin	//LH
alu_op <= 4'b0000;
regWE  <= 1'b1;
MemtoReg <= 1'b1;
MR <= 1'b1;
MW <= 1'b0;
end

3'b010: begin	//LW
alu_op <= 4'b0000;
regWE  <= 1'b1;
MemtoReg <= 1'b1;
MR <= 1'b1;
MW <= 1'b0;
end
endcase //end of case func3
end


//S TYPE INSTRUCTIONS
7'b0100011: begin
aluSrc <= 1'b1;
case(func3)
3'b0: begin	//SB
alu_op <= 4'b0000;
regWE  <= 1'b0;
MR <= 1'b0;
MW <= 1'b1;
end

3'b001: begin	//SH
alu_op <= 4'b0000;
regWE  <= 1'b0;
MR <= 1'b0;
MW <= 1'b1;
end

3'b010: begin	//SW
alu_op <= 4'b0000;
regWE  <= 1'b0;
MR <= 1'b0;
MW <= 1'b1;
end
endcase //end of case func3
end



//J TYPE INSTRUCTION
7'b1101111: 	begin  //JAL
alu_op <= 4'b0000;
regWE  <= 1'b1;
jmp <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
jalr <= 1'b0;
end



//U TYPE INSTRUCTION
7'b0110111: begin 	//LUI
alu_op <= 4'b0000;
regWE  <= 1'b1;
MR <= 1'b0;
MW <= 1'b0;
end
endcase //end of case opcode

if(stall) begin
	alu_op = 4'b0000;
 	MR = 1'b0;
	MW = 1'b0;
	regWE = 1'b0;
	beq = 1'b0;
	bneq = 1'b0;
	bge = 1'b0;
	blt = 1'b0;
	jmp = 1'b0;
	MemtoReg = 1'b0;
	aluSrc = 1'b0;
end


end //end of always
endmodule

