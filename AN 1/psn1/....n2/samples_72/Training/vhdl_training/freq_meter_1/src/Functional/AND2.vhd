--
--  File: AND2.vhd
--  created by Design Wizard: 05/20/99 12:57:29
--

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {AND2} architecture {AND2}}

library IEEE;
use IEEE.std_logic_1164.all;

entity AND2 is
	port (
		A0: in STD_LOGIC;
		A1: in STD_LOGIC;
		Y: out STD_LOGIC
	);
end AND2;

--}} End of automatically maintained section

architecture AND2 of AND2 is
begin
  -- <<enter your statements here>>		  
  Y<=A0 and A1;
end AND2;
