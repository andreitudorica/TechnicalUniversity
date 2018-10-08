-------------------------------------------------------------------------------
--
-- Title       : recunoastere
-- Design      : recunoastere
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : recunoastere.vhd
-- Generated   : Wed May  4 17:13:29 2011
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
--{entity {recunoastere} architecture {recunoastere}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity recunoastere is
	generic(secventa:bit_vector:="10001");
	port(intrare, tact: in bit;
	     detectat:out bit);
end recunoastere;

--}} End of automatically maintained section

architecture simpla of recunoastere is
signal memorie :bit_vector(secventa'range);
begin
	detectat<=bit'val(boolean'pos(memorie=secventa));
	memorare:process (tact)
	begin
		if tact='1' then
			memorie <=memorie (memorie'left+1 to memorie'right) & intrare;
		end if;	   
	end process memorare;
	
	 -- enter your statements here --

end simpla;