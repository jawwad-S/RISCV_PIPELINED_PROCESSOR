module ALU (Result, A, B, alu_op);

output reg [31:0] Result;
input [31:0] A,B;
/*input clk;
input rst;*/
input [3:0] alu_op;

//Signed Vars
wire signed A_signed = A;
wire signed B_signed = B;

//FLAGS
wire ZF;

always@(*)
begin
/*if (rst) begin
	Result <= 32'b0;
end
else begin*/
case(alu_op)
	//ADDITION OP
	4'b0000: Result <= A + B;
	//SUBTRACTION OP
	4'b0001: Result <= A - B;
	//MULTIPLICATION OP
	4'b0010: Result <= A * B;
	//DIVISION OP
	4'b0011: Result <= A / B;
	//AND op
	4'b0100: Result <= A & B;
	//OR op
	4'b0101: Result <= A | B;
	//XOR op
	4'b0110: Result <= A ^ B;
	//SLL unsigned
	4'b0111: Result <= A << B[4:0];
	//SLR unsigned
	4'b1000: Result <= A >> B[4:0];
	//EQUAL check
	4'b1001: Result <= (A==B) ? 1:0;
	//LESS than (unsigned)
	4'b1010: Result <= (A<B) ? 1:0;
	//GREATER than or EQUALS to (unsigned)
	4'b1011: Result <= (A>=B)? 1:0;
	//JALR with alignment 
	4'b1100: Result <= (A+B) & 32'hFFFFFFFE;
	//SLR signed
	4'b1101: Result <= A_signed >>> B_signed;
	//Less than (signed)
	4'b1110: Result <= (A_signed < B_signed) ? 1:0;
	//Greater than or EQUALS to (signed)
	4'b1111: Result <= A_signed >= B_signed ? 1:0;
default: Result <= 32'b0;
endcase
end


assign ZF = ~(Result&Result);

endmodule
