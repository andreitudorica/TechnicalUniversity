library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;	
use IEEE.std_logic_arith.all;

entity numarator_p10 is
	port(clk, dir,pl,rst: in std_logic;
	nr_pl: in std_logic_vector (3 downto 0);
	num: out std_logic_vector (3 downto 0));
end numarator_p10;

architecture arh_nr of numarator_p10 is

begin									   
	process(clk)
	variable count: std_logic_vector(3 downto 0):="0000";
	begin
		if clk='1' and clk'event then
			if rst='1' then count :="0000";
			elsif pl='1' then count:=nr_pl;
			else
			if dir='1' then
				if count /="1001" then 
				count:=count+1;	
				else count:="0000"; end if;
			else 
				if count /="0000" then 
				count:=count-1; 	   
				else count:="1001"; end if;
			end if;	 
		end if;
		end if;
	num<=count;
	end process;
		
end arh_nr;