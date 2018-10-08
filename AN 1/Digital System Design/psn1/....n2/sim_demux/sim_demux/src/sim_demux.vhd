
library  IEEE;
use numeric_bit.all;
use ieee.std_logic_1164.all; 

entity demux is 

	port (s: in unsigned(2 downto 0);
	     y:in bit; 
	     q: out unsigned(7 downto 0));
end demux ;	   

architecture arhdemux of demux is
begin 
	process (s,y)
	variable i: integer; 
	begin 
		i:=to_integer(s);  
		q<="00000000";
		q(i)<=y;
	end process;
end arhdemux;  

------------------------------------------
library  IEEE;
use numeric_bit.all;
use ieee.std_logic_1164.all; 

entity simdemux is
end simdemux;

architecture arhsim of simdemux is

component demux is 

	port (s: in unsigned(2 downto 0);
	     y:in bit; 
	     q: out unsigned(7 downto 0));
end component demux;  

signal y:bit;
signal s:unsigned (2 downto 0);
signal q:unsigned (7 downto 0);
begin
ust: demux port map(s,y,q);	   
s<="000", "001" after 20 ns,"010" after 40 ns,"011" after 60 ns, "101" after 80 ns,"110" after 100 ns,"111" after 120 ns;
y<='0', '1' after 30 ns;  
end arhsim;
 

	





