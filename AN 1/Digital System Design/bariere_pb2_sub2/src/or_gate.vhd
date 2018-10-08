---------------------------------------------------------------------------------------------------
--
-- Title       : or_gate
-- Design      : bariere_pb2_sub2
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : or_gate.vhd
-- Generated   : Sat Jun  5 16:58:11 2010
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
--{entity {or_gate} architecture {or_gate}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity or_gate is 
	port (A,B:in std_logic;
	Y:out std_logic);
end or_gate;

--}} End of automatically maintained section

architecture or_gate of or_gate is
begin
	
	Y<=A or B;
	 -- enter your statements here --

end or_gate;
