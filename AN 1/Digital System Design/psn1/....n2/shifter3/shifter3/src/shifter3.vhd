  --23. S? se realizeze un registru de deplasare universal BARREL SHIFTER, care poate efectua
--deplas?ri la stânga sau la dreapta de maximum 3 pozi?ii binare


library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity shifter3 is	
	port(load,r,dd,ds,clk:in bit;
	a:in bit_vector(3 downto 0);
	q:inout bit_vector(3 downto 0));
end shifter3;

architecture arhshifter3 of shifter3 is
begin  
	process(r,clk)	
	variable s,d:integer:=1;
	begin
	if r='1' then q<="0000";
	else   
		if load='1' then q<=a;
			else
		if clk='1' and clk'event then
			if d<4 and dd='1' then 
				q<=q srl 1;
				d:=d+1;
			else 
				if ds='1' and s<4 
					then q<=q sll 1;
					s:=s+1;
				end if;
			end if;
			end if;	 
			end if;
		end if;	 
	end process;
end arhshifter3;
