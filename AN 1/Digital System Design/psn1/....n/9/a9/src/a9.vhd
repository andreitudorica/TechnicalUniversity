-------------------------------------------------------------------------------
--
-- Title       : a9
-- Design      : a9
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : a9.vhd
-- Generated   : Mon May 16 21:19:39 2011
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
--{entity {a9} architecture {arhitectura_a9}}

library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use IEEE.STd_logic_ARITH.all;
use ieee.std_logic_unsigned.all;

entity a9 is
	generic (N:natural:=3);
	port (
	intrare:in std_logic;
	selectie:in std_logic_vector (N-1 downto 0);
	iesire:out std_logic_vector(2**N-1 downto 0)
	);
end a9;

--}} End of automatically maintained section

architecture arhitectura_a9 of a9 is
begin

	process(intrare,selectie)
	variable int:integer;
	begin		
		int:=conv_integer(selectie);
		for i in 0 to 2**N-1 loop 
			if i=int then
				iesire(i)<=intrare;
			else
				iesire(i)<='0';
			end if;
		end loop;
		
	end process;

end arhitectura_a9;
