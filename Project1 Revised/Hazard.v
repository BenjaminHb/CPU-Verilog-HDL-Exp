module Hazard( clk, rst, IDEX_MemRead, IDEX_RegRt, IFID_RegRs, IFID_RegRt, 
				IDEX_Flush, IFID_Write, PC_Write );

	input		clk;
	input		rst;
	input		IDEX_MemRead;
	input [4:0]	IDEX_RegRt;
	input [4:0]	IFID_RegRs;
	input [4:0]	IFID_RegRt;

	output reg	IDEX_Flush;
	output reg	IFID_Write;
	output reg	PC_Write;

	initial begin
		IDEX_Flush = 0;
		IFID_Write = 1;
		PC_Write = 1;
	end

	always @(posedge clk or posedge rst) begin
		if (IDEX_MemRead && ((IDEX_RegRt == IFID_RegRs) || (IDEX_RegRt == IFID_RegRt))) begin
			IDEX_Flush = 1;
			IFID_Write = 0;
			PC_Write = 0;
		end
		else begin
			IDEX_Flush = 0;
			IFID_Write = 1;
			PC_Write = 1;
		end // end else
	end // end always

endmodule