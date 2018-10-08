

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity buffer8biti is 
	           
	port(x,enable:in bit_vector (7 downto 0);
	     q:out bit);
	
end buffer8biti;


architecture arhbuffer8biti of buffer8biti is
begin		
	process(x,enable)
	variable c:integer;
	begin 	  
		c:=0;
   while (c<=7) loop
	   if(enable(c)='1') then
		   q<=x(c);
	   else
		   c:=c+1;
   	   end if; 
		  end loop;
end process;		  

end arhbuffer8biti;	   

-----------------------------------------

  

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity simulare is
end simulare;

architecture arhsim of simulare is
component buffer8biti 
	    port(x,enable:in bit_vector (7 downto 0);
	     q:out bit);	
end component buffer8biti;

signal x,enable:bit_vector(7 downto 0);
signal q:bit;
begin
	ust: buffer8biti port map(x,enable,q);
	enable<="00000000","11000001" after 20 ns,"00100000" after 30 ns,"00010000" after 40 ns,"00001000" after 50 ns,"00000100" after 60 ns,"00000010" after 70 ns,"00000001" after 80 ns ;
	x<="00000000", "11000001" after 10 ns,"00010000" after 30 ns,"00010000" after 40 ns,"00000000" after 50 ns,"00000100" after 60 ns,"00000000" after 70 ns,"00000001" after 80 ns;
	
end arhsim;	