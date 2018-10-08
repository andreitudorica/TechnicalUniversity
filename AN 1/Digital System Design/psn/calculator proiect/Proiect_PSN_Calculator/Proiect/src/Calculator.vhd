library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity Calculator is
	port (CLOCK: in std_logic;
	Operand: in std_logic_vector(7 downto 0);  
	Operator : in bit_vector(3 downto 0); 
	Anod: out std_logic_vector(3 downto 0);
	Decod: out std_logic_vector(0 to 7);
	Rest:out std_logic_vector(7 downto 0));
end Calculator;

architecture Arh_Calc of Calculator is

component ALU is
	port (Semn:in bit_vector(3 downto 0);
	A: in STD_LOGIC_vector(15 downto 0);
	B: in STD_LOGIC_vector(7 downto 0);
	S: out STD_LOGIC_vector(15 downto 0):="0000000000000000";	 
	rest:out std_logic_vector(7 downto 0):="00000000");
end component;	

component Reg_mem is
port (Semn:in bit_vector(3 downto 0);
	A: in std_logic_vector(15 downto 0);  
	B: in std_logic_vector(7 downto 0);
	A_mem: out std_logic_vector(15 downto 0):="0000000000000000";
	B_mem: out std_logic_vector(7 downto 0):="00000000");
end component;

component afisoare is
	port(clk:in std_logic;					
		nr_zecimal1:in std_logic_vector(15 downto 0);
		anod:out std_logic_vector(3 downto 0);
		catod:out std_logic_vector(7 downto 0));
end component afisoare;	

signal B:std_logic_vector(7 downto 0);	 
signal A:std_logic_vector(15 downto 0);	
signal Rezultat :std_logic_vector(15 downto 0):="0000000000000000";	  
signal Restul:std_logic_vector(7 downto 0):="00000000";
begin	  							

    Memory: Reg_mem port map(Operator,Rezultat,Operand,A,B);  
	Calc: ALU port map (Operator,A,B,Rezultat,Restul);	
	Rest<=Restul;
	Afisare: afisoare port map(CLOCK,Rezultat,Anod,Decod);
end architecture;
