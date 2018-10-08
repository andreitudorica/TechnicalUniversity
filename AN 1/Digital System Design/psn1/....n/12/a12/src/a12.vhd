-------------------------------------------------------------------------------
--
-- Title       : a12
-- Design      : a12
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : a12.vhd
-- Generated   : Sat May 14 17:17:44 2011
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
--{entity {a12} architecture {arhitectura_a12}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.numeric_std.all;

entity a12 is
	port(
		clk:in std_logic;
		memorare:in std_logic;
		paralel_load:in std_logic;
		data_in:in bit_vector (3 downto 0);
		shift:in std_logic;
		reset:in std_logic;
		outputs:out bit_vector (3 downto 0)
		);
end a12;

--}} End of automatically maintained section

architecture arhitectura_a12 of a12 is
begin
	
	process(clk,reset,paralel_load)						  
	variable var_outputs:bit_vector (3 downto 0);
	begin		
		if clk'event and clk='1' then
			if reset='1' then
				var_outputs:=(others=>'0');
			else
				if paralel_load='1' then
					var_outputs:=data_in;
				else
					if shift='1' then
						var_outputs:=var_outputs sll 1;
					else
						var_outputs:=var_outputs srl 1;
					end if;
				end if;
			end if;
			outputs<=var_outputs;
		end if;
	end process;
	
end arhitectura_a12;
