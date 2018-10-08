-------------------------------------------------------------------------------
--
-- Title       : suma2
-- Design      : NUMARATOR_STRUCTURAL
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : suma2.vhd
-- Generated   : Thu May 12 22:01:00 2011
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
--{entity {suma2} architecture {arhitectura_suma2}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity suma2 is
	port(
	a:in std_logic_vector (1 downto 0);
	b:in std_logic_vector (1 downto 0);
	carry_in:in std_logic;
	carry_out:out std_logic;
	rezultat:out std_logic_vector (1 downto 0)
	);
end suma2;

--}} End of automatically maintained section

architecture arhitectura_suma2 of suma2 is
begin					  
rezultat<="00" when a="00" and b="00" and carry_in='0' else
		"01"  when a="00" and b="00" and carry_in='1';
	
	 -- enter your statements here --

end arhitectura_suma2;
