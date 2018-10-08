library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity sumator_scazator is
	port(A,B:in std_logic_vector(8 downto 0);
	SEL:in STD_LOGIC;
	C:out std_logic;
	REZ:out std_logic_vector(8 downto 0));
end sumator_scazator;

architecture operatie of sumator_scazator is
signal y:std_logic_vector (8 downto 0);
component FA is
	generic (N: natural:=9);
	port(A, B:in STD_LOGIC_VECTOR (N-1 downto 0);
	CARRY_IN :in STD_LOGIC;
	SUM: out STD_LOGIC_VECTOR(N-1 downto 0);
	CARRY_OUT:out std_logic);
end component FA;
begin  
	process(B,SEL)
	variable temp:std_logic_vector (8 downto 0);
	begin
  	for I in B'RANGE loop
				temp(I):=B(I) xor SEL;
	end loop;
	y<=temp;
	end process;
	
	Ad: FA port map (A,y,SEL,REZ,C);
	
	
end operatie;
