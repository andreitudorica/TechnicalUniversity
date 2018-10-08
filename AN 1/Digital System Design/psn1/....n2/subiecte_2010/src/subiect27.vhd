--27. Modul de simulare pentru sumator complet pe 1 bit
library ieee;	 
use numeric_bit.all;
use std_logic_1164.all;
entity sum is 
	port (a, b, cin: in bit;
	q, cout : out bit);
end sum; 
architecture arh of sum is  
begin 
	q<=a xor b xor cin;
	cout<=(a and b) or (cin and b) or (cin and a);
end arh;
entity simulare is 
end simulare;
architecture sim of simulare is	
component sum is  
	port (a, b, cin: in bit;
	q, cout : out bit);
end component;
signal a,b, cin, q , cout :bit;
begin 						   
	c: sum port map (a, b, cin, q, cout);
	a<= '0','1' after 10 ns,'0'after 30 ns, '0' after 45ns ,'1' after 50 ns,'0'after 70 ns, '1' after 100 NS;
		b<= '0','1' after 20 ns,'0'after 40 ns,	 '0'after 45 ns,'1' after 60 ns,'0'after 80 ns,'1' after 100ns;
		cin<= '0','1' after 50 ns,'0'after 60 ns,'1' after 70 ns,'1' after 100ns;
end;
	
