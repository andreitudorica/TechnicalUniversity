--convertor de cod BCD to Gray
library IEEE;
use ieee.numeric_bit.all;
entity convert_bcd is 
	port (a:IN unsigned (3 downto 0);
	y: out unsigned (3 downto 0));
end convert_bcd;
architecture conv_bcd of convert_bcd is 
begin 
	process (a) 
	variable s: unsigned (3 downto 0);
	begin
		case a is
			when "0000" => s:="0000";
		when "0001" => s:="0001";
		when "0010" => s:="0011";
		when "0011" => s:="0010";
		when "0100" => s:="0110";
		when "0101" => s:="0111";
		when "0110" => s:="0101";
		when "0111" => s:="0100";
		when "1000" => s:="1100";
		when "1001" => s:="1101";
		when "1010" => s:="1111";
		when "1011" => s:="1110";
		when "1100" => s:="1010";
		when "1101" => s:="1011";
		when "1110" => s:="1001";
		when "1111" => s:="1000";
	end case;
	y<=s;
	end process;
end;
