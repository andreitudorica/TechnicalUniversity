-------------------------------------------------------------------------------
--
-- Title       : descr_comp
-- Design      : descr_comp
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : descr_comp.vhd
-- Generated   : Wed May  4 15:14:31 2011
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
--{entity {descr_comp} architecture {descr_comp}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sumator is
 port(a,b,cin:in bit;
      s,cout:out bit);
end sumator;

--}} End of automatically maintained section

architecture descr_comp of sumator is
begin
	process	(a,b,cin)
   variable	L:integer;
   constant	tabel_s:bit_vector(0 to 3):="0101";
   constant tabel_cout:bit_vector(0 to 3):="0011";
   begin
	   L:=0;
   if a='1' then L:=1; end if; 
   if b='1' then L:=L+1; end if;
   if cin='1' then L:=L+1; end if;
	s<=tabel_s(L) after 10 ns;
	cout<=tabel_cout(L) after 15 ns;   
	 -- enter your statements here --
end process;
end descr_comp;
