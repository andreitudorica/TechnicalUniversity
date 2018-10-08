library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity num2 is
	port(clk:in std_logic; 
	c_out:out std_logic; 
	q:out std_logic_vector(1 downto 0));
end entity;

architecture n2 of num2 is
begin
	process(clk)
	variable a:std_logic_vector(1 downto 0):="11";
	begin									   
		if clk='1' and clk'event then
			a:=a+1;
			c_out<=a(1) nand a(0);
		    q<=a;
		end if;
		
	end process;
end architecture;	
-----
library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use IEEE.std_logic_arith.all;

entity num8 is
	port(clk:in std_logic; 
	carry:out std_logic; 
	Q:out std_logic_vector(7 downto 0));
end entity;

architecture n8 of num8 is
signal a1,a2,a3,a4:std_logic;
component num2 
	port(clk:in std_logic; 
	c_out:out std_logic; 
	q:out std_logic_vector(1 downto 0));
end component;
begin
	com1: num2 port map(clk,a1,Q(1 downto 0));
	com2: num2 port map(a1,a2,Q(3 downto 2));
	com3: num2 port map(a2,a3,Q(5 downto 4));
	com4: num2 port map(a3,a4,Q(7 downto 6));
end architecture;	