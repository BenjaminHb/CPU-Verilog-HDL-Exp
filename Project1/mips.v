module mips( clk, rst );

	input   clk;
	input   rst;

//PC
	wire [31:0]	pcOut;		//PC.PC

//IM
	wire [11:0]	imAdr;		//im.addr
	wire [31:0]	opCode;		//im.dout

//RF
	wire [4:0]	rfWriteAdr,rfReadAdr1,rfReadAdr2;	//rf.A3 rf.A1 rf.A2
	wire [31:0]	rfDataIn;							//rf.WD
	wire [31:0]	rfDataOut1,rfDataOut2;				//rf.RD1 rf.RD2

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


	assign pcWrite = ((Branch&&zero)==1)?1:0;
//PC实例化
	PC U_PC(.clk(clk), .rst(rst), .PCWr(pcWrite), .NPC(extDataOut), .PC(pcOut));

	assign imAdr = pcOut[11:0];
//im指令寄存器实例化
	im_4k U_im(.addr(imAdr), .dout(opCode));

	assign op = opCode[31:26];
	assign funct = opCode[5:0];
	assign rfReadAdr1 = opCode[25:21];
	assign rfReadAdr2 = opCode[20:16];
	assign rfWriteAdr = (RegDst==1)?opCode[20:16]:opCode[15:11];

	assign extDataIn = opCode[15:0];
//RF寄存器堆实例化
	RF U_RF(.A1(rfReadAdr1), .A2(rfReadAdr2), .A3(rfWriteAdr), .WD(rfDataIn)
			, .clk(clk), .RFWr(RegWriteEn), .RD1(rfDataOut1), .RD2(rfDataOut2));

//Ctrl控制器实例化
	Ctrl U_Ctrl(.jump(jump),.RegDst(RegDst),.Branch(Branch),.MemR(MemR),.Mem2R(Mem2R)
				,.MemW(MemWrite),.RegW(RegWriteEn),.Alusrc(Alusrc),.ExtOp(ExtOp),.Aluctrl(Aluctrl)
				,.OpCode(op),.funct(funct));

//EXT扩展器实例化
	EXT U_EXT(.Imm16(extDataIn), .EXTOp(ExtOp), .Imm32(extDataOut));

	assign aluDataIn2 = (Alusrc==1)?extDataOut:rfDataOut2;
//alu实例化
	alu U_alu(.A(rfDataOut1), .B(aluDataIn2), .ALUOp(Aluctrl), .C(aluDataOut), .Zero(zero));

	assign dmDataAdr = aluDataOut[11:0];
//dm实例化
	dm_4k U_dm(.addr(dmDataAdr), .din(rfDataOut2), .DMWr(MemWrite), .clk(clk), .dout(dmDataOut));

endmodule