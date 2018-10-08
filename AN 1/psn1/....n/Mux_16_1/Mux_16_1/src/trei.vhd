-------------------------------------------------------------------------------
--
-- Title       : trei
-- Design      : Mux_16_1
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : trei.vhd
-- Generated   : Sun May  8 14:39:33 2011
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
--{entity {trei} architecture {arhitectura_trei}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity trei is
	generic (nr_intrari:Natural:=3);
	port(  
	selectii:in bit_vector(nr_intrari downto 0);
	intrari:in bit_vector(2**(nr_intrari+1)-1 downto 0);
	y:out bit
	);
end trei;

--}} End of automatically maintained section

architecture arhitectura_trei of trei is
begin
	
	process(intrari,selectii)
	begin		
		
	if selectii="0000" then  y<=intrari(0); end if;
	if selectii="0001" then  y<=intrari(1); end if;
	if selectii="0010" then  y<=intrari(2); end if;
	if selectii="0011" then  y<=intrari(3); end if;
	if selectii="0100" then  y<=intrari(4); end if;
	if selectii="0101" then  y<=intrari(5); end if;
	if selectii="0110" then  y<=intrari(6); end if;
	if selectii="0111" then  y<=intrari(7); end if;
	if selectii="1000" then  y<=intrari(8); end if;
	if selectii="1001" then  y<=intrari(9); end if;
	if selectii="1010" then  y<=intrari(10); end if;
	if selectii="1011" then  y<=intrari(11); end if;
	if selectii="1100" then  y<=intrari(12); end if;
	if selectii="1101" then  y<=intrari(13); end if;
	if selectii="1110" then  y<=intrari(14); end if;
	if selectii="1111" then  y<=intrari(15); end if;
		

	end process;
	
end arhitectura_trei;
