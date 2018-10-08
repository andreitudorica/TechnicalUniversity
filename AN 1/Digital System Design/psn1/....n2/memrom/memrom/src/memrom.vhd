--Memorie ROM 16 x 4 bi—i 
library IEEE;
use ieee.numeric_bit.all;
use ieee.std_logic_1164.all;  

entity mem_rom is 
	port ( s : in unsigned (3 downto 0);
	cs: in bit;
	y : out unsigned (15 downto 0 ));
end mem_rom;
architecture rom of mem_rom is
type matrice is array (0 to 15) of unsigned (0 to 15);
begin
		process	(s,cs)	
	variable memorie : matrice:=("0000000000000000","0000000000000001","0000000000000010","0000000000000011","0000000000000100","0000000000000101","0000000000000110","0000000000000111","0000000000001000","0000000000001001","0000000000001010","0000000000001011","0000000000001100","0000000000001101","0000000000001110","0000000000001111");
	variable i: integer;
	begin
		if (cs='1')	then
			i:= to_integer(s);
			y<= memorie(i);
		end if;
		
	end process;
end rom;

	
