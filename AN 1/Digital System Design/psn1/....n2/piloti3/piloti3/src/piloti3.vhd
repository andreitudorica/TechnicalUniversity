-------------------------------------------------------------------------------
--
-- Title       : piloti3
-- Design      : piloti3
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : piloti3.vhd
-- Generated   : Sat May  7 18:42:41 2011
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
--{entity {piloti3} architecture {piloti3}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity piloti3 is
	port(valid_a,valid_b: in boolean;
	a,b:in std_logic;
	 y:out std_logic);
end piloti3;

--}} End of automatically maintained section

architecture arhpiloti3 of piloti3 is	
signal sa,sb:std_logic;
begin
sa<=a when valid_a else 'Z';
sb<=b when valid_b else 'Z';  
	
	P1:process(sa)
	begin
		y<=sa;
	end process P1;	 
	
	P2:process (sb)
	begin
		y<=sb;
	end process p2;
											
end arhpiloti3;
