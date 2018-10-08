library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity scadere is
	port (SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0);
	y: out std_logic_vector (7 downto 0));	
end entity;	
	
architecture substraction of scadere is  		   
begin		
	process(SEL,a,b)  
	variable z: std_logic_vector(7 downto 0);
	begin		  
	if(SEL="01") then	
		z := "00000000";				 -- initializam vectorul cu 0 pe toti bitii
		if(a<=b)	then				 -- scadem numarul mai mic din cel mai mare
			z(3 downto 0) := b-a;		 -- umplem primii 4 biti, restul fiind 0
		else	
			z(3 downto 0) := a-b;
		end if;	
	end if;	 
	y <= z after 5 ns;
	end process;	
end architecture;			
	
	