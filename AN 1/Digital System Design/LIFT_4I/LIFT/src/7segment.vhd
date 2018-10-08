library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use ieee.numeric_std.all;

entity segment is
	port(E: in std_logic_vector(3 downto 0);
	O: out std_logic_vector (0 to 11));
end entity;	

architecture lcd of segment is
begin
display: process(E)
begin
case E is
	when "0000" => O<="000000110111";
	when "0001" => O<="100111110111";
	when "0010" => O<="001001010111";
	when "0011" => O<="000011010111";
	when "0100" => O<="100110010111";
	when "0101" => O<="010010010111";
	when "0110" => O<="010000010111";
	when "0111" => O<="000111110111";
	when "1000" => O<="000000010111";
	when "1001" => O<="000010010111";
	when "1010" => O<="000001010111";
	when "1011" => O<="110000010111";
	when others => O<="111001010111";	 
	end case;
end process;
end architecture;