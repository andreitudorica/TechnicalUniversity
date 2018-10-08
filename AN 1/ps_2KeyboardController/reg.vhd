library ieee;
use ieee.std_logic_1164.all;

entity reg is
	port (
	clk:in std_logic; 
	rst:in std_logic; 
	d:in std_logic_vector(7 downto 0); 
	we:in std_logic;
	q:out std_logic_vector(7 downto 0));
end reg;

architecture reg of reg is		

begin		
process(clk,rst,we)	
variable int:std_logic_vector(7 downto 0);
begin
	if rst='1' then
		int:="00000000";
	else if (we='1') then
		if (clk'event)and(clk='1') then
			int:=d;
		end if;
	end if;	
	end if;	 
	q<=int;
	end process;
end reg;