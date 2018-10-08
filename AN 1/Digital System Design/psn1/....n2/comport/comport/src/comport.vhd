-------------------------------------------------------------------------------
--
-- Title       : comport
-- Design      : comport
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : comport.vhd
-- Generated   : Wed May  4 14:40:12 2011
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
--{entity {comport} architecture {comport}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity porti_si is
	port(x1,x2,x3:in bit;
	     y:out bit);
end porti_si;

--}} End of automatically maintained section

architecture comport of porti_si is	 
signal y_temp:bit;
begin
 porti: process(x1,x2,x3,y_temp)
 begin
	 y_temp<=x1 and x2;
	 y<=y_temp and x3;
end process porti;

	 -- enter your statements here --

end comport;
