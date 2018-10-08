--21. Num„r„tor binar sincron (opera—ii: resetare, num„rare, Ónc„rcare paralel„)
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity numarator is 
	port (r, ep, clk: in bit;
	a:in  unsigned (7 downto 0);
	q: inout unsigned (7 downto 0));
end numarator;
architecture num of numarator is 
begin  
	process (clk, r)
	begin
	if (r='1') then q<="00000000";
	else
		if(ep='1') then q<=a;
		else
			if clk='1'and clk'event then 
				q<=q+1;
			end if;
		end if;
		end if;
	end process; 
	end num;
	
	
		
	