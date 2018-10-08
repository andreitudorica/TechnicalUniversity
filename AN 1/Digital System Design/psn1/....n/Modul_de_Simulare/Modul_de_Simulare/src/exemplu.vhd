-------------------------------------------------------------------------------
--
-- Title       : exemplu
-- Design      : Modul_de_Simulare
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : exemplu.vhd
-- Generated   : Mon May  9 17:43:04 2011
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
--{entity {exemplu} architecture {arhitectura_exemplu}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity exemplu is
end exemplu;

--}} End of automatically maintained section

architecture arhitectura_exemplu of exemplu is 
component si
	port(A,B:in bit;
	F:out bit
	);
end component si;
signal A,B,F:bit;
begin
	U0:si port map (A,B,F);
	A<='1','0' after 10 ns, '1' after 50 ns;
	B<='0','1' after 5 ns, '0' after 30 ns, '1' after 50 ns;
	 -- enter your statements here --

end arhitectura_exemplu;
