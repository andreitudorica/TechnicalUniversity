--22. Num„r„tor zecimal sincron (opera—ii: resetare, num„rare, Ónc„rcare paralel„
library ieee;
use ieee.numeric_bit.all;
use ieee.std_logic_1164;
entity numarator is 
	port (ep, r, clk: in bit;
	a : in unsigned (3 downto 0);
	q: inout unsigned (3 downto 0));
end numarator;
architecture num of numarator is 
begin 
	process (clk, r)
	begin 
		if (r='1') then q<="0000";
		else if ep='1' then 
			if a<10 then q<=a;
			else
				q<="0000";  
			end if;
			else
				if (clk='1') and (clk'last_value='0') then 
					q<=q+1;
					if (q=9) then q<="0000";
					end if;
				end if ;
				end if;
			end if;
			end process;
		end num;
		