

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity demux2 is 							
	port(sel:in bit_vector (2 downto 0);
	x:in bit;
	y:out bit_vector (7 downto 0));
end demux2;



architecture arhdemux2 of demux2 is
begin 
	
	y<=('0','0','0','0','0','0','0',x) when sel="000" else
	('0','0','0','0','0','0',x,'0') when sel="001" else
	('0','0','0','0','0',x,'0','0') when sel="010" else
	('0','0','0','0',x,'0','0','0') when sel="011" else  
	('0','0','0',x,'0','0','0','0') when sel="100" else 
	('0','0',x,'0','0','0','0','0') when sel="101" else 
	('0',x,'0','0','0','0','0','0') when sel="110" else
	(x,'0','0','0','0','0','0','0') when sel="111"; 
	 
end arhdemux2;	 

-------------------------------------------

entity simdemux is
end simdemux;
									
architecture arhsim of simdemux is

component demux2  							
	port(sel:in bit_vector (2 downto 0);
	x:in bit;
	y:out bit_vector (7 downto 0)); 
	
end component demux2;	

signal sel:bit_vector(2 downto 0);
signal x:bit;	 
signal y:bit_vector (7 downto 0); 

begin 
	ust: demux2 port map(sel,x,y);
	sel<="000", "001" after 20 ns,"010" after 40 ns,"011" after 60 ns,"100" after 70 ns,"101" after 90 ns,"110" after 100 ns,"111" after 120 ns;
	x<='0', '1' after 10 ns;
end arhsim;