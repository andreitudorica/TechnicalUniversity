-------------------------------------------------------------------------------
--
-- Title       : doi
-- Design      : dec_BCD_zecimal
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : doi.vhd
-- Generated   : Sun May  8 14:27:27 2011
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
--{entity {doi} architecture {arhitectura_doi}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity doi is
	port(
		A,B,C,D:in bit;
		O:out bit_vector(9 downto 0)
		);
	
end doi;

--}} End of automatically maintained section

architecture arhitectura_doi of doi is
begin
	
	O(9)<='0' when (A='1' and B='0' and C='0' and D='1') else '1';
	O(8)<='0' when (A='1' and B='0' and C='0' and D='0') else '1';
	O(7)<='0' when (A='0' and B='1' and C='1' and D='1') else '1';
	O(6)<='0' when (A='0' and B='1' and C='1' and D='0') else '1';
	O(5)<='0' when (A='0' and B='1' and C='0' and D='1') else '1';
	O(4)<='0' when (A='0' and B='1' and C='0' and D='0') else '1';
	O(3)<='0' when (A='0' and B='0' and C='1' and D='1') else '1';
	O(2)<='0' when (A='0' and B='0' and C='1' and D='0') else '1';
	O(1)<='0' when (A='0' and B='0' and C='0' and D='1') else '1';
	O(0)<='0' when (A='0' and B='0' and C='0' and D='0') else '1';
	
	
end arhitectura_doi;
