-------------------------------------------------------------------------------
--
-- Title       : generic_si
-- Design      : generic_si
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : generic_si.vhd
-- Generated   : Wed May  4 16:59:10 2011
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
--{entity {generic_si} architecture {generic_si}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity poarta_si is
	generic	(nr_intrari:natural:=2);
	port (intrari :in bit_vector(1 to nr_intrari);
	iesire:out bit);
end poarta_si;	

poarta_si:block
generic (nr_intrari: natural:=2);
port(intrari:in bit_vector(1 to nr_intrari);
iesire:out bit);
generic map (nr_intrari=>8);
--}} End of automatically maintained section

begin
process(intrari)
variable v:bit :='1';
begin
	for I in 1 to nr_intrari loop
		v:=v and intrari(I);
	end loop;
	iesire<=v;
end process;

	 -- enter your statements here --

end poarta_si;
