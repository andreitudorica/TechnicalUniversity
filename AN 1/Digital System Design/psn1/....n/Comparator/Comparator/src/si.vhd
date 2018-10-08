-------------------------------------------------------------------------------
--
-- Title       : si
-- Design      : Comparator
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : si.vhd
-- Generated   : Sun May  8 15:01:46 2011
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
--{entity {si} architecture {si}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity si is
	port(
	A,B,C,D:in bit;
	F:out bit);
end si;

--}} End of automatically maintained section

architecture si of si is
begin
	 F<=A and B and C and D;
	 -- enter your statements here --

end si;
