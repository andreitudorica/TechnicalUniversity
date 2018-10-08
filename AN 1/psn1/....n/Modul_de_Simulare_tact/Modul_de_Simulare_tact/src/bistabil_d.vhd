-------------------------------------------------------------------------------
--
-- Title       : bistabil_d
-- Design      : Modul_de_Simulare_tact
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : bistabil_d.vhd
-- Generated   : Mon May  9 18:03:53 2011
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
--{entity {bistabil_d} architecture {arhitectura_bistabil_d}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bistabil_d is
	port(
	D:in bit;
	Q,NQ:out bit
	);
end bistabil_d;

--}} End of automatically maintained section

architecture arhitectura_bistabil_d of bistabil_d is
begin
	Q<=D;
	NQ<=(not D);
	 -- enter your statements here --

end arhitectura_bistabil_d;
