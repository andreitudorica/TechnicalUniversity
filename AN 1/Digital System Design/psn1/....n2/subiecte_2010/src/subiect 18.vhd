--Bistabil D sincron, cu intrãri asincrone si cu proces pt. tact – descriere comportamentalã
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity bistabil_d is
	 port (d, r: in bit;
	q, nq: out bit);
end bistabil_d;
architecture bistabil of bistabil_d is 
signal clk : std_logic;
begin 
	process (clk)
	begin 
		if (clk='U') then clk<='0';
		else
			clk <= not clk after 5 ns;
		end if;
		end process;
	bd: process (clk, r)
	begin 
		if (r='1') then
			q<='0';
			nq<='1';
		else
			if (clk='1' and clk'last_value='0') then
				q<=d;
				nq<= not d;
			end if;
		end if;
		end process bd;
	end bistabil;
	
			
			
