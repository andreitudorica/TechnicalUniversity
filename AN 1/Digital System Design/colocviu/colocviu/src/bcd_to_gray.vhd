---------------------------------------------------------------------------------------------------
--
-- Title       : bcd_converter
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : bcd_to_gray.vhd
-- Generated   : Wed May 19 20:22:36 2010
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {bcd_converter} architecture {bcd_arh}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bcd_converter is
	port (X: in std_logic_vector (3 downto 0);
		Y: out std_logic_vector (3 downto 0));
end bcd_converter;

--}} End of automatically maintained section

architecture bcd_arh of bcd_converter is
begin
	conv: process (X)
	begin
		case X is
			when "0000" => Y<="0000";
			when "0001" => Y<="0001";
			when "0010" => Y<="0011";
			when "0011" => Y<="0010";
			when "0100" => Y<="0110";
			when "0101" => Y<="0111";
			when "0110" => Y<="0101";
			when "0111" => Y<="0100";
			when "1000" => Y<="1100";
			when "1001" => Y<="1101";
			when "1010" => Y<="1111";
			when "1011" => Y<="1110";  
			when "1100" => Y<="1010";
			when "1101" => Y<="1011";
			when "1110" => Y<="1001";
			when others => Y<="1000";	  
		end case;
		end process conv;

end bcd_arh;
