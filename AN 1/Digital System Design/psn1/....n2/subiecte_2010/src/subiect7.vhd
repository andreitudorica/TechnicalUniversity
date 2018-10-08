--Decodificator binar pe 4 biti	
library ieee;
use std_logic_1164.all;
use numeric_bit.all;
entity decod is 
	port (a: in signed (3 downto 0);
	b: out signed (0 to 9));
end decod;
architecture decodificator of decod is 
begin  
	process (a)
	begin 					   
		--9876543210
		case a is 
			when "0000" => b<="0000000001";
			when "0001" => b<="0000000010";
			when "0010" => b<="0000000100";
			when "0011" => b<="0000001000";
			when "0100" => b<="0000010000";
			when "0101" => b<="0000100000";
			when "0110" => b<="0001000000";
			when "0111" => b<="0010000000";
			when "1000" => b<="0100000000";
			when "1001" => b<="1000000000";
			when others =>assert (0=1) report ("numar mai mare decat 9");
		end case;
	end process;
end decodificator;
