// *******************************************************
// * Simple filter averaging 4 most recent input samples *
// *  yn = 0.25xn + 0.25x(n-1) + 0.25x(n-2) + 0.25x(n-3) *
// * NOTE:      DC component is artificially removed by  *
// *            subtracting constant from the output.    *
// *******************************************************
`timescale 1 ns / 1 ps

module Filter_simple ( input [15:0] DataIn,
                input clk, reset, Rdy,
                output [15:0] DataOut,
                output reg Ack );
localparam Idle  = 1'b0;
localparam Ready = 1'b1;
reg CurrState;	// 0 - Idle; 1 - Ready
reg [17:0] Current;
reg [15:0] test, PrevSmpl1, PrevSmpl2, PrevSmpl3;

	always @DataIn begin : noX
		if (DataIn === 16'bX) test = 16'b0;
		else test = DataIn;
	end	

	always @(  posedge clk, reset  ) begin : fltr
		if (reset)
			begin
				Current   <= 18'b0;
				PrevSmpl1 <= 16'b0;
				PrevSmpl2 <= 16'b0;
				PrevSmpl3 <= 16'b0;
				CurrState <= Idle;
				Ack       <=  1'b0;
			end
		else
			if (CurrState == Idle)	
				if (Rdy)
					begin
						CurrState <= Ready; 
						Current   <= test + PrevSmpl1 + PrevSmpl2 + PrevSmpl3; // add samples
						PrevSmpl3 <= PrevSmpl2;
						PrevSmpl2 <= PrevSmpl1;
						PrevSmpl1 <= Current[17:2];							   // divide by 4
						
						Ack <= 1'b1;	
					end
				else
					Ack <= 1'b0;
			else		// CurrState == Ready
				begin
					Ack       <= 1'b0;
					CurrState <= Idle; 
				end
	end	// fltr	

	assign DataOut = Current[17:2] - 10300;
endmodule
							    