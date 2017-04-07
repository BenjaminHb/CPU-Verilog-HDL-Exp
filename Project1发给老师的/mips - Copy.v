module mips( clk, rst );

	input   clk;
	input   rst;

//PC
	wire [31:0]	pcOut;		//PC.PC
	wire [25:0]	jumpAdr;	//PC.jumpAdr
	wire [31:0]	npc;		//PC.NPC

//IM
	wire [11:0]	imAdr;		//im.addr
	wire [31:0]	opCode;		//im.dout

//RF
	wire [4:0]	rfWriteAdr,rfReadAdr1,rfReadAdr2;	//rf.A3 rf.A1 rf.A2
	wire [31:0]	rfDataIn;							//rf.WD
	wire [31:0]	rfDataOut1,rfDataOut2;				//rf.RD1 rf.RD2
	wire		rfReadEn;							//rf.ReadEnable

//EXT
	wire [15:0]	extDataIn;	//EXT.Imm16
	wire [31:0]	extDataOut;	//EXT.Imm32

//dm
	wire [11:0]	dmDataAdr;	//dm.addr
	wire [31:0]	dmDataOut;	//dm.dout

//Ctrl
	wire [5:0]	op;
	wire [5:0]	funct;
	wire		jump;		//指令跳转
	wire		RegDst;		//寄存器写地址选择
	wire		Branch;		//分支
	wire		MemR;		//读存储器
	wire		Mem2R;		//数据存储器到寄存器堆
	wire		MemWrite;	//写数据存储器
	wire		RegWriteEn;	//寄存器堆写入数据
	wire		Alusrc;		//运算器操作数选择
	wire [1:0]	ExtOp;		//位扩展/符号扩展选择
	wire [2:0]	Aluctrl;	//Alu运算选择

//alu
	wire [31:0]	aluDataIn2;	//alu.B
	wire [31:0]	aluDataOut;	//alu.C
	wire		zero;		//alu.Zero

//mux4_1
	wire [31:0]	mux4_1_out;	//mux4_1.y

//mux4_2
	wire [31:0]	mux4_2_out;	//mux4_2.y

//Forward
	wire [1:0]	forwardA;	//Forward.ForwardA
	wire [1:0]	forwardB;	//Forward.ForwardB

//Hazard
	wire		IDEX_flush;	//Hazard.IDEX_Flush
	wire		IFID_write;	//Hazard.IFID_Write
	wire		PC_write;	//Hazard.PC_Write

//IF_ID
	wire [31:0]	IFID_outOpCode;
	wire [31:0]	IFID_outPC;

//ID_EX
	wire [31:0]	IDEX_outPC;
	wire [31:0]	IDEX_outReadData1;
	wire [31:0]	IDEX_outReadData2;
	wire [31:0]	IDEX_outImm32;
	wire [4:0]	IDEX_outRs;
	wire [4:0]	IDEX_outRt;
	wire [4:0]	IDEX_outRd;
	wire		IDEX_outALUSrc; 
	wire [2:0]	IDEX_outALUCtrl;
	wire		IDEX_outRegDst;
	wire		IDEX_outBranch;
	wire		IDEX_outMemWrite;
	wire		IDEX_outMemRead;
	wire		IDEX_outMemtoReg;
	wire		IDEX_outRegWrite;

//EX_MEM
	wire [31:0]	EXMEM_outALUResult;
	wire [31:0]	EXMEM_outRtData;
	wire [4:0]	EXMEM_outRegWriteAdr;
	wire		EXMEM_outMemWrite;
	wire		EXMEM_outMemRead;
	wire		EXMEM_outMemtoReg;
	wire		EXMEM_outRegWrite;

