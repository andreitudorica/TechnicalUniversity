library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is 
	port(
	clk:in std_logic; 
	tc:out std_logic);
end counter;

architecture count of counter is 
signal intz:std_logic;
begin
	count1:process(clk,intz)
	variable v:integer range 0 to 10:=0;
	begin
		if(clk'event)and(clk='1')then
			if (v=10) then
				intz<='1';
				v:=0;
			else 
				intz<='0';
				v:=v+1;
			end if;
		end if;
	tc<=intz;
	end process count1;
end count;
