
module GPR(DataOut1,DataOut2,clk,WData,WE,WeSel,ReSel1,ReSel2);
	input clk;
	input WE;
	input [4:0] WeSel,ReSel1,ReSel2;
	input [31:0] WData;
	
	output [31:0] DataOut1,DataOut2;
	
	
	reg [31:0] Gpr[31:0];
	
	always@(posedge clk)
	begin
		if(WE == 1)
			Gpr[WeSel] <= WData;
	end
	assign DataOut1 = (ReSel1==0)?0:Gpr[ReSel1];
	assign DataOut2 = (ReSel2==0)?0:Gpr[ReSel2];
	
endmodule