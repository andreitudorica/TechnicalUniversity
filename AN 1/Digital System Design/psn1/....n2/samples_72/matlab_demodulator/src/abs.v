`timescale 1 ns / 1 ps

module abs ( input [15:0] I,
             output reg [15:0] O );
integer tmp ;
	always @I begin
		tmp = $signed(I);
		O = $unsigned( (tmp<0)?-tmp:tmp );
	end
endmodule
