--30. Modul de simulare pt. MUX 4:1
library  ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity mux is
	port (a: in unsigned (3 downto 0 );
	sel : in unsigned (1 downto 0);
	q: out bit);	
end mux;
architecture multiplex of mux is 
begin 
	process (sel,a)
	variable i: integer;
	begin 
		i:= to_integer (sel);
		q<=a(i);
	end process;
end multiplex; 

library  ieee;
use numeric_bit.all;
entity sim is 
end sim;
architecture simulare of sim is 
component mux is  
	port (a: in unsigned (3 downto 0 );
	sel : in unsigned (1 downto 0);
	q: out bit);
end component;
signal a: unsigned (3 downto 0);
signal sel : unsigned (1 downto 0);
signal 	q: bit;
begin 
	std : mux port map (a ,sel ,q);	
	sel<= "00", "01" after 10 ns, "10" after 20 ns, "11" after 30 ns;
	a<="1000","0100" after 5 ns,"0010" after 15 ns,"0010" after 25 ns,"0001" after 35 ns;
end simulare;

	
	
	

	
	
