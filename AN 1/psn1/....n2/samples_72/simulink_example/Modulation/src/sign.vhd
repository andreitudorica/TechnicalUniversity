library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity signum is
	port(
		 In1 : in STD_LOGIC_VECTOR(30 downto 0);
		 Out1 : out STD_LOGIC_VECTOR (1 downto 0)
	     );
end signum;

architecture beh of signum is
begin

process (In1)
begin	
		if (In1(30) = '1') then
			Out1 <= "11";
		else
			Out1 <="01";
		end if;
end process;
	
end beh;
