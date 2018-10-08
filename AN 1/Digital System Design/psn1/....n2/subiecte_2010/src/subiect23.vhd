--	 Registru universal sincron (memorare, încãrcare paralelã, deplasare dreapta, deplasare
--stânga, resetare)
library ieee;
use numeric_bit.all;
use std_logic_1164.all;
entity registru is
	port (ep, dd, ds, r, clk: in bit;
	a: in unsigned (3 downto 0);
	q: inout unsigned (3 downto 0));
end registru;
architecture reg of registru is
begin 
	process (clk, r)
	begin 
		if (r='1') then q<="0000";
		else 
			if (ep='1') then q<=a;
			else if (clk='1') and (clk'last_value='0') then
				if (dd='1') then 
					q<=q srl 1;
				else if (ds='1') then 
					q<=q sll 1;
				end if;
				end if;
			end if;
			end if;
		end if;
		end process;
	end reg;
	