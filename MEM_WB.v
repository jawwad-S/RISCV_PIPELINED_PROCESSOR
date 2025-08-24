module MEM_WB (

input clk, rst, MemtoReg_in, jmp_in, regWE_in,
input [4:0] rd_in,
input [31:0] alu_result_in, read_mem_data_in, pc_in,

output reg MemtoReg_out, jmp_out, regWE_out,
output reg [4:0] rd_out,
output reg [31:0] alu_result_out, read_mem_data_out, pc_out
);

always@(posedge clk or posedge rst) begin
if(rst) begin
	 MemtoReg_out <= 0;
	 regWE_out <= 0;
	 jmp_out <= 0;
	 rd_out <= 0; 
	 alu_result_out <= 0; 
         read_mem_data_out <= 0;
	 pc_out <= 0;
end

else begin
	 MemtoReg_out <= MemtoReg_in;
	 jmp_out <= jmp_in;
	 regWE_out <= regWE_in;
	 rd_out <= rd_in; 
	 alu_result_out <= alu_result_in; 
	 read_mem_data_out <= read_mem_data_in;
	 pc_out <= pc_in;
     end 
  end
endmodule


