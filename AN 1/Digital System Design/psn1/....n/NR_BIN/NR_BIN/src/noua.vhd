-------------------------------------------------------------------------------
--
-- Title       : noua
-- Design      : NR_BIN
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : noua.vhd
-- Generated   : Thu May 12 21:40:18 2011
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
--{entity {noua} architecture {arhitectura_noua}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.numeric_std.all; 
use ieee.std_logic_unsigned.all;

entity noua is
	port(
	clk:in std_logic;
	reset:in std_logic;
	paralel_load:in std_logic;
	data_in:in std_logic_vector (7 downto 0);
	iesire:out std_logic_vector (7 downto 0)
	);
end noua;

--}} End of automatically maintained section

architecture arhitectura_noua of noua is
begin
	process(clk)						 
	variable numar:std_logic_vector (7 downto 0):=(others=>'0');
	begin		
		if clk'event and clk='1' then
			if reset='1' then
				numar:=(others=>'0');
			else
				if paralel_load='1' then
					numar:=data_in;
				else
					numar:=numar+1;
				end if;
			end if;
			iesire<=numar;
		else
			
		end if;
	end process;
	 -- enter your statements here --

end arhitectura_noua;
