//--------------------------------------------------------------------------------------------------
//
// Title       : SUB
// Design      : HEX2BIN_BDE
// Author      : Aldec
// Company     : Aldec
//
//-------------------------------------------------------------------------------------------------
//
// File        : C:\2\HEX2BIN_BDE\src\SUB.v
// Generated   : Mon Jun 17 14:42:13 2002
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
//{module {SUB}}
module SUB ( SPE ,CE ,Q ,CLR ,CLK ,D );

input SPE ;
wire SPE ;
input CE ;
wire CE ;
input CLR ;
wire CLR ;
input CLK ;
wire CLK ;
input [7:0] D ;
wire [7:0] D ;

output [7:0] Q ;
reg [7:0] Q ;

//}} End of automatically maintained section

// -- Enter your statements here -- //

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
