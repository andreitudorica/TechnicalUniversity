--20. Bistabil T sincron, cu intrãri asincrone si cu proces pt. tact – descriere comportamentalã
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity bist_t is 
	port (t, r : in std_logic;
	q, qn: inout std_logic);
end bist_t;
architecture bistabil of bist_t is 
signal clk: std_logic;
begin 
	process(clk)
	begin 
		if (clk='U') then clk<='0';
		else clk <= not clk after 5 ns;
		end if; 
		end process;
	process (clk, r)
	begin 
		if (r='1') then 
			q<='0'; 
			qn<='1';
		else
			if (clk='1' and clk'last_value='0') then 
				if (t='0') then q<=q; qn<=not q;
				else
					if t='1' then qn<=q; q<= not qn;
					end if;
				end if;
				end if;
			end if;
		end process;
		end bistabil;
		