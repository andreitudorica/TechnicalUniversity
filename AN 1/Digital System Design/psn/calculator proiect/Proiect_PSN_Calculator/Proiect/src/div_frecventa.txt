library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity div_frec is
	port(clk:in std_logic;
		clk_div:out std_logic;
		clk_div_afis:out std_logic_vector(1 downto 0);
		cnt_port: out std_logic_vector(24 downto 0));
end entity div_frec;

architecture arch_div_frec of div_frec is
begin
	process(clk)
	variable cnt:std_logic_vector(24 downto 0):="0000000000000000000000000";
	begin
		if clk'event and clk='1' then
			cnt:=cnt+1;
		end if;		  
		cnt_port<=cnt;
		clk_div<=cnt(24);
		clk_div_afis<=cnt(11 downto 10);
	end process;
end architecture arch_div_frec;