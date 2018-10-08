---------------------------------------------------------------------------------------------------
--
-- Title       : ex3
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : exces3_bcd.vhd
-- Generated   : Wed May 19 21:11:31 2010
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
--{entity {ex3} architecture {arh_ex3}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity ex3 is 
	port (X: in std_logic_vector(3 downto 0);
		Y:out std_logic_vector (3 downto 0));
end ex3;

--}} End of automatically maintained section

architecture arh_ex3 of ex3 is
--signal s: std_logic_vector (3 downto 0);
begin

	Y<=X-"0011";
	--Y<=s;

end arh_ex3;
