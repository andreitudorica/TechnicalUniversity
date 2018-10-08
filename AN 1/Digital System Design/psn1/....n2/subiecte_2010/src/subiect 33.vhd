--33. Modul de simulare pt. bistabil D sincron
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity bistd is
	port (d, clk: in bit;
	q, qn: out bit);
end bistd;
architecture arh of bistd is 
begin
	process (clk)
	begin 
	if (clk='1' and clk'last_value='0') then 
		q<=d; 
		qn<= not d;
	end if;
	end process;
end arh;
entity simbist is 
end simbist;
architecture simulare of simbist is 
component bistd is 
	port (d, clk: in bit;
	q, qn: out bit);
end component;
signal d, clk, q, qn: bit;
begin 
	std: bistd port map (d, clk, q, qn);
	d<= '0', '1' after 10 ns, '0' after 20 ns, '1' after 30 ns;
	clk<= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns;
end simulare;

	
		