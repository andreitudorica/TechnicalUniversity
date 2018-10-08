`timescale 1ps / 1ps

// Verilog model for Decoder of 5-bits Binary Numbers to Two BCD Digits

module BIN2BCD (BIN, BCD_H, BCD_L);
input  [4:0]BIN;
output [1:0]BCD_H;
output [3:0]BCD_L;

assign BCD_L = (BIN == 5'b00001 || BIN == 5'b01011 || BIN == 5'b10101 || BIN == 5'b11111) ? 4'b0001 :
			   (BIN == 5'b00010 || BIN == 5'b01100 || BIN == 5'b10110) ? 4'b0010 :
			   (BIN == 5'b00011 || BIN == 5'b01101 || BIN == 5'b10111) ? 4'b0011 :
			   (BIN == 5'b00100 || BIN == 5'b01110 || BIN == 5'b11000) ? 4'b0100 :
			   (BIN == 5'b00101 || BIN == 5'b01111 || BIN == 5'b11001) ? 4'b0101 :
			   (BIN == 5'b00110 || BIN == 5'b10000 || BIN == 5'b11010) ? 4'b0110 :
			   (BIN == 5'b00111 || BIN == 5'b10001 || BIN == 5'b11011) ? 4'b0111 :
			   (BIN == 5'b01000 || BIN == 5'b10010 || BIN == 5'b11100) ? 4'b1000 :
			   (BIN == 5'b01001 || BIN == 5'b10011 || BIN == 5'b11101) ? 4'b1001 :
			   4'b0000 ;
				
assign BCD_H = (BIN < 5'd10) ? 2'b00 :
			   (BIN < 5'd20) ? 2'b01 :
			   (BIN < 5'd30) ? 2'b10 :
			   2'b11 ;
  
endmodule
