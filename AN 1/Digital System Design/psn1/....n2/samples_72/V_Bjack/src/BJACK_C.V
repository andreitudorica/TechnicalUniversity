`timescale 1ps / 1ps

module BJACK_C (CARD, CLOCK, NEW_C, NEW_G, BUST, HAND, HOLD, NEXT_C);
input  [3:0]CARD;
input  CLOCK;
input  NEW_C;
input  NEW_G;
output BUST;
output [4:0]HAND;
output HOLD;
output NEXT_C;

reg [4:0]Total;
reg [7:0]BlackJack;
reg Ace;

// ONE HOT ENCODED state machine: BlackJack
parameter  Begin_g	 = 8'b00000001,
		   BustState = 8'b00000010,
		   Got_im	 = 8'b00000100,
		   Hit_me	 = 8'b00001000,
		   HoldState = 8'b00010000,
		   TenBack	 = 8'b00100000,
		   test16	 = 8'b01000000,
		   Test21	 = 8'b10000000;

// concurrent signal assignments
assign HAND = Total;

always @ (posedge CLOCK)
begin
	if (NEW_G == 1'b1)
	begin
		BlackJack = Begin_g;
		Total = 5'b00000;
		Ace = 1'b0;
	end
	else
	begin
		case (BlackJack)
			Begin_g :
				BlackJack = Hit_me;
			BustState : 
				;
			Got_im :
				if (NEW_C == 1'b0)
					BlackJack = test16;
			Hit_me :
				if (NEW_C == 1'b1)
				begin
					BlackJack = Got_im;
					Total = Total + { 1'b0, CARD} ;     // {} used to avoid warnings
					Ace = (CARD == 4'b1011) || Ace;     // CARD == 11 ??
				end
			HoldState :	
				;
			TenBack :
				BlackJack = test16;
			test16 :
				if (Total > 5'b10000)       // > 16 ??
					BlackJack = Test21;
				else
					BlackJack = Hit_me;
			Test21 :
				if (Total < 5'b10101)             // < 21 ??
					BlackJack = HoldState;
				else if (Ace)
				begin
					BlackJack = TenBack;
					Total = Total - 5'b01010;   // Total - 10
					Ace = 1'b0;
				end
				else
					BlackJack = BustState;

			default:
				;
		endcase
	end
end

// signal assignment statements for combinatorial outputs
assign NEXT_C = (BlackJack == Hit_me) ? 1'b1 : 1'b0;
assign BUST = (BlackJack == BustState) ? 1'b1 : 1'b0;
assign HOLD = (BlackJack == HoldState) ? 1'b1 : 1'b0;

endmodule
