module Forward( clk, rst, PCWr, NPC, PC, JUMP ,JUMPAdr);

	input				clk;
	input				rst;
	input				PCWr;
	input [31:0]		NPC;
	input				JUMP;
	input [25:0]		JUMPAdr;

	output reg [31:0]	PC;

	reg [31:0]			temp;

	always @(posedge clk or posedge rst) begin
		if ( rst ) 
			PC <= 32'h0000_3000;
		PC = PC + 4;
		if ( PCWr&&JUMP )		//beq
			begin
				PC = NPC;
			end
		if ( !JUMP&&!PCWr )		//j
			begin
				temp = {PC[31:28], JUMPAdr[25:0], 2'd0};
				PC = temp;
			end
	end // end always

	
	
	
	if (EXMEM_RegWrite && (!EXMEM_RegRd = 0 ) && (EXMEM_RegRd == IDEX_RegRs))
		ForwardA = 10;
	if (EXMEM_RegWrite && (!EXMEM_RegRd = 0 ) && (EXMEM_RegRd == IDEX_RegRt))
		ForwardB = 10;
	if (MEMWB_RegWrite && (!MEMWB_RegRd = 0 ) && !(EXMEM_RegWrite && (EXMEM_RegRd!=0) && (EXMEM_RegRd!=EXMEM_RegRs)) && (MEMWB_RegRd == IDEX_RegRs))
		ForwardA = 01;
	if (MEMWB_RegWrite && (!MEMWB_RegRd = 0 ) && !(EXMEM_RegWrite && (EXMEM_RegRd!=0) && (EXMEM_RegRd!=EXMEM_RegRt)) && (MEMWB_RegRd == IDEX_RegRt))
		ForwardB = 01;
	
	
endmodule