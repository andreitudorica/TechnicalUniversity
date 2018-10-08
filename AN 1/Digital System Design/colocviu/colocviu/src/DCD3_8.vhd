---------------------------------------------------------------------------------------------------
--
-- Title       : dcd
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : DCD3_8.vhd
-- Generated   : Sun May 23 13:43:34 2010
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
--{entity {dcd} architecture {arh_dcd}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dcd is	 
	port (I:in std_logic_vector(2 downto 0);
		O:out std_logic_vector(7 downto 0));
end dcd;

--}} End of automatically maintained section

architecture arh_dcd of dcd is
begin
	decoder:process(I)
	begin
		case (I) is
			when "000" => O<="00000001";
			when "001" => O<="00000010";
			when "010" => O<="00000100";
			when "011" => O<="00001000";
			when "100" => O<="00010000";
			when "101" => O<="00100000";
			when "110" => O<="01000000";
			when "111" => O<="10000000";
			when others => O<="00000000"; 
		end case;
	end process;

end arh_dcd;
