---------------------------------------------------------------------------------------------------
--
-- Title       : not_flow
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : not_flow.vhd
-- Generated   : Sun May 23 13:11:53 2010
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
--{entity {not_flow} architecture {not_flow}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inv is
	port (X:in std_logic;
	NX:out std_logic);
end inv;

architecture a_inv of inv is
begin
	NX<=not(X);
end a_inv;
