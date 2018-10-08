// ASCIIdec converts the ASCII character set into:
// ISHEX -> Indicates the following ASCII characters '0'..'9' or 'A'..'F'
// DIGIT -> Hexadecimal value of characters '0' = 0 ...
// SC    -> Indicates the ':' character
`timescale 1ns / 1ps
module ASCIIdec (CHAR, DIGIT, ISHEX, SC) ;

input [7:0] CHAR ;
output [3:0] DIGIT ;
output ISHEX ;
output SC ;
reg [3:0] DIGIT;
reg SC,ISHEX;


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
