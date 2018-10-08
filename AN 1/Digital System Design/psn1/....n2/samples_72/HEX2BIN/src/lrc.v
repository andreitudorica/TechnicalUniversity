`timescale 1ns / 1ps
module LRC(CLK,CLR,D,LRCLE,DEN,CMP,ERR);
input CLK,CMP,CLR;
input [1:0] DEN,LRCLE;
input [3:0] D;
wire [3:0] DH;
wire [7:0] LRCC,LRCR;
wire CMPR;
output ERR;
reg ERR;
wire DEN_OR_CMP = DEN[0] | CMP;
wire [7:0] LONG_D = {DH,D};

SUB SB1(.CLK(CLK),.CLR(CLR),.CE(DEN_OR_CMP),.SPE(CMP),.D(LONG_D),.Q(LRCC));
DATREG DRG(.CLK(CLK),.DLE(LRCLE),.D(D),.Q(LRCR));
COMP LRCCMP(.A(LRCC),.B(LRCR),.CMP(CMPR));
REG4 HDRG(.CLK(CLK),.CLR(CLR),.D(D),.EN(DEN[1]),.Q(DH));

always @(posedge CLK or posedge CLR) begin
  if(CLR)
    ERR = 1'b0;
  else begin
    if(CMP)
      ERR = ~CMPR;
    else
      ERR = ERR;
  end       
end 

endmodule

module SUB(CLK,CLR,CE,SPE,D,Q);

input CLK,CE,SPE,CLR;
input [7:0] D;
output [7:0] Q;
reg [7:0] Q;

always @(posedge CLK or posedge CLR) begin
  if(CLR)
    Q=8'd0;
  else begin  
    if(CE) begin
      if(SPE)
        Q=8'd0;
      else
        Q= Q - D;       
    end 
  end
end

endmodule

module COMP(A,B,CMP);
input [7:0] A,B;
output CMP;
//wire [7:0] C = (A ^ B);

assign 
  CMP = &(~A ^ B);

endmodule


module DATREG(CLK,DLE,D,Q);
input CLK;
input [1:0] DLE;
input [3:0] D;
output [7:0] Q;
reg [7:0] Q;

always @(posedge CLK) begin
  case(DLE)
   2'b00: Q = Q;
   2'b01: Q = {Q[7:4],D};
   2'b10: Q = {D,Q[3:0]};
   2'b11: Q = Q;
  endcase
end

endmodule