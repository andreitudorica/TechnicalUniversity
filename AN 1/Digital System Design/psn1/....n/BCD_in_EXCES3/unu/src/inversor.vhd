-------------------------------------------------------------------------------
--
-- Title       : inversor
-- Design      : unu
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : inversor.vhd
-- Generated   : Sun May  8 13:57:50 2011
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
	A			:in std_logic;
	F			:out std_logic );
end inversor;

--}} End of automatically maintained section

architecture arhitectura_inversor of inversor is
begin
	 F<=(not A);
	 -- enter your statements here --

end arhitectura_inversor;
