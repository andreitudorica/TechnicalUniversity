--28. Modul de simulare pentru scãzãtor complet pe 1 bit
library ieee;
use numeric_bit.all;
use std_logic_1164.all;
entity scad is 
	port (a, b, cimp: in bit;
	q, coimp: out bit);	   
end scad;
architecture scaz of scad is
begin 
	q<=a xor b xor cimp;
	coimp<=((not a ) and b) or (cimp and b) or (cimp and (not a));
end scaz;
entity simulare is
end simulare;
architecture sim of simulare is
component scad is
	 port (a, b, cimp: in bit;
	q, coimp: out bit);
end component; 
signal a, b, cimp, q, coimp: bit;
begin 
	ust: scad port map (a, b, cimp, q, coimp);
	process 												  
	begin 
		a<='1';
		cimp <='1';
		wait for 5 ns;
		a<='0';
		b<='1';
		wait for 10 ns;	
		wait for 5 ns;
	end process;
end;

	
	
	
