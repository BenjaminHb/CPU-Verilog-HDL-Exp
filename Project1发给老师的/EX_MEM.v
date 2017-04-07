module EX_MEM (clk, rst, EXMEM_InALUResult, EXMEM_InRtData, EXMEM_InRegWriteAdr, 
				EXMEM_InMemWrite, EXMEM_InMemRead, 
				EXMEM_InMemtoReg, EXMEM_InRegWrite, 
				EXMEM_OutALUResult, EXMEM_OutRtData, EXMEM_OutRegWriteAdr, 
				EXMEM_OutMemWrite, EXMEM_OutMemRead, 
				EXMEM_OutMemtoReg, EXMEM_OutRegWrite, 
				EXMEM_WriteEn );

//input
	input				clk;
	input				rst;
	input [31:0]		EXMEM_InALUResult;
	input [31:0]		EXMEM_InRtData;
	input [4:0]			EXMEM_InRegWriteAdr;

////EX_MEX
	input				EXMEM_InMemWrite;		//MemWrite
	input				EXMEM_InMemRead;		//MemRead

////MEM_WB
	input				EXMEM_InMemtoReg;		//MemtoReg
	input				EXMEM_InRegWrite;		//RegWrite

	input				EXMEM_WriteEn;

//output
	output reg [31:0]	EXMEM_OutALUResult;
	output reg [31:0]	EXMEM_OutRtData;
	output reg [4:0]	EXMEM_OutRegWriteAdr;

////EX_MEX
	output reg			EXMEM_OutMemWrite;		//MemWrite
	output reg			EXMEM_OutMemRead;		//MemRead

////MEM_WB
	output reg			EXMEM_OutMemtoReg;		//MemtoReg
	output reg			EXMEM_OutRegWrite;		//RegWrite

	always @(posedge clk or posedge rst) begin
		if ( rst ) begin
			EXMEM_OutALUResult = 32'd0;
			EXMEM_OutRtData = 32'd0;
			EXMEM_OutRegWriteAdr = 5'd0;
			EXMEM_OutMemWrite = 1'd0;
			EXMEM_OutMemRead = 1'd0;
			EXMEM_OutMemtoReg = 1'd0;
			EXMEM_OutRegWrite = 1'd0;
		end	// end if
		else begin
			if ( EXMEM_WriteEn ) begin
				EXMEM_OutALUResult = EXMEM_InALUResult;
				EXMEM_OutRtData = EXMEM_InRtData;
				EXMEM_OutRegWriteAdr = EXMEM_InRegWriteAdr;
				EXMEM_OutMemWrite = EXMEM_InMemWrite;
				EXMEM_OutMemRead = EXMEM_InMemRead;
				EXMEM_OutMemtoReg = EXMEM_InMemtoReg;
				EXMEM_OutRegWrite = EXMEM_InRegWrite;
			end	// end else if
		end	// end else
	end	// end always

endmodule