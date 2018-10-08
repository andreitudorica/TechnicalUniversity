`timescale 1ps / 1ps

// Verilog version of the bjack.vhd module
// I.W. 30-Apr-98 
//`timescale 1ps / 1ps
module V_BJACK (L_L, LEDS, L_H, D_L, D_H, BUST, HOLD, NEW_CARD, GEN_RES, GEN_CLK, START, SYS_CLK);

output [6:0]L_L;
output [7:0]LEDS;
output [6:0]L_H;
inout  [3:0]D_L;
inout  [1:0]D_H;
inout  BUST;
inout  HOLD;
input  NEW_CARD;
input  GEN_RES ;
input  GEN_CLK ;
input  START   ;
input  SYS_CLK ;

// Signals defined as wires
wire CLK;
wire NOT_NEW_CARD;
wire NEXT_CARD;
wire OFF;
wire NEW_G;
wire S;
wire [3:0]DO ;
wire [4:0]HAND;
wire [4:0]VIS;

AND2 I1 (.I0(BUST), .I1(GEN_CLK), .O(OFF));
INV I13 (.I(START), .O(NEW_G));
BIN2BCD I14 (.BIN(VIS), .BCD_H(D_H), .BCD_L(D_L));
INV I12 (.I(NEW_CARD), .O(NOT_NEW_CARD));
INV I5 (.I(NEXT_CARD), .O(CLK));
BJACK_C I6 (.CARD(DO), .HAND(HAND), .BUST(BUST), .CLOCK(SYS_CLK), .HOLD(HOLD),
			.NEW_C(NOT_NEW_CARD), .NEW_G(NEW_G), .NEXT_C(NEXT_CARD));
JOHNSON8 I17 (.Q(LEDS), .CLK(CLK), .RESET(NEW_G));
OR2 I8 (.I0(HOLD), .I1(BUST), .O(S));
MUX I9 (.A(DO), .B(HAND), .Y(VIS), .S(S));
GEN I10 (.DO(DO), .CLK(GEN_CLK), .RES(GEN_RES), .ENC(NEW_CARD));
BCD2LED I11 (.DIGIT_H(D_H), .DIGIT_L(D_L), .LED_H(L_H), .LED_L(L_L), .OFF(OFF));

endmodule
