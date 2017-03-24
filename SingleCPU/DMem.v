
module DMem(DataOut,DataAdr,DataIn,DMemW,DMemR,clk);
	input [4:0] DataAdr;
	input [31:0] DataIn;
	input 		 DMemR;
	input 		 DMemW;
	input 		 clk;
	
	output[31:0] DataOut;
	
	reg [31:0]  DMem[1023:0];
	
	always@(posedge clk)
	begin
		if(DMemW)
			DMem[DataAdr] <= DataIn;
	end
	assign DataOut = DMem[DataAdr];
endmodule