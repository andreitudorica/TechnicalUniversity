-------------------------------------------------------------------------------
--
-- Title       : si
-- Design      : Modul_de_Simulare
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : si.vhd
-- Generated   : Mon May  9 17:43:25 2011
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
	A,B:in bit;
	F:out bit
	);
end si;

--}} End of automatically maintained section

architecture arhitectura_si of si is
begin
	 F<=A and B;
	 -- enter your statements here --

end arhitectura_si;
