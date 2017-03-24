`include "ctrl_encode_def.v"
module alu (A, B, ALUOp, C, Zero);

	input  [31:0] A, B;			//运算数据1\2
	input  [2:0]  ALUOp;		//运算器控制信号

	output reg [31:0] C;		//运算器输出结果
	output reg Zero;			//结果是否为零

	initial begin				//初始化数据
		Zero = 0;
		C = 0;
	end

	always @( A or B or ALUOp ) begin
		case ( ALUOp )
			`ALUOp_ADDU: C = A + B;
			`ALUOp_SUBU: C = A - B;
			`ALUOp_OR:   C = A | B;
			default:;
		endcase
		assign Zero = (C == 0) ? 1 : 0;
	end // end always;

endmodule