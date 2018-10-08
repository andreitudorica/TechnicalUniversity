--Memorie ROM 16 x 4 bi—i 
library IEEE;
use ieee.numeric_bit.all;
use ieee.std_logic_1164.all;
entity mem_rom is 
	port ( s : in unsigned (3 downto 0);
	cs: in bit;
	y : out unsigned (3downto 0 ));
end mem_rom;
architecture rom of mem_rom is
type matrice is array (0 to 15) of unsigned (0 to 3);
begin
		process	(s,cs)	
	variable memorie : matrice:=("0000","0001","0010","0011","0100","0101","0110","0111","1000","1001","1010","1011","1100","1101","1110","1111");
	variable i: integer;
	begin
		if (cs='1')	then
			i:= to_integer(s);
			y<= memorie(i);
		end if;
		
	end process;
end rom;

	
