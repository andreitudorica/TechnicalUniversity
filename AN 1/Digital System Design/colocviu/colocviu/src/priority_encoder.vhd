---------------------------------------------------------------------------------------------------
--
-- Title       : enc
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : priority_encoder.vhd
-- Generated   : Wed May 19 20:50:46 2010
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
--{entity {enc} architecture {arh}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity enc is
	port (I:in std_logic_vector (9 downto 0);
		y: out std_logic_vector (3 downto 0));
end enc;

--}} End of automatically maintained section

architecture arh of enc is
begin	
	encoder: process(I)
	begin
		if I(9)='1' then
			y<="1001";
		elsif I(8)='1' then
			y<="1000";
		elsif I(7)='1' then 
			y<="0111";
		elsif I(6)='1' then
			y<="0110";
		elsif I(5)='1' then
			y<="0101";
		elsif I(4)='1' then 
			y<="0100";
		elsif I(3)='1' then
			y<="0011";
		elsif I(2)='1' then
			y<="0010";
		elsif I(1)='1' then 
			y<="0001";
		elsif I(0)='1' then
			y<="0000";
		else y<="0000";	
		end if;
	end process;	

end arh;