//MEM_WB
	wire [31:0]	MEMWB_outMemReadData;
	wire [31:0]	MEMWB_outALUResult;
	wire [4:0]	MEMWB_outRegWriteAdr;
	wire		MEMWB_outMemtoReg;
	wire		MEMWB_outRegWrite;


	assign pcWrite = ((IDEX_outBranch&&zero)==1)?1:0;
	assign npc = IDEX_outPC + {IDEX_outImm32[29:0], 2'd0};
//PC实例化
	PC U_PC(.clk(clk), .rst(rst), .PCWr(pcWrite), .NPC(npc), .PC(pcOut), .JUMP(jump), .JUMPAdr(jumpAdr), .PCWriteEn(PC_write));

	assign imAdr = pcOut[13:2];
//im指令寄存器实例化
	im_4k U_im(.addr(imAdr), .dout(opCode));

	assign op = IFID_outOpCode[31:26];
	assign funct = IFID_outOpCode[5:0];
	assign jumpAdr = IFID_outOpCode[25:0];
	assign rfReadAdr1 = IFID_outOpCode[25:21];
	assign rfReadAdr2 = IFID_outOpCode[20:16];
	assign rfWriteAdr = (IDEX_outRegDst==0)?IDEX_outRt:IDEX_outRd;

	assign rfReadEn = (op == 15)?0:1;
	assign rfDataIn = (MEMWB_outMemtoReg==1)?MEMWB_outMemReadData:MEMWB_outALUResult;
	assign extDataIn = IFID_outOpCode[15:0];
//RF寄存器堆实例化
	RF U_RF(.A1(rfReadAdr1), .A2(rfReadAdr2), .A3(MEMWB_outRegWriteAdr), .WD(rfDataIn)
			, .clk(clk), .RFWr(MEMWB_outRegWrite), .RD1(rfDataOut1), .RD2(rfDataOut2), .ReadEnable(rfReadEn));

//Ctrl控制器实例化
	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemWrite),.RegW(RegWriteEn),.Alusrc(Alusrc),.ExtOp(ExtOp),.Aluctrl(Aluctrl)
				,.OpCode(op),.funct(funct));

//EXT扩展器实例化
	EXT U_EXT(.Imm16(extDataIn), .EXTOp(ExtOp), .Imm32(extDataOut));

	assign aluDataIn2 = (IDEX_outALUSrc==1)?IDEX_outImm32:mux4_2_out;
//alu实例化
	alu U_alu(.A(mux4_1_out), .B(aluDataIn2), .ALUOp(IDEX_outALUCtrl), .C(aluDataOut), .Zero(zero));

	assign dmDataAdr = EXMEM_outALUResult[11:2];
//dm实例化
	dm_4k U_dm(.addr(dmDataAdr), .din(EXMEM_outRtData), .DMWr(EXMEM_outMemWrite), .clk(clk), .dout(dmDataOut));


//*****************************************************//

//mux4_1实例化
	mux4 U_mux4_1(.d0(IDEX_outReadData1), .d1(rfDataIn), .d2(EXMEM_outALUResult), .s(forwardA), .y(mux4_1_out));

//mux4_2实例化
	mux4 U_mux4_2(.d0(IDEX_outReadData2), .d1(rfDataIn), .d2(EXMEM_outALUResult), .s(forwardB), .y(mux4_2_out));

//Forward实例化
	Forward U_Forward(.clk(clk), .rst(rst), .IDEX_RegRs(IDEX_outRs), .IDEX_RegRt(IDEX_outRt), .EXMEM_RegRd(EXMEM_outRegWriteAdr), .EXMEM_RegWrite(EXMEM_outRegWrite), .MEMWB_RegRd(MEMWB_outRegWriteAdr), .MEMWB_RegWrite(MEMWB_outRegWrite), 
						.ForwardA(forwardA), .ForwardB(forwardB) );

//Hazard实例化
	Hazard U_Hazard(.clk(clk), .rst(rst), .IDEX_MemRead(IDEX_outMemRead), .IDEX_RegRt(IDEX_outRt), .IFID_RegRs(rfReadAdr1), .IFID_RegRt(rfReadAdr2), 
				.IDEX_Flush(IDEX_flush), .IFID_Write(IFID_write), .PC_Write(PC_write) );





//*****************************************************//

