
module inst( clk );

	input clk;
	parameter [8*3:1] p = "";

	initial
		begin
			$display("p = %s",p);
		end

endmodule

