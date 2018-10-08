library IEEE;
use IEEE.STD_LOGIC_1164.all;


entity bistjk is
	port(j,k,r:in bit;												   
	     q,nq:inout bit);
end bistjk;

architecture arhbistjk of bistjk is	  
signal clock:bit;
begin	
		
	CLK:process
	begin
		clock<='0';
		wait for 5 ns;
		clock<='1';
		wait for 5 ns;
	end process CLK;
	
jk:process(clock,r)
begin
	if r='1' then
		q<='0';
		nq<='1';
		
	else
		if clock='1' and clock'last_value='0' then
		  if j='0' and k='1' then 
			  q<='0'; nq<='1';
		  else
			  if j='1' and k='0' then
				  q<='1'; nq<='0';
				  
			  else
				  if j='1' and k='1' then
					  nq<=q; q<=not q;
				  end if;
				  
			  end if;
			  end if;
		  end if;
		  end if;
		end process jk;
	end arhbistjk;
	
				  