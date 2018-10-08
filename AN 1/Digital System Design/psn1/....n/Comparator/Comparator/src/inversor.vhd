-------------------------------------------------------------------------------
--
-- Title       : inversor
-- Design      : Comparator
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : inversor.vhd
-- Generated   : Sun May  8 15:03:21 2011
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
--{entity {inversor} architecture {arhitectura_inversor}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity inversor is 
	port(
	A:in bit;
	F:out bit
	);
end inversor;

--}} End of automatically maintained section

architecture arhitectura_inversor of inversor is
begin
	F<=(not A);
	 -- enter your statements here --

end arhitectura_inversor;
