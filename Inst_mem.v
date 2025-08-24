module i_mem(instr, PC);

output reg [31:0] instr;
input [31:0] PC;
//input clk,rst;

reg [31:0]mem[0:2**3-1];



parameter Instr_path = "C:/Users/AK TECHNOLOGY/OneDrive/Documents/inst_C.hex";

initial begin
$readmemh(Instr_path, mem);
	
        //mem[0]  = 32'h00500113;	//ADDI x2, x0, 5
	//mem[1]  = 32'h00000033; //ADDI, x0, x0, 0;
	//mem[2]  = 32'h00000033; //ADDI, x0, x0, 0;
	//mem[1]  = 32'h00212223;	//SW x2, 4(x2)
	//mem[2]  = 32'h00000033; //ADDI, x0, x0, 0;
	//mem[3]  = 32'h00000033; //ADDI, x0, x0, 0;
	//mem[2]  = 32'h00412183; //LW x3, 4(x2)

 $display("Instruction memory initialized with test program");
end

always@(*) 
begin

//if(rst) begin
//instr <= 32'b0;
//PC   <= 10'd0;
//end

 
//instr <= {mem[PC+3], mem[PC+2], mem[PC+1], mem[PC]};
instr <= mem[PC[31:2]];



end
endmodule


