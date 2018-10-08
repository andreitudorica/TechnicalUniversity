--14. Sumator-sc„z„tor pe 4 bi—i ñ descriere comportamental„
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_bit.all;
entity sum is 
	port (a, b: in unsigned(3 downto 0 );
	s: out unsigned (3 downto 0 );
	m: in bit);
end sum;
architecture sumator of sum is 
begin 
	process (a, b)
	variable x, y, z: integer;
	begin 
		if (m='1') then 
			s<=a+b;
		else 
			if (m='0') then 
				s<=a-b;
			end if;
		end if;
		end process;
	end sumator;
	
		
	
			
		
	