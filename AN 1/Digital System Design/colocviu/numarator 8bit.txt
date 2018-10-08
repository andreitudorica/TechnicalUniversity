library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;	
use IEEE.std_logic_arith.all;

entity numarator is
	port(clk, dir,pl,rst: in std_logic;
	nr_pl: in std_logic_vector (7 downto 0);
	num: out std_logic_vector(7 downto 0));
end numarator;

architecture arh_n of numarator is

begin									   
	process(clk)
	variable count: std_logic_vector(7 downto 0):="00000000";
	begin
		if clk='1' and clk'event then
			if rst='1' then count :="00000000";
			elsif pl='1' then count:=nr_pl;
			else
			if dir='1' then	
				count:=count+1;
			else count:=count-1; 
			end if;	 
		end if;
		end if;
	num<=count;
	end process;
		
end arh_n;
	