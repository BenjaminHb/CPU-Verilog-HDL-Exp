module MEM_WB (clk, rst, MEMWB_InMemReadData, MEMWB_InALUResult, MEMWB_InRegWriteAdr, 
				MEMWB_InMemtoReg, MEMWB_InRegWrite, 
				MEMWB_OutMemReadData, MEMWB_OutALUResult, MEMWB_OutRegWriteAdr, 
				MEMWB_OutMemtoReg, MEMWB_OutRegWrite, 
				MEMWB_WriteEn );

//input
	input				clk;
	input				rst;
	input [31:0]		MEMWB_InMemReadData;
	input [31:0]		MEMWB_InALUResult;
	input [4:0]			MEMWB_InRegWriteAdr;

////MEM_WB
	input				MEMWB_InMemtoReg;		//MemtoReg
	input				MEMWB_InRegWrite;		//RegWrite

	input				MEMWB_WriteEn;

//output
	output reg [31:0]	MEMWB_OutMemReadData;
	output reg [31:0]	MEMWB_OutALUResult;
	output reg [4:0]	MEMWB_OutRegWriteAdr;

////MEM_WB
	output reg			MEMWB_OutMemtoReg;		//MemtoReg
	output reg			MEMWB_OutRegWrite;		//RegWrite

	always @(posedge clk or posedge rst) begin
		if ( rst ) begin
			MEMWB_OutMemReadData = 32'd0;
			MEMWB_OutALUResult = 32'd0;
			MEMWB_OutRegWriteAdr = 5'd0;
			MEMWB_OutMemtoReg = 1'd0;
			MEMWB_OutRegWrite = 1'd0;
		end	// end if
		else begin
			if ( MEMWB_WriteEn ) begin
				MEMWB_OutMemReadData = MEMWB_InMemReadData;
				MEMWB_OutALUResult = MEMWB_InALUResult;
				MEMWB_OutRegWriteAdr = MEMWB_InRegWriteAdr;
				MEMWB_OutMemtoReg = MEMWB_InMemtoReg;
				MEMWB_OutRegWrite = MEMWB_InRegWrite;
			end	// end else if
		end	// end else
	end	// end always

endmodule