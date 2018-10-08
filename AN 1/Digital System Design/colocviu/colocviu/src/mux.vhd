---------------------------------------------------------------------------------------------------
--
-- Title       : mux
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : mux.vhd
-- Generated   : Wed May 19 21:41:48 2010
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
--{entity {mux} architecture {amux}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity mux is	
	generic	(n: natural :=3);
	port (I:in std_logic_vector (2**n-1 downto 0);
	sel: in std_logic_vector (n-1 downto 0);
	y:out std_logic);
end mux;

--}} End of automatically maintained section

architecture amux of mux is
begin 
	mux8: process (I,sel)
	begin
		case sel(2 downto 0) is
			when "000" => y<=I(0);
			when "001" => y<=I(1);
			when "010" => Y<=I(2);
			when "011" => Y<=I(3);
			when "100" => Y<=I(4);
			when "101" => y<=I(5);
			when "110" => y<=I(6);
			when others => y<=I(7);
		end case;
	end process mux8;
	
end amux;
