-------------------------------------------------------------------------------
--
-- Title       : nimic
-- Design      : nimic
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : nimic.vhd
-- Generated   : Wed May  4 13:54:16 2011
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
--{entity {nimic} architecture {nimic}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and_b is	 
	port (a,b:in bit;
	      y:out bit);
end and_b;

architecture arhand_b of and_b is
begin 
	y<=a and b;
end architecture arhand_b;



entity nimic is	 
	port (x1,x2,x3:in bit;
	      y:out bit);
end nimic;



architecture arhnimic of nimic is
component and_b	
	port(a,b:in bit;
	     y:out bit);
end component and_b;
signal y_temp : bit;
	
begin
  u1: and_b port map(x1,x2,y_temp);
  u2:and_b port map(y_temp,x3,y);
	 -- enter your statements here --

end arhnimic;
