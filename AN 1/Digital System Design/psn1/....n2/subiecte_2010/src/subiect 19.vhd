--19. Bistabil JK sincron, cu intrãri asincrone si cu proces pt. tact – descriere comportamentalã
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity bist_jk is
port (j,k ,r : in std_logic;
q, qn: inout std_logic);
end bist_jk;
architecture bistabil of bist_jk is 
signal clk : std_logic;
begin
process(clk)
begin 
	if (clk='U') then clk<='0';
	else clk<= not clk after 5 ns;
		end if;
end process;
jk:process (r, clk )
begin 
	if (r='1') then
		q<='0';
		qn<='1';
	else
	if (clk='1' and clk'last_value='0') then 
	if (j='0' and k='1') then q<='0'; qn<='1'; else
	if (j='1' and k='0') then q<='1'; qn<='0'; else 
		if (j='1' and k='1') then qn<=q; q<=not q;
		end  if;
	end if;
	end if;
	end if;
	end if;
	end process;
end bistabil;

	