library ieee;
use ieee.std_logic_1164.all;


entity full_adder is
	port (A, B, CARRY_IN: in STD_LOGIC;
			SUM, CARRY_OUT: out STD_LOGIC);
end full_adder;

Architecture ARHAS of full_adder is
signal INTER: STD_LOGIC;
begin					
	INTER<=A xor B;
	SUM<=INTER xor CARRY_IN;
	CARRY_OUT<= (A and B) or (INTER and CARRY_IN);
end ARHAS;

library ieee;
use ieee.std_logic_1164.all;


entity FA is
	generic (N: natural:=9);
	port(A, B:in STD_LOGIC_VECTOR (N-1 downto 0);
	CARRY_IN :in STD_LOGIC;
	SUM: out STD_LOGIC_VECTOR(N-1 downto 0);
	CARRY_OUT:out std_logic);
end FA;


architecture sumator_complet of FA is
component	full_adder is
	port (A, B, CARRY_IN: in STD_LOGIC;
			SUM, CARRY_OUT: out STD_LOGIC);
end component;
signal INT:STD_LOGIC_VECTOR( N-2 downto 0);
begin
	L1: for i in 0 to N-1 generate
	L2: if i=0 generate
	L3: full_adder port map (A(i), B(i), CARRY_IN, SUM(i), INT(i));
	end generate;
	L4: if (i>0) and (i<N-1) generate
		L5: full_adder port map (A(i), B(i), INT(i-1), SUM(i), INT(i));	
	end generate;
	L6: if (i=N-1) generate
		L7: full_adder port map(A(i), B(i), INT(i-1), SUM(i), CARRY_OUT);
	end generate;
	end generate;
end sumator_complet;