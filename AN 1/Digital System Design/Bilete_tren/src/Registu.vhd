library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity registru_9b is
	port( D:in std_logic_vector(8 downto 0);
	CLK,RST:in STD_LOGIC;
	Q:out std_logic_vector(8 downto 0));
end registru_9b;

architecture memorare of registru_9b is
begin
	process(CLK,RST)
	variable a:STD_LOGIC_VECTOR (8 downto 0):="000000000";
	begin 
		if(RST='1')	 then
			a:="000000000";
			else
		if(CLK'EVENT) and (CLK='1') then
			a:=D;
		end if;
		end if;
		Q<=a;
			
		
	end process;
end memorare;
