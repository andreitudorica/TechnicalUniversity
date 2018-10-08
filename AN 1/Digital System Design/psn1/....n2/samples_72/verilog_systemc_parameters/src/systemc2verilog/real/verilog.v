
module inst( clk );

	input clk;
	parameter real p = 0.0;

	initial
		begin
			$display("p = %f",p);
		end

endmodule
