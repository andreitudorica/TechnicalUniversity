---------------------------------------------------------------------------------------------------
--
-- Title       : bariere
-- Design      : bariere_pb2_sub2
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : bariere.vhd
-- Generated   : Sat Jun  5 16:16:12 2010
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
--{entity {bariere} architecture {arh_bariere}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity bariere is 
	port (S1,S2,S3,S4,CLK:in std_logic;
	B:out std_logic);
end bariere;

--}} End of automatically maintained section

architecture arh_bariere of bariere is
component senzori	  
	port (S1,S2,CLK:in std_logic;
	B:out std_logic);
end component senzori;	 
component or_gate
	port (A,B:in std_logic;
	Y:out std_logic);
end component or_gate;
signal rail1,rail2:std_logic;
begin
	U1:senzori port map(S1,S4,CLK,rail1);
	U2:senzori port map(S2,S3,CLK,rail2);
	U3:or_gate port map(rail1,rail2,B);

end arh_bariere;
