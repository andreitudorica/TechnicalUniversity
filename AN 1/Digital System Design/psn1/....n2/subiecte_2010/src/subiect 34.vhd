--34. Modul de simulare pt. bistabil JK sincron
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity bistjk is 
	port (j, k, clk: in bit;
	q, qn: inout bit);
end bistjk;
architecture arhit of bistjk is 
begin 
	process (clk)
	begin
	if (clk='1' and clk'last_value='0') then 
	if (j='0' and k='1') then q<='0'; qn<='1';
	else
		if (j='1' and k='0') then q<='1'; qn<= '0';
		else
			if (j='1' and k='1') then qn<=q; q<= not q;
			end if;
		end if;	   
		end if;
	end if;
	end process;
	end arhit; 
	library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity simjk is 
end simjk; 
architecture simuljk of simjk is
component bistjk is 
	port (j, k, clk: in bit;
	q, qn: inout bit);
end component;
signal j, k, clk, q, qn: bit;
begin 
	std: bistjk port map (j, k, clk, q, qn);
	j<= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;
	k<= '0', '1' after 5 ns, '0' after 15 ns, '1' after 25 ns, '0' after 30 ns;
    clk<= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns;
end simuljk;

	
		