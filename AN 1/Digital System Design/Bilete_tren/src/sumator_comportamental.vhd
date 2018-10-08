library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all; 

entity sumator_9b is
	port(A,B:in std_logic_vector(8 downto 0);
	CI:in STD_logic;
	S:OUT STD_LOGIC_VECTOR(8 downto 0));
end sumator_9b;
architecture comportamental of sumator_9b is
signal temp:std_logic_vector(9 downto 0):="0000000000";
begin
	S<=A+B+CI;
end comportamental;
