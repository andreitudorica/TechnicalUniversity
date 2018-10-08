

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity scaz_compl is
	port(a,b,cin:in bit;
	     q,cout:out bit);
end scaz_compl;


architecture arhscaz_compl of scaz_compl is
begin
   q<=a xor b xor cin;
   cout<=((not a) and cin) or (b and cin) or ((not a) and b); 
end arhscaz_compl;												  
------------------------------------------------------------------
entity modul is
end modul;

architecture arhmodul of modul is 

component scaz_compl
	port(a,b,cin:in bit;
	q,cout:out bit); 
end component scaz_compl;

signal a,b,cin,cout,q:bit;
begin
ust:scaz_compl port map (a,b,cin,q,cout);																  
	a<='0', '1' after 20 ns, '0' after 50 ns, '1' after 70 ns;
	b<='0', '1' after 10 ns, '0' after 20 ns,'1' after 40 ns, '0' after 50 ns;
	cin<='0', '1' after 50 ns;
end arhmodul;