-------------------------------------------------------------------------------
--
-- Title       : unu
-- Design      : unu
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : unu.vhd
-- Generated   : Sun May  8 13:38:50 2011
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
--{entity {unu} architecture {arhitectura_unu}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity unu is
	port(
		A,B,C,D			:in std_logic;
		W,X,Y,Z			:out std_logic
		);
end unu;

--}} End of automatically maintained section

architecture arhitectura_unu of unu is 
	component si  
		port(
			A,B:in std_logic;
			F:out std_logic);
	end component;
	component si_3
		port(
			A,B,C:in std_logic;
			F:out std_logic
			);
	end component;
	component inversor
		port(
			A:in std_logic;
			F:out std_logic);
	end component;
	component sau_2
		port(
			A,B:in std_logic;
			F:out std_logic);
	end component;
	component sau_3
		port(
			A,B,C:in std_logic;
			F:out std_logic);
	end component;
	signal a_inversat,b_inversat,c_inversat,d_inversat:std_logic;
	signal cd_negat,cd_normal,A_C_inv,B_D,C_D,B_C_inv_D_inv,B_inv_C_inv_D,B_inv_C:std_logic;
begin
	
	U1:inversor port map(A,a_inversat);
	U2:inversor port map(B,b_inversat);
	U3:inversor port map(C,c_inversat);
	U4:inversor port map(D,d_inversat);
	Z<=d_inversat; --Z;
	
	U5:si port map(c_inversat,d_inversat,cd_negat);
	U6:si port map(C,D,cd_normal);
	U7:sau_2 port map(cd_negat,cd_normal,Y); -- Y
	
	U8:si port map(A,c_inversat,A_C_inv);
	U9:si port map(B,D,B_D);
	U10:si port map(C,B,C_D);
	U11:sau_3 port map(A_C_inv,B_D,C_D,W); --W
	
	U12:si_3 port map(B,c_inversat,d_inversat,B_C_inv_D_inv);
	U13:si_3 port map(b_inversat,c_inversat,D,B_inv_C_inv_D);
	U14:si port map(b_inversat,C,B_inv_C);
	U15:sau_3 port map(B_C_inv_D_inv,B_inv_C_inv_D,B_inv_C,X); --X
	
end arhitectura_unu;
