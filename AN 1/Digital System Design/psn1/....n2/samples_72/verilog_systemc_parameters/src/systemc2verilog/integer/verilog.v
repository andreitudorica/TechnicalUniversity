
module inst( clk );

	input clk;
	parameter integer p = 0;

	initial
		begin
			$display("p = %d",p);
		end

endmodule
