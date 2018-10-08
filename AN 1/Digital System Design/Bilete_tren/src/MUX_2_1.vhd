library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity MUX_2_1 is
	generic( N:natural:=9);
	port(A,B:in std_logic_vector(N-1 downto 0);
	SEL:in std_logic;
	Y:out std_logic_vector (N-1 downto 0));
end MUX_2_1;

architecture multiplexare_Nbiti of MUX_2_1 is
begin
	process(SEL,A,B)
	begin
	if SEL='0' then Y<=A;
	else
		Y<=B;
	end if;
	end process;
end multiplexare_Nbiti;