//IF_ID实例化
	IF_ID U_IF_ID(.clk(clk), .rst(rst), .IFID_InPC(pcOut), .IFID_InOpCode(opCode), .IFID_OutPC(IFID_outPC), .IFID_OutOpCode(IFID_outOpCode) ,.IFID_WriteEn(IFID_write));

//ID_EX实例化
	ID_EX U_ID_EX(.clk(clk), .rst(rst), .IDEX_InPC(IFID_outPC), .IDEX_InReadData1(rfDataOut1), .IDEX_InReadData2(rfDataOut2), .IDEX_InImm32(extDataOut), .IDEX_InRs(rfReadAdr1), .IDEX_InRt(rfReadAdr2), .IDEX_InRd(IFID_outOpCode[15:11]), 
					.IDEX_InALUSrc(Alusrc), .IDEX_InALUCtrl(Aluctrl), .IDEX_InRegDst(RegDst), 
					.IDEX_InBranch(Branch), .IDEX_InMemWrite(MemWrite), .IDEX_InMemRead(MemR), 
					.IDEX_InMemtoReg(Mem2R), .IDEX_InRegWrite(RegWriteEn), 
					.IDEX_OutPC(IDEX_outPC), .IDEX_OutReadData1(IDEX_outReadData1), .IDEX_OutReadData2(IDEX_outReadData2), .IDEX_OutImm32(IDEX_outImm32), .IDEX_OutRs(IDEX_outRs), .IDEX_OutRt(IDEX_outRt), .IDEX_OutRd(IDEX_outRd), 
					.IDEX_OutALUSrc(IDEX_outALUSrc), .IDEX_OutALUCtrl(IDEX_outALUCtrl), .IDEX_OutRegDst(IDEX_outRegDst), 
					.IDEX_OutBranch(IDEX_outBranch), .IDEX_OutMemWrite(IDEX_outMemWrite), .IDEX_OutMemRead(IDEX_outMemRead), 
					.IDEX_OutMemtoReg(IDEX_outMemtoReg), .IDEX_OutRegWrite(IDEX_outRegWrite), 
					.IDEX_WriteEn(1), .IDEX_CtrlFlush(IDEX_flush) );

//EX_MEM实例化
	EX_MEM U_EX_MEM(.clk(clk), .rst(rst), .EXMEM_InALUResult(aluDataOut), .EXMEM_InRtData(IDEX_outReadData2), .EXMEM_InRegWriteAdr(rfWriteAdr), 
					.EXMEM_InMemWrite(IDEX_outMemWrite), .EXMEM_InMemRead(IDEX_outMemRead), 
					.EXMEM_InMemtoReg(IDEX_outMemtoReg), .EXMEM_InRegWrite(IDEX_outRegWrite), 
					.EXMEM_OutALUResult(EXMEM_outALUResult), .EXMEM_OutRtData(EXMEM_outRtData), .EXMEM_OutRegWriteAdr(EXMEM_outRegWriteAdr), 
					.EXMEM_OutMemWrite(EXMEM_outMemWrite), .EXMEM_OutMemRead(EXMEM_outMemRead), 
					.EXMEM_OutMemtoReg(EXMEM_outMemtoReg), .EXMEM_OutRegWrite(EXMEM_outRegWrite), 
					.EXMEM_WriteEn(1) );

//MEM_WB实例化
	MEM_WB U_MEM_WB(.clk(clk), .rst(rst), .MEMWB_InMemReadData(dmDataOut), .MEMWB_InALUResult(EXMEM_outALUResult), .MEMWB_InRegWriteAdr(EXMEM_outRegWriteAdr), 
					.MEMWB_InMemtoReg(EXMEM_outMemtoReg), .MEMWB_InRegWrite(EXMEM_outRegWrite), 
					.MEMWB_OutMemReadData(MEMWB_outMemReadData), .MEMWB_OutALUResult(MEMWB_outALUResult), .MEMWB_OutRegWriteAdr(MEMWB_outRegWriteAdr), 
					.MEMWB_OutMemtoReg(MEMWB_outMemtoReg), .MEMWB_OutRegWrite(MEMWB_outRegWrite), 
					.MEMWB_WriteEn(1) );

endmodule