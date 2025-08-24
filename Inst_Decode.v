module inst_decode(opcode,imm,func3,func7,rs1,rs2,rd,instr);

output reg[31:0] imm;
output reg[6:0] opcode, func7;
output reg[2:0] func3;
output reg[4:0] rs1,rs2,rd;
input [31:0] instr;
//input clk,rst;

always @ (*) begin
/*if(rst) begin
opcode = 7'd0;
func3 = 3'd0;
func7 = 7'd0;
rs1  = 5'd0;
rs2 = 5'd0;
rd = 5'd0;
imm = 20'd0;
end

else begin*/
// R TYPE
opcode = instr[6:0];

/*func3  = instr[14:12];
func7  = instr[31:25];
rs1    = instr[19:15];
rs2    = instr[24:20];
rd     = instr[11:7];*/
//FOR REST OF TYPES, WE USE OPCODE

case(opcode)

7'b0110011: begin  //R TYPE

opcode = instr[6:0];
func3  = instr[14:12];
func7  = instr[31:25];
rs1    = instr[19:15];
rs2    = instr[24:20];
rd     = instr[11:7];

end

7'b0010011, 7'b0000011,7'b1100111: begin // I TYPE

func3 = instr[14:12];
imm   = {{20{instr[31]}},instr[31:20]};
rs1   = instr[19:15];
rd    = instr[11:7];

end

7'b0100011: begin	//S TYPE

func3 = instr[14:12];
imm   = {{20{instr[31]}},instr[31:25], instr[11:7]};
rs1   = instr[19:15];
rs2   = instr[24:20];
rd    = 5'bxxxxx;

$display("rs1 is: %b", rs1);

end

7'b1100011: begin 	//B TYPE

func3 = instr[14:12];
imm   = {{19{instr[31]}},instr[31] ,instr[30:25], instr[11:8], instr[7], 1'b0};
rs1   = instr[19:15];
rs2   = instr[24:20];
//rd    = instr[11:7];

end

7'b0010111 : begin  	//U TYPE

//func3 = instr[14:12];
imm   = {{20{instr[31]}},instr[31:12]}; //extension required to make32 bits
//rs1   = instr[19:15];
//rs2   = instr[24:20];
rd    = instr[11:7];

end
 //J TYPE
7'b1101111: begin //JAL

//func3 = instr[14:12];
imm   = {{12{instr[31]}},instr[31], instr[30:21], instr[20], instr[19:12]}; //extension to 32 bits
//rs1   = instr[19:15];
//rs2   = instr[24:20];
rd    = instr[11:7];

end

endcase

end
endmodule


