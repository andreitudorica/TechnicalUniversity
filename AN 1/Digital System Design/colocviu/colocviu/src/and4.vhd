---------------------------------------------------------------------------------------------------
--
-- Title       : and4
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : and4.vhd
-- Generated   : Sun May 23 16:56:16 2010
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
--{entity {and4} architecture {arh_and4}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and4 is 
	port(x1,x2,x3,x4:in std_logic;
		y:out std_logic);
end and4;

--}} End of automatically maintained section

architecture arh_and4 of and4 is
begin

	y<=x1 and x2 and x3 and x4;

end arh_and4;
