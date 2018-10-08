---------------------------------------------------------------------------------------------------
--
-- Title       : dmux
-- Design      : colocviu
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : Dmux_generics.vhd
-- Generated   : Sun May 23 15:49:46 2010
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
--{entity {dmux} architecture {a_dmux}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity dmux is
	generic (n:natural :=3);
	port (I:in std_logic; 
	e:in std_logic;
	sel:in std_logic_vector(n-1 downto 0);
	Y:out std_logic_vector(2**n-1 downto 0));
end dmux;

--}} End of automatically maintained section

architecture a_dmux of dmux is
begin					
	demux:process(I,e,sel)	 
	variable index,doi_la_i:natural;
	begin
		if e='0' then 
			for i in 0 to 2**n-1 loop
				Y(i)<='0';
			end loop;
		else index:=0; 
			doi_la_i:=1;
			for i in 0 to n-1 loop
				index:=index+doi_la_i*(natural'val(std_logic'pos(sel(i)))-2);
				doi_la_i:=doi_la_i*2;
			end loop;
			Y(index)<=I;
			for i in 0 to 2**n-1 loop
				if i/=index then Y(i)<='0';	  
				end if;
				end loop;
		end if;
		end process;

end a_dmux;
