module mips_tb();

	reg clk, rst;

	mips U_mips(.clk(clk), .rst(rst));

	initial begin
		$readmemh( "Test.txt" , U_mips.U_im.imem );
		$monitor("PC = 0x%8X, IR = 0x%8X", U_mips.U_PC.PC, U_mips.opCode ); 
		clk = 1 ;
		rst = 0 ;
		#5 ;
		rst = 1 ;
		#20 ;
		rst = 0 ;
	end
	
	always
		#(50) clk = ~clk;

endmodule
