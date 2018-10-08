-------------------------------------------------------------------------------
--
-- Title       : sau_2
-- Design      : unu
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : sau_2.vhd
-- Generated   : Sun May  8 13:59:10 2011
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
--{entity {sau_2} architecture {sau_2}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sau_2 is
	port(
	A,B				:in std_logic;
	F				:out std_logic );
end sau_2;

--}} End of automatically maintained section

architecture sau_2 of sau_2 is
begin
	  F<=A or B;
	 -- enter your statements here --

end sau_2;
