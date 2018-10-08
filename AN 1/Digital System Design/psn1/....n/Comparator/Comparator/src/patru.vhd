-------------------------------------------------------------------------------
--
-- Title       : patru
-- Design      : Comparator
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : patru.vhd
-- Generated   : Sun May  8 15:00:55 2011
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
--{entity {patru} architecture {arhitectura_patru}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity patru is
	port(
	A,B,C,D:in bit;
	F:out bit
	);
end patru;

--}} End of automatically maintained section

architecture arhitectura_patru of patru is 
component si
	port(A,B,C,D:in bit;
	F:out bit
	);
end component;
component sau
	port(A,B,C,D:in bit;
	F:out bit
	);
end component;
component inversor
	port(A:in bit;
	F:out bit
	);
end component;
signal a_inv,b_inv,c_inv,d_inv:bit;
signal a1,a2,a3,a4:bit;
begin

	 U1:inversor port map(A,a_inv);
	 U2:inversor port map(B,b_inv);
	 U3:inversor port map(C,c_inv);
	 U4:inversor port map(D,d_inv);
	 
	 U5:si port map(a_inv,b_inv,c_inv,d_inv,a1);
	 U6:si port map(a_inv,B,c_inv,D,a2);
	 U7:si port map(A,B,C,D,a3);
	 U8:si port map(A,b_inv,C,d_inv,a4);
	 
	 U9:sau port map(a1,a2,a3,a4,F);
end arhitectura_patru;
