

module Alu(AluResult,Zero,DataIn1,DataIn2,AluCtrl);

	input  [31:0] 		DataIn1;		//运算数据1
	input  [31:0]		DataIn2;		//运算数据2
	input  [1:0]		AluCtrl;		//运算器控制信号
	
	output reg[31:0]		AluResult;		//运算器输出结果
	output reg				Zero;			//结果是否为零
	
	initial								//初始化数据
	begin
		Zero = 0;
		AluResult = 0;
	end	
	
	always@(DataIn1 or DataIn2 or AluCtrl)
	begin
		if(AluCtrl == 0)
			AluResult = DataIn1+DataIn2;
		else
			if(AluCtrl == 1)
				AluResult = DataIn1-DataIn2;
			else
			    if(AluCtrl == 2)
					AluResult = DataIn1|DataIn2;
		
		
		if(AluResult == 0)
			Zero = 1;
		else
			Zero = 0;
	end

endmodule