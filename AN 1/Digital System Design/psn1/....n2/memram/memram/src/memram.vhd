--Memorie RAM 16 x 4 biti 
library ieee;
use ieee.numeric_bit.all;

entity ram_m is 
	port (s: in unsigned (3 downto 0);
	ce: in bit ;
	we: in bit;
	y: inout unsigned (3 downto 0));
end ram_m;
architecture ram of ram_m is 
type matrice is array (0 to 15) of unsigned (0 to 3);
begin 
	process (s, ce, we)
	variable memorie :matrice;
	variable i: integer;
	begin 
		if (ce='1' and we='0') then 
			i:=to_integer (s);
			y<=memorie(i);
		end if;
		if (we='1' and ce='0') then 
			i:= to_integer(s);
			memorie(i):=y;
		end if;
	end process;
end ram; 


	