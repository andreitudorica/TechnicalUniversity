--Unitate aritmetico-logicã (+, -, x, /; SI, NU, SAU, SAU-EXCLUSIV)
library IEEE;
use ieee.numeric_bit.all;
use std_logic_1164.all;
entity alu is 
	generic (nr_in: integer :=4);
	port (a, b: in unsigned ((nr_in-1) downto 0);
	sel : in unsigned (2 downto 0);
	y: out unsigned ((nr_in-1) downto 0)); 
end alu; 
architecture arh_alu of alu is 
begin 
	process (a, b, sel)	
	begin
		case sel is
			when "000" => y<= a+ b;
			when "001" => y<= a-b;
			when "010" => y<=a*b;
			when "011" => y<=a/b;
			when "100" => y<= a and b;
			when "101" => y<= not a;
			when "110" => y<= a or b;
			when "111" => y<= a xor b;
		end case;
	end process;
end arh_alu;

			