-------------------------------------------------------------------------------
--


library IEEE;
use IEEE.STD_LOGIC_1164.all;   
use numeric_bit.all;
entity numzec is  
	port(pl,mr,clk:in bit;
	d:in unsigned(3 downto 0);	
	q:inout unsigned(3 downto 0));
end numzec;

architecture arhnumzec of numzec is
begin
	process(clk,mr)  
	begin
	if mr='1' then
		q<="0000";
	else			 
	  if clk='1' and clk'event then
		
		if pl='1' then 
			if d<10 then
			q<=d; 	
			else q<="0000";	 
		    end if;
			
		else
			q<=q+1;
			 if(q=9) then q<="0000";
			 end if;	   
		end if;
		end if;
		end if;	
 end process;
end arhnumzec;
