-------------------------------------------------------------------------------
--
-- Title       : exemplu_fc
-- Design      : exemplu_fc
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : exemplu_fc.vhd
-- Generated   : Sat May 14 17:52:59 2011
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
--{entity {exemplu_fc} architecture {arhitectura_exemplu_fc}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity exemplu_fc is
	port(
	a,b:in unsigned (1 downto 0);
	f:out unsigned (1 downto 0);
	carry:out bit
	);
end exemplu_fc;

--}} End of automatically maintained section

architecture arhitectura_exemplu_fc of exemplu_fc is
procedure adunare (signal a :unsigned(1 downto 0);signal  b:unsigned(1 downto 0);signal f:out unsigned (1 downto 0);signal carry:out bit) is
variable temp1,temp2,t:unsigned(2 downto 0);
begin
	temp1:=('0' & a);
	temp2:=('0' & b);
	t:=temp1+temp2;
	f<=t(1 downto 0);
	carry<=to_bit(t(2));
	
end adunare;
begin
	
	assert (a="00") report "a este 11";
	 adunare(a,b,f,carry);

end arhitectura_exemplu_fc;
