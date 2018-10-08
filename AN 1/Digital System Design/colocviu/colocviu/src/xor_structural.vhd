---------------------------------------------------------------------------------------------------
--
-- Title       : sau_ex
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : xor_structural.vhd
-- Generated   : Wed May 19 20:00:29 2010
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
--{entity {sau_ex} architecture {arhi}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sau_ex is	
	port (A,B:in std_logic;
			Y:out std_logic);
end sau_ex;		 

architecture arhi of sau_ex is
component a_si_b
	port (X1,X2:in std_logic;
	Y1:out std_logic);
end component a_si_b;
component a_sau_b
	port (X3,X4:in std_logic;
	Y2:out std_logic);
end component a_sau_b; 
component inv
	port (X:in std_logic;
	NX:out std_logic);
end component inv;
signal t_and1,t_and2,t_i1,t_i2: std_logic;
begin  
	U1: inv port map(B,t_i1);
	U2: a_si_b port map(A,t_i1,t_and1);
	U3: inv port map(A,t_i2);
	U4: a_si_b port map(t_i2,B,t_and2);
	U5: a_sau_b port map(t_and1,t_and2,Y);
end arhi;
