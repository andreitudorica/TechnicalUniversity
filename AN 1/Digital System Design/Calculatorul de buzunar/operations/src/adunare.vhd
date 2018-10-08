library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity adunare is
	port (SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0);
	y: out std_logic_vector (7 downto 0));	
end entity;	
	
architecture adding of adunare is  		   
begin			
	process(SEL,a,b)
	variable z: std_logic_vector(7 downto 0);
	begin
	if(SEL="00") then		   
	 		z := "00000000";	  -- initializam vectorul cu 0 pe toti bitii
			z := z+a+b;			  -- adunam astfel incat rezultatul sa fie pe 8 biti
	end if;	  		 
	y <= z;
	end process;
end architecture;			
	
	