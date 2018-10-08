-------------------------------------------------------------------------------
--
-- Title       : si_3
-- Design      : unu
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : si_3.vhd
-- Generated   : Sun May  8 14:00:02 2011
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
--{entity {si_3} architecture {si_3}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity si_3 is
	port(
	A,B,C			:in std_logic;
	F				:out std_logic);
end si_3;

--}} End of automatically maintained section

architecture si_3 of si_3 is
begin
	 F<=A and B and C;
	 -- enter your statements here --

end si_3;
