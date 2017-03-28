module im_4k( addr, dout );

	input [9:0]	addr;

	output [31:0]	dout;

	reg [31:0]		dOut;
	reg [31:0]		imem[1023:0];

	always @(addr) begin
		dOut = imem[addr];
	end
	assign dout = dOut;

endmodule