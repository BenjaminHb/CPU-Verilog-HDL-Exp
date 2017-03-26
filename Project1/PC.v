module PC( clk, rst, PCWr, NPC, PC, JUMP ,JUMPAdr);

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

endmodule