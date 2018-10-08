
module inst( clk );

	input clk;
	parameter [3:0] p = 4'b0000;

	initial
		begin
			$display("p = %b",p);
		end

endmodule
