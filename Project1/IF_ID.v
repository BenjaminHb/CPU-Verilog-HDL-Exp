module IF_ID (clk, rst, IFID_InPC, IFID_InOpCode, IFID_OutPC, IFID_OutOpCode ,IFID_WriteEn, IFID_BeqFlush );

//input
	input				clk;
	input				rst;
	input [31:0]		IFID_InPC;
	input [31:0]		IFID_InOpCode;
	input 				IFID_WriteEn;
	input				IFID_BeqFlush;

//output
	output reg [31:0]	IFID_OutPC;
	output reg [31:0]	IFID_OutOpCode;

	always @(posedge clk or posedge rst) begin
		if ( rst || IFID_BeqFlush) begin
			IFID_OutPC = 32'd0;
			IFID_OutOpCode = 32'd0;
		end	// end if
		else begin
			if ( IFID_WriteEn ) begin
				IFID_OutPC = IFID_InPC;
				IFID_OutOpCode = IFID_InOpCode;
			end	// end else if
		end	// end else
	end	// end always

endmodule
