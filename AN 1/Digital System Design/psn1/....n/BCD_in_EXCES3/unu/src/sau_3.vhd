-------------------------------------------------------------------------------
--
-- Title       : sau_3
-- Design      : unu
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : sau_3.vhd
-- Generated   : Sun May  8 14:01:06 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {sau_3} architecture {arhitectura_sau_3}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sau_3 is
	port(
	A,B,C			:in std_logic;
	F				:out std_logic);
end sau_3;

--}} End of automatically maintained section

architecture arhitectura_sau_3 of sau_3 is
begin
	 F<=A or B or C;
	 -- enter your statements here --

end arhitectura_sau_3;
