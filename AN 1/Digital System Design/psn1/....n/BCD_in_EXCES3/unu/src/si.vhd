-------------------------------------------------------------------------------
--
-- Title       : si
-- Design      : unu
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : si.vhd
-- Generated   : Sun May  8 13:56:33 2011
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
--{entity {si} architecture {arhitectura_si}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity si is
	port(
	A,B			:in std_logic;
	F			:out std_logic );
end si;

--}} End of automatically maintained section

architecture arhitectura_si of si is
begin
	
	F<=A and B;
	 -- enter your statements here --

end arhitectura_si;
