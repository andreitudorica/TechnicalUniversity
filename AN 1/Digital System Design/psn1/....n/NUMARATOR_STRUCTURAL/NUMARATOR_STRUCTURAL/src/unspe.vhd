-------------------------------------------------------------------------------
--
-- Title       : unspe
-- Design      : NUMARATOR_STRUCTURAL
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : unspe.vhd
-- Generated   : Thu May 12 21:58:10 2011
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
--{entity {unspe} architecture {arhitectura_unspe}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity unspe is
	port(
	numar_1:in std_logic_vector (7 downto 0);
	numar_2:in std_logic_vector (7 downto 0);
	rezultat:out std_logic_vector (7 downto 0);
	carry_out:out std_logic
	);
end unspe;

--}} End of automatically maintained section

architecture arhitectura_unspe of unspe is
begin

	 -- enter your statements here --

end arhitectura_unspe;
