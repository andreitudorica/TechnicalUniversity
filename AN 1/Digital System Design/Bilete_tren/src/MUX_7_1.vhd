library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity MUX_BANI is
	port(SEL:in std_logic_vector(2 downto 0);
	Y:out std_logic_vector (8 downto 0));
end MUX_BANI;
architecture multiplex of MUX_BANI is
begin
	process(SEL)
	begin 
		case SEL is
			when "000"=> Y<="000000001";--10 centi
			when "001"=> Y<="000000101";--50 centi
			when "010"=> Y<="000001010";--1 euro
			when "011"=> Y<="000010100";--2 euro
			when "100"=> Y<="000110010";--5 euro
			when "101"=> Y<="001100100";--10 euro
			when "110"=> Y<="011001000";--20 euro
			when "111"=> Y<="111110100";--50 euro
			
			when others=> null;
		end case;	
	end process;
	
	
	
end multiplex;
