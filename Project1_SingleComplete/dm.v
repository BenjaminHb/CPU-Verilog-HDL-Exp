module dm_4k(addr, din, DMWr, clk, dout);

	input [9:0]	addr;
	input [31:0]	din;
	input			DMWr;
	input			clk;

	output [31:0]	dout;

	reg[31:0]		dmem[1023:0];

	always@(posedge clk) begin
		if(DMWr)
			dmem[addr]<=din;

		$display("dm_4k.addr=%8X",addr);//addrtoDM
		$display("dm_4k.din=%8X",din);//datatoDM
		$display("dm_4k.Mem[00-07]=%8X,%8X,%8X,%8X,%8X,%8X,%8X,%8X",dmem[0],dmem[1],dmem[2],dmem[3],dmem[4],dmem[5],dmem[6],dmem[7]);
	end//end always
	assign	dout=dmem[addr];

endmodule
