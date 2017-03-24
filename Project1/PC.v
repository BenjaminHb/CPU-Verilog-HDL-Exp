module PC( clk, rst, PCWr, NPC, PC );

	input				clk;
	input				rst;
	input				PCWr;
	input [31:0]		NPC;

	output reg [31:0]	PC;

	reg [31:0]			temp;

	always @(posedge clk or posedge rst) begin
		if ( rst ) 
			PC <= 32'h0000_3000;
		PC = PC + 4;
		if ( PCWr )
			begin
				temp = {NPC[29:0], 2'd0};
				PC = PC + temp;
			end

	end // end always

endmodule
