library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;

entity mult1 is
	port(
		 I_abs : in STD_LOGIC_VECTOR(30 downto 0);
		 I_sig : in STD_LOGIC_VECTOR(1 downto 0);
		 Out1 : out STD_LOGIC_VECTOR(30 downto 0)
	     );
end mult1;

architecture beh of mult1 is
begin
		Out1 <= CONV_STD_LOGIC_VECTOR ( SIGNED (I_sig) * SIGNED (I_abs(30 downto 0)),31); 
end beh;
