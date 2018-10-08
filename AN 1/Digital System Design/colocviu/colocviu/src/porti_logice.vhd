---------------------------------------------------------------------------------------------------
--
-- Title       : porti_logice
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : porti_logice.vhd
-- Generated   : Wed May 19 19:07:34 2010
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {porti_logice} architecture {porti_logice}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;  

entity sau is
	port (A,B:in std_logic;
	Y: out std_logic);
end entity sau;

architecture ar_sau of sau is
begin
	PSAU: process (A,B)
	begin
		Y<=A or B;
	end process PSAU;
end architecture ar_sau;

