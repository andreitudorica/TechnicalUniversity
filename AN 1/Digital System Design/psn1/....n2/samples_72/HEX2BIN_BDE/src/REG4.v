//--------------------------------------------------------------------------------------------------
//
// Title       : REG4
// Design      : HEX2BIN_BDE
// Author      : Aldec
// Company     : Aldec
//
//-------------------------------------------------------------------------------------------------
//
// File        : C:\2\HEX2BIN_BDE\src\REG4.v
// Generated   : Mon Jun 17 14:42:49 2002
// From        : interface description file
// By          : Itf2Vhdl ver. 1.20
//
//-------------------------------------------------------------------------------------------------
//
// Description : 
//
//-------------------------------------------------------------------------------------------------
`timescale 1ps / 1ps

//{{ Section below this comment is automatically maintained
//   and may be overwritten
//{module {REG4}}
module REG4 ( Q ,CLR ,CLK ,EN ,D );

input CLR ;
wire CLR ;
input CLK ;
wire CLK ;
input EN ;
wire EN ;
input [3:0] D ;
wire [3:0] D ;

output [3:0] Q ;
reg [3:0] Q ;

//}} End of automatically maintained section

// -- Enter your statements here -- //

always @(posedge CLK or posedge CLR) begin
  if(CLR) Q = 4'd0;
  else
    if(EN) Q = D;   
end

endmodule
