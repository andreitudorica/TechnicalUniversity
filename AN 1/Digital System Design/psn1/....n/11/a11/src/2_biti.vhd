-------------------------------------------------------------------------------
--
-- Title       : \2_biti\
-- Design      : a11
-- Author      : Microsoft
-- Company     : Microsoft
--
-------------------------------------------------------------------------------
--
-- File        : 2_biti.vhd
-- Generated   : Mon May 16 22:00:24 2011
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
--{entity {\2_biti\} architecture {arhitectura_2_biti}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity \2_biti\ is
	port(
	clk:in std_logic;
	carry:out std_logic;
	outputs_com:out std_logic_vector (1 downto 0)
	);
end \2_biti\;

--}} End of automatically maintained section

architecture arhitectura_2_biti of \2_biti\ is
begin
	process(clk)
	variable var_a:std_logic_vector(1 downto 0):="00";
	variable var_carry:std_logic:='0';
	variable logic_1:std_logic;
	--variable logic_2:std_logic;
	begin		 
		if clk'event and clk='1' then
			var_a:=var_a+1;
			outputs_com<=var_a;
			--	  
			logic_1:=(not var_a(1)) and (not(var_a(0)));
			var_carry:=logic_1;  
			--
			carry<=var_carry;
		end if;
	end process;
	 -- enter your statements here --

end arhitectura_2_biti;
