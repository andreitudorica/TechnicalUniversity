`timescale 1ns / 1ps
module REG4(CLK, CLR, EN, D, Q);

input CLK,CLR,EN;
input [3:0] D;
output [3:0] Q;
reg [3:0] Q;

always @(posedge CLK or posedge CLR) begin
  if(CLR) Q = 4'd0;
  else
    if(EN) Q = D;   
end

endmodule