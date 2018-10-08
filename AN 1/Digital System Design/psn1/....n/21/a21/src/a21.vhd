-------------------------------------------------------------------------------
--
-- Title       : a21
-- Design      : a21
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : a21.vhd
-- Generated   : Sat May 14 20:14:39 2011
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
--{entity {a21} architecture {a21}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity a21 is 
	port (	
	clk: in bit;
	data_in:in bit;
	ok:out  bit
	);
	
end a21;

--}} End of automatically maintained section

architecture a21 of a21 is
begin			
	process(clk)
	variable vector:bit_vector(3 downto 0);
	begin		
		if clk'event and clk='1' then
			vector:=vector srl 1;
			vector(3):=data_in;
		end if;
		ok<=vector (3) and vector(2) and (not vector(1)) and (not vector(0));
	end process;

	 -- enter your statements here --

end a21;
