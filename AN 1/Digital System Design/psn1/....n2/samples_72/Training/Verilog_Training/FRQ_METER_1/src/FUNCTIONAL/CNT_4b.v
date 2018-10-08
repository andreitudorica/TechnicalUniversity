module CNT_4b (CLK, ENABLE, RESET, FULL, Q);

input CLK;
wire CLK;
input ENABLE;
wire ENABLE;
input RESET;
wire RESET;
output FULL;
wire FULL;
output [3:0] Q;
wire [3:0] Q;

// add your declarations here
	reg [3:0] Qint;
	
	always @(posedge RESET or posedge CLK)
		if (RESET)
			Qint = 4'b0000;
		else if (ENABLE) begin
			if (Qint == 9)
				Qint = 4'b0000;
			else
				Qint = Qint + 4'b1;
			end
			
		assign Q = Qint;
		assign FULL = (Qint == 9) ? 1'b1 : 1'b0;
// add your code here

endmodule 
