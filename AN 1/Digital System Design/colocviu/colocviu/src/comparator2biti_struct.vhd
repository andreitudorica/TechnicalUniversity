---------------------------------------------------------------------------------------------------
--
-- Title       : comp
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : comparator2biti_struct.vhd
-- Generated   : Sun May 23 16:24:59 2010
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
--{entity {comp} architecture {a_struct}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity comp is	 
	port (I,J:in std_logic_vector(1 downto 0);
	less:out std_logic;
	gr:out std_logic;
	eq:out std_logic);
end comp;

--}} End of automatically maintained section

architecture a_struct of comp is	  
component and4 
	port(x1,x2,x3,x4:in std_logic;
		y:out std_logic);
end component and4;
component a_si_b
	port (X1,X2:in std_logic;
	Y1:out std_logic);
end component a_si_b;
component inv
	port (X:in std_logic;
	NX:out std_logic);
end component inv;
component sau_ex
	port (A,B:in std_logic;
	Y:out std_logic); 
end component sau_ex;	  
component or6	
	port(a1,a2,a3,a4,a5,a6:in std_logic;
	p:out std_logic);
end component or6;
signal xor1,xor2,nxor1,nxor2,ni0,ni1,nj0,nj1,c1,c2,c3,c4,c5,c6,nless,neq,less_temp,eq_temp:std_logic;
begin
	U1: sau_ex port map(I(1),J(1),xor1);
	U2: sau_ex port map(I(0),J(0),xor2);
	U21: inv port map(xor1,nxor1);
	U22: inv port map(xor2,nxor2);
	U3: a_si_b port map(nxor1,nxor2,eq);
	U4: inv port map(I(0),ni0);
	U5: inv port map(I(1),ni1);
	U6: inv port map(J(0),nj0);
	U7: inv port map(J(1),nj1);
	U8: and4 port map(ni1,ni0,nj1,J(0),c1);
	U9: and4 port map(ni1,ni0,J(1),nj0,c2);
	U10: and4 port map(ni1,ni0,J(1),J(0),c3);
	U11: and4 port map(ni1,I(0),J(1),nj0,c4);
	U12: and4 port map(ni1,I(0),J(1),J(0),c5);
	U13: and4 port map(I(1),ni0,J(1),J(0),c6);
	U14: or6 port map(c1,c2,c3,c4,c5,c6,less);
	U15: a_si_b port map(nxor1,nxor2,eq_temp);
	U16: or6 port map(c1,c2,c3,c4,c5,c6,less_temp);
	U17: inv port map(less_temp,nless);
	U18: inv port map(eq_temp,neq);
	U19: a_si_b port map(nless,neq,gr);
end a_struct;

architecture a_comport of comp is
begin
	compara: process(I,J)
	begin
		if I=J then 
			eq<='1';
			less<='0';
			gr<='0';
		elsif I<J then
			eq<='0';
			less<='1';
			gr<='0';
		else eq<='0';
			less<='0';
			gr<='1';
		end if;
		end process;
end architecture a_comport;
		
			
