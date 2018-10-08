--31. Modul de simulare pt. DEMUX 1:4
library ieee;
use numeric_bit.all;
entity demux is 	  
	port (a: in bit ;
	sel : in unsigned (1 downto 0);
	q: out unsigned (3 downto 0));
end demux;
architecture demultiplex of demux is 
begin 
	process (sel, a)
	variable i: integer;
	begin 
		i:= to_integer (sel);
		q(i)<= a;
	end process;
end demultiplex;
library ieee;
use numeric_bit.all;
entity simul is 
end simul;			
architecture simulare of simul is 
component demux is 
	  port (a: in bit ;
	sel : in unsigned (1 downto 0);
	q: out unsigned (3 downto 0));
end component;
signal a: bit;
signal sel : unsigned(1 downto 0);
signal q: unsigned (3 downto 0);
begin 
	std: demux port map (a, sel ,q );
	sel<="00", "01" after 10 ns, "10" after 20 ns, "11" after 30 ns;
	a<= '0', '1' after 5 ns, '0'after 10 ns , '1' after 20 ns, '0' after 25 ns, '1' after 30 ns;
end simulare;

