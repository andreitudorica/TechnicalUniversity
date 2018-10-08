---------------------------------------------------------------------------------------------------
--
-- Title       : or6
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : or6.vhd
-- Generated   : Sun May 23 17:07:01 2010
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
--{entity {or6} architecture {a_or6}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or6 is	
	port(a1,a2,a3,a4,a5,a6:in std_logic;
		p:out std_logic);
end or6;

--}} End of automatically maintained section

architecture a_or6 of or6 is
begin

	p<=a1 or a2 or a3 or a4 or a5 or a6;

end a_or6;
