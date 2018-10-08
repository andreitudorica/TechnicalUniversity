--35. Modul de simulare pt. bistabil T sincron
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity bistt is 
	port (t, clk: in bit;
	q, qn: inout bit) ;
end bistt;
architecture arht of bistt is 
begin 
	process (clk )
	begin 
		if(clk='1' and clk'last_value='0') then 
			if (t='0') then q<=q;
				qn<= not q;
			else
				if(t='1') then qn<=q;
					q<= not qn;
				end if;
			end if;
			end if;
			end process;
		end arht; 
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity simt is 
end simt;
architecture simult of simt is
component bistt is 
	port (t, clk: in bit;
	q, qn: inout bit) ;
end component ;
signal t, clk, q, qn: bit;
begin 
	std: bistt port map (t, clk, q, qn);
	t<='0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;
	clk<= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns;
end simult;

	
	
	