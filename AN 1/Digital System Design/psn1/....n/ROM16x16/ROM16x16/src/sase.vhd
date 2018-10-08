-------------------------------------------------------------------------------
--
-- Title       : sase
-- Design      : ROM16x16
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : sase.vhd
-- Generated   : Sun May  8 15:44:58 2011
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
--{entity {sase} architecture {arhitectura_sase}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sase is 
	port(
	adresa:in bit_vector(3 downto 0);
	clk:in bit;
	y:out bit_vector(15 downto 0)
	);
end sase;

--}} End of automatically maintained section

architecture arhitectura_sase of sase is
begin

	process(clk)
	type matrice is array(0 to 15) of bit_vector(15 downto 0);
	variable m:matrice;
	begin
		m(0):="0000000000011111";
		m(1):="1100000000011111";
		m(2):="1000000000011111";
		m(3):="1100000000011111";
		m(4):="1100000000011111";
		m(5):="1100000000011111";
		m(6):="1100000000011111";
		m(7):="1100000000011111";
		m(8):="1100000000011111";
		m(9):="1100000000011111";
		m(10):="1100000000011111";
		m(11):="1100000000011111";
		m(12):="1100000000011111";
		m(13):="1100000000011111";
		m(14):="1100000000011111";
		m(15):="1100000000011111";
		case adresa is 
			when "0000"=> y<=m(0);
			when "0001"=> y<=m(1);
			when "0010"=> y<=m(2);
			when "0011"=> y<=m(3);
			when "0100"=> y<=m(4);
			when "0101"=> y<=m(5);
			when "0110"=> y<=m(6);
			when "0111"=> y<=m(7);
			when "1000"=> y<=m(8);
			when "1001"=> y<=m(9);
			when "1010"=> y<=m(10);
			when "1011"=> y<=m(11);
			when "1100"=> y<=m(12);
			when "1101"=> y<=m(13);
			when "1110"=> y<=m(14);
			when "1111"=> y<=m(15);
			when others=>
		end case;
	end process;	

end arhitectura_sase;
