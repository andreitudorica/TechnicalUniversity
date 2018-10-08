--Codificator zecimal – BCD
library IEEE;
use numeric_bit.all;
use std_logic_1164.all;
entity codif is 
	port (a: in unsigned (0 to 9);
	b: out unsigned (3 downto 0));
end codif;
architecture codificator of codif is 
begin 
	process (a)
	
	begin 
		case a is
			--9876543210
			when "0000000001" => b<="0000";
		when "0000000010" => b<="0001";
		when "0000000100" => b<="0010";
		when "0000001000" => b<="0011";
		when "0000010000" => b<="0100";
		when "0000100000" => b<="0101";
		when "0001000000" => b<="0110";
		when "0010000000" => b<="0111";
		when "0100000000" => b<="1000";
		when "1000000000" => b<="1001";
		when others => assert (1=0) report ("eroare la introducere");
		end case;  
	end process;
end codificator;

	