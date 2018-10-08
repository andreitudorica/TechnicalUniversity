LIBRARY IEEE;
USE IEEE.std_logic_1164.all; 
use work.VCOMPONENTS.all;

ENTITY simple_gate IS
	PORT (OUT_GATE : out std_logic;
		IN1_GATE :in std_logic;
		IN2_GATE :in std_logic;
		IN3_GATE :in std_logic		
		);	
END simple_gate;

ARCHITECTURE simple_gate OF simple_gate IS
BEGIN
	
	AND3_0: AND3
	PORT MAP ( Y => OUT_GATE, IN1 => IN1_GATE, IN2 => IN2_GATE, IN3 => IN3_GATE);
END simple_gate;
