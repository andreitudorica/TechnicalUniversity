-------------------------------------------------------------------------------
--
-- Title       : MS
-- Design      : Modul_de_Simulare_tact
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : MS.vhd
-- Generated   : Mon May  9 18:03:08 2011
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
--{entity {MS} architecture {arhitectura_MS}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MS is
end MS;

--}} End of automatically maintained section

architecture arhitectura_MS of MS is
	component bistabil_d	 
		port(
			D:in bit;
			Q,NQ:out bit
			);
	end component bistabil_d; 
	constant PERIOADA_CLK: TIME := 20 ns;
	signal D,Q,NQ,CLK:bit;
	shared variable END_SIM:boolean:=false;
begin
	
	GENERATOR_TACT: process
	begin
		if not END_SIM then
			CLK <= '0';
			wait for PERIOADA_CLK / 2;	
			CLK <= '1';
			wait for PERIOADA_CLK / 2;
		else wait;
		end if;
	end process GENERATOR_TACT;
	
	STIMUL: process
	begin
		D <= '1';
		wait for 200 ns;
		D <= '0';  
		assert (D='0') report "tzapa";
		wait for 200 ns;
		END_SIM := TRUE; 
		wait;
	end process STIMUL;
	
	Q<=D;
	NQ<=(not D);
	
end arhitectura_MS;
