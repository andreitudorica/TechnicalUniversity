---------------------------------------------------------------------------------------------------
--
-- Title       : si_flow
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : si_flow.vhd
-- Generated   : Sun May 23 13:10:06 2010
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
--{entity {si_flow} architecture {si_flow}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity a_si_b is
	port (X1,X2:in std_logic;
	Y1:out std_logic);
end a_si_b;

--}} End of automatically maintained section

architecture a_si of a_si_b is
begin
	Y1<=X1 and X2;
end a_si;
