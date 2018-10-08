---------------------------------------------------------------------------------------------------
--
-- Title       : sau_flow
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : sau_flow.vhd
-- Generated   : Sun May 23 13:11:02 2010
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
--{entity {sau_flow} architecture {sau_flow}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity a_sau_b is
	port (X3,X4:in std_logic;
	Y2:out std_logic);
end a_sau_b;

--}} End of automatically maintained section

architecture a_sau of a_sau_b is   
begin
	Y2<=X3 or X4;
end a_sau;
