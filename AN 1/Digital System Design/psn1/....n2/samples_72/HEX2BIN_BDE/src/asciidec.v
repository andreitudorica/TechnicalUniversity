//--------------------------------------------------------------------------------------------------
//
// Title       : ASCIIDEC
// Design      : HEX2BIN_BDE
// Author      : Aldec
// Company     : Aldec
//
//-------------------------------------------------------------------------------------------------
//
// File        : C:\2\HEX2BIN_BDE\src\ASCIIDEC.v
// Generated   : Mon Jun 17 15:00:46 2002
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
//{module {ASCIIDEC}}
module ASCIIDEC ( ISHEX ,DIGIT ,SC ,CHAR );

input [7:0] CHAR ;
wire [7:0] CHAR ;

output ISHEX ;
reg ISHEX ;
output [3:0] DIGIT ;
reg [3:0] DIGIT ;
output SC ;
reg SC ;

//}} End of automatically maintained section

// -- Enter your statements here -- //

always @ (CHAR) begin

//Semicolon det  
  if(CHAR==8'h3A) SC=1;
  else SC=0;

//Is Hexadecimal  
  if(((CHAR>=8'h30) && (CHAR<=8'h39)) || ((CHAR>=8'h41) && (CHAR<=8'h46)))
    ISHEX=1;  
  else ISHEX=0;  
  
//Convertion HEX(ASCII)->BIN  
  if(((CHAR>=8'h30)&&(CHAR<=8'h39)) || ((CHAR>=8'h41)&&(CHAR<=8'h46))) 
  begin
    if(CHAR[6])
      DIGIT=CHAR[3:0]+4'b1001;
    else
      DIGIT=CHAR[3:0];
  end 
  else begin
    DIGIT=0;
  end  
  
end

endmodule
