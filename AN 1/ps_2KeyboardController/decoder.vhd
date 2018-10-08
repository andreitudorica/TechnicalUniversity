library ieee;
use ieee.std_logic_1164.all;

entity decoder is 
	port(
	data:in std_logic_vector(7 downto 0);
	clk:in std_logic;
	seven_segment:out std_logic_vector(6 downto 0);
	anods:out std_logic_vector(3 downto 0));
end decoder;

architecture decode of decoder is
signal intQ: std_logic_vector(6 downto 0);
begin	
	process(clk,intQ)
	begin
	anods<="1110";
	if (clk'event) and (clk='1') then
	case data is
		when "01000101" => intq<="0000001"; -- 0 
		when "00011100" => intq<="0001000"; -- A
		when "00100001" => intq<="0110001"; -- C
		when "00100100" => intq<="0110000"; -- E
		when "00101011" => intq<="0111000"; -- F
      when "00010110" => intq<="1001111"; -- 1
      when "00011110" => intq<="0010010"; -- 2
      when "00100110" => intq<="0000110"; -- 3
      when "00100101" => intq<="1001100"; -- 4
		when "00101110" => intq<="0100100"; -- 5
		when "00110110" => intq<="0100000"; -- 6
		when "00111101" => intq<="0001111"; -- 7
		when "00111110" => intq<="0000000"; -- 8
		when "01000110" => intq<="0000100"; -- 9
		when "00110010" => intq<="1100000"; -- b
		when "00100011" => intq<="1000010"; -- d
		when "00110100" => intq<="0000010"; -- g
		when "00110011" => intq<="1101000"; -- h
		when "01000011" => intq<="1111001"; -- i
		when "00111011" => intq<="0000011"; -- J
		when "01001011" => intq<="1110001"; -- L
		when "01001101" => intq<="0011000"; -- P
		when "00101100" => intq<="1110000"; -- t
		when "00111100" => intq<="1000001"; -- U
		when "01000100" => intq<="1100010"; -- o
		when others => intq<="1111110";		
	end case;
	end if;
	seven_segment<=intq;
		end process;
end decode;
	