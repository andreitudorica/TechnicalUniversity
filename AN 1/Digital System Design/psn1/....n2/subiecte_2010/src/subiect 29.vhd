--29. Modul de simulare pentru comparator pe 1 bit
library ieee;
use numeric_bit.all;
use std_logic_1164.all;
entity comp is 
	port (a, b : in bit;
	q: out bit_vector (0 to 1));
end comp;
architecture comparator of comp is 
begin 
	q<= "00" when (a='1' and b='1' ) or (a='0' and b='0') else
	"01" when a='0' and b='1' else
	"10" when a='1' and b='0';
	end comparator;
entity sim is 
end sim;
architecture simulare of sim is 
component comp is 
	port (a, b : in bit;
	q: out bit_vector (0 to 1));
end component; 
signal a, b	:  bit;
signal q: bit_vector (0 to 1);
begin 
	ust: comp port map (a, b, q);
	a<='0', '1' after 10 ns, '0' after 30 ns;
	b<= '0', '1' after 20 ns;
end simulare;



		
