-------------------------------------------------------------------------------
--
-- Title       : sau
-- Design      : Comparator
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : sau.vhd
-- Generated   : Sun May  8 15:02:33 2011
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
--{entity {sau} architecture {sau}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sau is
	port(
	A,B,C,D:in bit;
	F:out bit);
end sau;

--}} End of automatically maintained section

architecture sau of sau is
begin
	F<=A or B or C or D;
	 -- enter your statements here --

end sau;
