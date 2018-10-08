

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use numeric_bit.all; 

entity reg_depl is	
	port (pl,r,dd,ds,clk:in bit;
	a:in unsigned(3 downto 0);
	q:inout unsigned(3 downto 0));
end reg_depl;


architecture arhreg_depl of reg_depl is
begin  
	process(clk,r) 
	begin
	if r='1' then q<="0000";
	else
		if pl='1' then q<=a;
		else	 
			if clk='1' and clk'event then
			if dd='1' then q<=q srl 1;
			else 
				if ds='1' then q<=q sll 1;
			end if;
			end if;
			end if;
			end if;
		end if;
	end process;	
end arhreg_depl;
