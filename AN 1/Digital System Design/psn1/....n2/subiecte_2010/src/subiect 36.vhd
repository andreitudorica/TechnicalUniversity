--36. Modul de simulare pt. registru de deplasare stânga-dreapta si dreapta-stânga
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity reg is 
	port (a: in bit_vector (3 downto 0); 
	mode, clk, ep : in bit;
	q: inout bit_vector(3 downto 0));
end reg;
architecture arh of reg is 
begin 
	process (clk )
	begin	
		if (ep='1') then 
		if (clk='0' and clk'last_value='1') then 
			q<=a;
		end if;
		else 
			if(mode='1') then 
				q<=q srl 1;
			else 
				if (mode='0') then 
					q<=q sll 1;
				end if;
			end if;
			end if;
		end process;
		end arh;
		--modul de simulare 
entity simularer is 
end simularer;
architecture simreg of simularer is 
component reg is 
	port (a: in bit_vector (3 downto 0); 
	mode, clk, ep : in bit;
	q: inout bit_vector(3 downto 0));
end component ;
signal a, q : bit_vector (3 downto 0);
signal mode, clk, ep: bit;
begin 
	std: reg port map (a, mode, clk, ep, q);
	a<="0101", "1001" after 20 ns;
	ep<='1', '0' after 15 ns;
	mode<='0', '1' after 5 ns, '0' after 15 ns, '1' after 25 ns;
	clk<= '0', '1' after 5 ns, '0' after 10 ns, '1' after 15 ns, '0' after 20 ns, '1' after 25 ns, '0' after 30 ns;
end simreg;

	
	
		
			
		    
	