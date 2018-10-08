-------------------------------------------------------------------------------
--
-- Title       : a11
-- Design      : a11
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : a11.vhd
-- Generated   : Mon May 16 21:57:21 2011
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
--{entity {a11} architecture {arhitectura_a11}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity a11 is  
	port(
	clk:in std_logic;
	outputs:out std_logic_vector (7 downto 0)
	);
end a11;

--}} End of automatically maintained section

architecture arhitectura_a11 of a11 is
component \2_biti\	   
	port(
	clk:in std_logic;
	carry:out std_logic;
	outputs_com:out std_logic_vector (1 downto 0)
	);
end component \2_biti\;
signal carry1,carry2,carry3,carry4:std_logic;
signal outputs1,outputs2,outputs3,outputs4:std_logic_vector (1 downto 0);
begin

	U1:\2_biti\ port map(clk,carry1,outputs1);
	U2:\2_biti\ port map(carry1,carry2,outputs2);
	U3:\2_biti\ port map(carry2,carry3,outputs3);
	U4:\2_biti\ port map(carry3,carry4,outputs4);
	outputs<=outputs4 & outputs3 & outputs2 & outputs1;

end arhitectura_a11;
