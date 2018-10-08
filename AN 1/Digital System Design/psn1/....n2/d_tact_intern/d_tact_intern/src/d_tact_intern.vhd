-------------------------------------------------------------------------------
--
-- Title       : d_tact_intern
-- Design      : d_tact_intern
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : d_tact_intern.vhd
-- Generated   : Sat May  7 17:15:03 2011
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
--{entity {d_tact_intern} architecture {d_tact_intern}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity d_tact_intern is	  
	port (m,d:in bit;
	       q,nq:out bit);
end d_tact_intern;

--}} End of automatically maintained section

architecture arhd_tact_intern of d_tact_intern is 
signal s1,s2,clock:bit;
begin
	clk:process
	begin
		clock<='0';
		wait for 5 ns;
		clock<='1';
		wait for 5 ns;
	end process;
N1:process(m)
begin
	s1<=not(m);
	end process N1;
	 -- enter your statements here --
 NAND1:process(s1,clock)
 begin
	 s2<=s1 nand clock;
 end process NAND1;
 
 D1:process(s2)
 begin
	 if s2='1' then
		 q<=d;
		 nq<=not(d);
end if;
end process D1;
end arhd_tact_intern;
