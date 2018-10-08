-------------------------------------------------------------------------------
--
-- Title       : registru
-- Design      : a20
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : registru.vhd
-- Generated   : Sat May 14 18:48:33 2011
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
--{entity {registru} architecture {arhitectura_registrul}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity registru is
	port(
	clk:in bit;
	data_in :in bit_vector(7 downto 0);
	paralel_load:in bit;
	outputs :out bit_vector(7 downto 0)
	);
end registru;

--}} End of automatically maintained section

architecture arhitectura_registrul of registru is
begin
	
	process(clk)
	variable data:bit_vector(7 downto 0);
	begin
		if clk'event and clk='1' then
			if paralel_load='1' then
				data:=data_in;
			else
				data:=data srl 1;
			end if;
			outputs<=data;
		end if;
			
	end process;	
		

end arhitectura_registrul;
