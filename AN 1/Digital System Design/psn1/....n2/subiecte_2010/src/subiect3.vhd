--convert 2421 to bcd  
library IEEE;
USE ieee.numeric_bit.all;
entity conv_2421 is 
	port (a: in unsigned (3 downto 0);
	b: out unsigned (3 downto 0 ));
end conv_2421;
architecture convertor of conv_2421 is
begin 
	process (a)
	variable s: unsigned (3 downto 0);
	begin 
		case a is
			when "0000" => s:="0000";
			when "0001" => s:="0001"; 
			when "0010" => s:="0010";
			when "0011" => s:="0011";
			when "0100" => s:="0100";
			when "0101" => s:="0101";
			when "0110" => s:="0110";
			when "1110" => s:="1000";
			when "1111" => s:="1001";
			when others => s:="1111";
		end case;
		b<=s;
	end process;
end convertor;

			