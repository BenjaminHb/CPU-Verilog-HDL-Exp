module Forward( clk, rst, IDEX_RegRs, IDEX_RegRt, EXMEM_RegRd, EXMEM_RegWrite, MEMWB_RegRd, MEMWB_RegWrite, 
				ForwardA, ForwardB );

	input				clk;
	input				rst;
	input [4:0]			IDEX_RegRs;
	input [4:0]			IDEX_RegRt;
	input [4:0]			EXMEM_RegRd;
	input				EXMEM_RegWrite;
	input [4:0]			MEMWB_RegRd;
	input				MEMWB_RegWrite;

	output reg [1:0]	ForwardA;
	output reg [1:0]	ForwardB;

	initial begin
		ForwardA = 2'd0;
		ForwardB = 2'd0;
	end

	always @(posedge clk or posedge rst) begin
		if (EXMEM_RegWrite && (EXMEM_RegRd != 0 ) && ((EXMEM_RegRd == IDEX_RegRs)||(EXMEM_RegRd == IDEX_RegRt))) begin
			if (EXMEM_RegRd == IDEX_RegRs)
				ForwardA = 10;
			if (EXMEM_RegRd == IDEX_RegRt)
				ForwardB = 10;
		end // end if
		else begin
			if (MEMWB_RegWrite && (MEMWB_RegRd != 0 ) && ((!(EXMEM_RegWrite && (EXMEM_RegRd != 0) && (EXMEM_RegRd != IDEX_RegRs)) && (MEMWB_RegRd == IDEX_RegRs))
														||(!(EXMEM_RegWrite && (EXMEM_RegRd != 0) && (EXMEM_RegRd != IDEX_RegRt)) && (MEMWB_RegRd == IDEX_RegRt)))) 
			begin
				if (MEMWB_RegWrite && (MEMWB_RegRd != 0 ) && !(EXMEM_RegWrite && (EXMEM_RegRd != 0) && (EXMEM_RegRd != IDEX_RegRs)) && (MEMWB_RegRd == IDEX_RegRs))
					ForwardA = 01;
				if (MEMWB_RegWrite && (MEMWB_RegRd != 0 ) && !(EXMEM_RegWrite && (EXMEM_RegRd != 0) && (EXMEM_RegRd != IDEX_RegRt)) && (MEMWB_RegRd == IDEX_RegRt))
					ForwardB = 01;
			end // end else if
			else begin
				ForwardA = 2'd0;
				ForwardB = 2'd0;
			end // end else else
		end // end else
	end // end always

endmodule