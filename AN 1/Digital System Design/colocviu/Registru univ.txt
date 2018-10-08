library	IEEE;
use IEEE.std_logic_1164.all;

entity registru_universal is
	port ( A: in bit_vector (3 downto 0);
	sel: in bit_vector(1 downto 0);
	clk :in bit;
	Q: out bit_vector (3 downto 0));
end registru_universal;

architecture arh_registru of registru_universal is

begin
	process(A,sel,clk)
	variable  A1,Q1 : bit_vector (3 downto 0):="0000";
	begin
	A1:=A;
	if clk='1' and clk'event then
	if sel="01" then
		Q1:=Q1 srl 1; Q1(3):='0';
	elsif sel="10" then
		Q1:=Q1 sll 1; Q1(0):='0';
	elsif sel="11" then
		Q1(0):=A1(0);
		Q1(1):=A1(1);
		Q1(2):=A1(2);
		Q1(3):=A1(3);	  
	end if;	  
	end if;
	Q<=Q1;
	end process;
end arh_registru;