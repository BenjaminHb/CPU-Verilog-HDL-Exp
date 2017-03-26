module ID_EX (clk, rst, IDEX_InPC, IDEX_InReadData1, IDEX_InReadData2, IDEX_InImm32, IDEX_InRt, IDEX_InRd, 
				IDEX_InALUSrc, IDEX_InALUCtrl, IDEX_InRegDst, IDEX_InJump, 
				IDEX_InBranch, IDEX_InMemWrite, IDEX_InMemRead, 
				IDEX_InMemtoReg, IDEX_InRegWrite, 
				IDEX_OutPC, IDEX_OutReadData1, IDEX_OutReadData2, IDEX_OutImm32, IDEX_OutRt, IDEX_OutRd, 
				IDEX_OutALUSrc, IDEX_OutALUCtrl, IDEX_OutRegDst, IDEX_OutJump, 
				IDEX_OutBranch, IDEX_OutMemWrite, IDEX_OutMemRead, 
				IDEX_OutMemtoReg, IDEX_OutRegWrite, 
				IDEX_WriteEn );

//input
	input				clk;
	input				rst;
	input [31:0]		IDEX_InPC;
	input [31:0]		IDEX_InReadData1;
	input [31:0]		IDEX_InReadData2;
	input [31:0]		IDEX_InImm32;
	input [4:0]			IDEX_InRt;
	input [4:0]			IDEX_InRd;

////ID_EX
	input				IDEX_InALUSrc;			//ALUSrc
	input [2:0]			IDEX_InALUCtrl;			//ALUCtrl
	input				IDEX_InRegDst;			//RegDst
	input				IDEX_InJump;			//Jump

////EX_MEX
	input				IDEX_InBranch;			//Branch
	input				IDEX_InMemWrite;		//MemWrite
	input				IDEX_InMemRead;			//MemRead

////MEM_WB
	input				IDEX_InMemtoReg;		//MemtoReg
	input				IDEX_InRegWrite;		//RegWrite

	input				IDEX_WriteEn;

//output
	output reg [31:0]	IDEX_OutPC;
	output reg [31:0]	IDEX_OutReadData1;
	output reg [31:0]	IDEX_OutReadData2;
	output reg [31:0]	IDEX_OutImm32;
	output reg [4:0]	IDEX_OutRt;
	output reg [4:0]	IDEX_OutRd;

////ID_EX
	output reg			IDEX_OutALUSrc;			//ALUSrc
	output reg [2:0]	IDEX_OutALUCtrl;		//ALUCtrl
	output reg			IDEX_OutRegDst;			//RegDst
	output reg			IDEX_OutJump;			//Jump

////EX_MEX
	output reg			IDEX_OutBranch;			//Branch
	output reg			IDEX_OutMemWrite;		//MemWrite
	output reg			IDEX_OutMemRead;		//MemRead

////MEM_WB
	output reg			IDEX_OutMemtoReg;		//MemtoReg
	output reg			IDEX_OutRegWrite;		//RegWrite

	always @(posedge clk or posedge rst) begin
		if ( rst ) begin
			IDEX_OutPC = 32'd0;
			IDEX_OutReadData1 = 32'd0;
			IDEX_OutReadData2 = 32'd0;
			IDEX_OutImm32 = 32'd0;
			IDEX_OutRt = 5'd0;
			IDEX_OutRd = 5'd0;
			IDEX_OutALUSrc = 1'd0;
			IDEX_OutALUCtrl = 3'd0;
			IDEX_OutRegDst = 1'd0;
			IDEX_OutJump = 1'd0;
			IDEX_OutBranch = 1'd0;
			IDEX_OutMemWrite = 1'd0;
			IDEX_OutMemRead = 1'd0;
			IDEX_OutMemtoReg = 1'd0;
			IDEX_OutRegWrite = 1'd0;
		end	// end if
		else begin
			if ( IDEX_WriteEn ) begin
				IDEX_OutPC = IDEX_InPC;
				IDEX_OutReadData1 = IDEX_InReadData1;
				IDEX_OutReadData2 = IDEX_InReadData2;
				IDEX_OutImm32 = IDEX_InImm32;
				IDEX_OutRt = IDEX_InRt;
				IDEX_OutRd = IDEX_InRd;
				IDEX_OutALUSrc = IDEX_InALUSrc;
				IDEX_OutALUCtrl = IDEX_InALUCtrl;
				IDEX_OutRegDst = IDEX_InRegDst;
				IDEX_OutJump = IDEX_InJump;
				IDEX_OutBranch = IDEX_InBranch;
				IDEX_OutMemWrite = IDEX_InMemWrite;
				IDEX_OutMemRead = IDEX_InMemRead;
				IDEX_OutMemtoReg = IDEX_InMemtoReg;
				IDEX_OutRegWrite = IDEX_InRegWrite;
			end	// end else if
		end	// end else
	end	// end always

endmodule