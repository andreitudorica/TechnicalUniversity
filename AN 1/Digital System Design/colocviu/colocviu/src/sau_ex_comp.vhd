---------------------------------------------------------------------------------------------------
--
-- Title       : why
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : sau_ex_comp.vhd
-- Generated   : Wed May 19 20:02:58 2010
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
--{entity {why} architecture {arh}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity why is  
	port (C,D:in std_logic;
			Y:out std_logic);
end why;

--}} End of automatically maintained section

architecture arh of why is	   
component sau_ex
	port (A,B:in std_logic;
	Y:out std_logic);
	end component sau_ex;
begin
	 U:sau_ex port map (C,D,Y);
end arh;
