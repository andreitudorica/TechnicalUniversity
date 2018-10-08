--**********************************************************************--
-- file : e:\my designs\datapath\src\MUX.vhd
-- created Wed Feb 10 14:36:07 1999
-- from : D:\TEMP\tmp2F2.tmp
-- by ITF2VHD generator version 1.0
--**********************************************************************--

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {MUX} architecture {MUX}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity MUX is
	 generic(
		S : NATURAL := 15
	    );
	 port(
		 -- OUT --
		 D_OK : out STD_LOGIC_VECTOR(S downto 0);
		 -- IN --
		 D_1 : in STD_LOGIC_VECTOR(S downto 0);
		 D0_GT_D1 : in STD_LOGIC;
		 D_0 : in STD_LOGIC_VECTOR(S downto 0)
	     );
end MUX;

--}} End of automatically maintained section

architecture MUX of MUX is
begin
	-- enter your statements here --	 
	D_OK <= D_0 when D0_GT_D1 = '1' else D_1;

end MUX;
