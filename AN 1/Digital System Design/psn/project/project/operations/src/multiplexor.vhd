library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity multiplexor is
	port ( SEL: in std_logic_vector (1 downto 0);
	a,b,c,d: in std_logic_vector (7 downto 0);
	y: out std_logic_vector (7 downto 0));
end multiplexor;

architecture multiplexer of multiplexor is
begin
	process(SEL,a,b,c,d)
	begin
		case SEL is
			when "00" => y <= a;
			when "01" => y <= b;
			when "10" => y <= c;
			when "11" => y <= d;
			when others =>
		end case;
	end process;
end architecture;	