

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use numeric_bit.all;

entity numarator is	 
	port (mr,pl,clk:in bit;
	      d:in unsigned(7 downto 0);
		  q:inout unsigned (7 downto 0));
end numarator;



architecture arhnumarator of numarator is
begin	
	process(clk,mr)
	begin
	if mr='1' then
		q<="00000000";
	else	
		if pl='1' then
			q<=d; 
		else 
			if clk='1' and clk'event then
			q<=q+"00000001";
			end if;	
			end if;
	end if;	
	 end process;
end arhnumarator;
