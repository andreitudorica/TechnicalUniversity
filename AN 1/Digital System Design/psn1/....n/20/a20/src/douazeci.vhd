-------------------------------------------------------------------------------
--
-- Title       : a20
-- Design      : a20
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : douazeci.vhd
-- Generated   : Sat May 14 18:47:49 2011
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
--{entity {a20} architecture {arhitectura_a20}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity a20 is 
end a20;

--}} End of automatically maintained section

architecture arhitectura_a20 of a20 is
component registru	   
	port(
	clk:in bit;
	paralel_load:in bit;
	data_in:in bit_vector (7 downto 0);
	outputs:out bit_vector (7 downto 0)
	);
end component registru;
constant perioada_tact:time:=50ns;
signal clk,paralel_load:bit;
signal data_in,outputs:bit_vector(7 downto 0);
signal enable:bit;
begin		
	U1:registru port map(clk,paralel_load,data_in,outputs);
	process	
	begin
			clk<=not clk;
			wait for 100ns;
	end process;
	process
	begin
		paralel_load<='0';
		wait for 100 ns;
		paralel_load<='1';
		--data_in<="00000100";
		wait for 500 ns;
			
	end process;  
	data_in<="00000100";
end arhitectura_a20;
