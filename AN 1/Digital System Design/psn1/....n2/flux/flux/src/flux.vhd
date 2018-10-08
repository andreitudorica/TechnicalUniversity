-------------------------------------------------------------------------------
--
-- Title       : flux
-- Design      : flux
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : flux.vhd
-- Generated   : Wed May  4 14:55:26 2011
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
--{entity {flux} architecture {flux}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity si is   
	port(x1,x2,x3:in bit;
	     y:out bit);
end si;


--}} End of automatically maintained section

architecture flux of si is 
signal y_temp:bit;
begin
	y_temp<=x1 and x2;
	y<=y_temp and x3;
	 -- enter your statements here --

end flux;
