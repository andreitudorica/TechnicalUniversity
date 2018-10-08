---------------------------------------------------------------------------------------------------
--
-- Title       : muxg
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : MUX_generics.vhd
-- Generated   : Sun May 23 14:03:19 2010
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
--{entity {muxg} architecture {a_muxg}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all; 
use IEEE.STD_LOGIC_UNSIGNED.all;

entity muxg is	
	generic (n:natural :=3);
	port (I:in std_logic_vector(2**n-1 downto 0);
	sel:in std_logic_vector(n-1 downto 0);
	Y:out std_logic);
end muxg;

--}} End of automatically maintained section

architecture a_muxg of muxg is 
begin
	MUX: process(I,sel)	
	variable index,doi_la_i:natural;
	begin
		index:=0;
		doi_la_i:=1;
		for i in 0 to n-1 loop
			index:=index+doi_la_i*(natural'val(std_logic'pos(sel(i)))-2);  
			doi_la_i:=doi_la_i*2;
		end loop;
			
		Y<=I(index);
	end process;

end a_muxg;
