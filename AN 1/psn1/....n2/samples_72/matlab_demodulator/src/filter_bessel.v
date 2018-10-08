// *******************************************************
// * Lowpass, 2nd order Bessel Filter with corner        *
// *    frequency 20 MHz                                 *
// * Gain: 1.787808509e+02                               *
// *  y(n) = 1.7355100114*y(n-1) + -0.7578837722*y(n-2)  *
// *                     + 1*x(n) + 2*x(n-1) + 1*x(n-2)  *
// * NOTE:      DC component is artificially removed by  *
// *            subtracting constant from the output.    *
// *******************************************************
`timescale 1 ns / 1 ps

module Filter_bessel ( input [15:0] DataIn,
                input clk, reset, Rdy,
                output [15:0] DataOut,
                output reg Ack );
localparam Idle  = 1'b0;
localparam Ready = 1'b1;
localparam order = 2;
reg CurrState;	// 0 - Idle; 1 - Ready
reg [15:0] test;
real xs [0:order], ys [0:order];

	always @DataIn begin : noX
		if (DataIn === 16'bX) test = 16'b0;
		else test = DataIn;
	end	

	always @(  posedge clk, reset  ) begin : fltr
		integer i;
		if (reset)
			begin
				for (i=0; i<=order; i=i+1) xs[i] = 0.0;
				for (i=0; i<=order; i=i+1) ys[i] = 0.0;
				CurrState = Idle;
				Ack       =  1'b0;
			end
		else
			if (CurrState == Idle)
				if (Rdy)
					begin
						CurrState = Ready;
						xs[0] = test / 178.7808509; // gain correction
						ys[0] = xs[0] + 2.0*xs[1] + xs[2] + 1.7355100114*ys[1] - 0.7578837722*ys[2];
						// shift stored samples
						xs[2] = xs[1]; xs[1] = xs[0];
						ys[2] = ys[1]; ys[1] = ys[0];
							
						Ack = 1'b1;	
					end
				else
					Ack = 1'b0;
			else		// CurrState == Ready
				begin
					Ack       = 1'b0;
					CurrState = Idle; 
				end
	end	// fltr	

	assign DataOut = $rtoi(ys[0] - 10300.0);
endmodule
							    