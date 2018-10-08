-------------------------------------------------------------------------------
--
-- Title       : sum_compl
-- Design      : sum_compl
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : sum_compl.vhd
-- Generated   : Wed May  4 15:01:08 2011
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
--{entity {sum_compl} architecture {sum_compl}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity poarta_sau is
	port(a,b:in bit;
	s:out bit);
end poarta_sau;

architecture arh_sau of poarta_sau is
begin
	s<=a or b;
end arh_sau;


entity sum_compl is	
	port(a,b,cin:in bit;
	     s,cout:out bit);
end sum_compl;


--}} End of automatically maintained section

architecture struct_sum_compl of sum_compl is 
component semi_sum
	port(a,b: in bit;
	cout,s: out bit);
end component;

component poarta_sau
	port(a,b:in bit;
	s:out bit);
end component;

signal n1,n2,n3:bit;

	
begin
   c1:semi_sum port map(a,b,n1,n2);
   c2:semi_sum port map(n2,cin,n3,s);
   c3:poarta_sau port map(n1,n3,cout);
	 -- enter your statements here --

end struct_sum_compl;
