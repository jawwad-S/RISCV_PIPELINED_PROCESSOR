module flush (branch_taken, jmp, flush);


input branch_taken, jmp;
output flush;

assign flush = branch_taken || jmp;

endmodule
