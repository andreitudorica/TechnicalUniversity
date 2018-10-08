`timescale 1ps / 1ps

// Verilog model for double BCD digits to 7-Segment Displays, with turn off Displays
module BCD2LED (DIGIT_H, DIGIT_L, LED_H, LED_L, OFF);
input  [1:0]DIGIT_H;
input  [3:0]DIGIT_L;
output [6:0]LED_H;
output [6:0]LED_L;
input  OFF;

// auxiliary signals declaration
wire [6:0]L_TMP, H_TMP;

// segment encoding
//		0
//	   ---
//	5 |   | 1
//	   ---	 <- 6
//	4 |   | 2
//	   ---
//		3

assign L_TMP = (DIGIT_L == 4'b0001) ? 7'b1111001 :	 // 1
			   (DIGIT_L == 4'b0010) ? 7'b0100100 :	 // 2
			   (DIGIT_L == 4'b0011) ? 7'b0110000 :	 // 3
			   (DIGIT_L == 4'b0100) ? 7'b0011001 :	 // 4
			   (DIGIT_L == 4'b0101) ? 7'b0010010 :	 // 5
			   (DIGIT_L == 4'b0110) ? 7'b0000010 :	 // 6
			   (DIGIT_L == 4'b0111) ? 7'b1111000 :	 // 7
			   (DIGIT_L == 4'b1000) ? 7'b0000000 :	 // 8
			   (DIGIT_L == 4'b1001) ? 7'b0100000 :	 // 9
			   7'b1000000;                           // 0

assign H_TMP = (DIGIT_H == 2'b01) ? 7'b1111001 :  // 1
			   (DIGIT_H == 2'b10) ? 7'b0100100 :  // 2
			   (DIGIT_H == 2'b11) ? 7'b0110000 :  // 3
			   7'b0000001;                        // 0
		
assign LED_L = (OFF == 1'b0) ? L_TMP : 7'b1111111;
assign LED_H = (OFF == 1'b0) ? H_TMP : 7'b1111111;
	 	
endmodule
