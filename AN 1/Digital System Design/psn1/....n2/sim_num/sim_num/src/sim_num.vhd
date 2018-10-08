  --19. Modul de simulare pt. numarator sincron pe 2 biti
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use numeric_bit.all; 

entity sim_num is 
	port(clk,r,load:in std_logic;	
	      a:in unsigned (1 downto 0);
	     q:inout unsigned (1 downto 0));
end sim_num;


architecture arhsim_num of sim_num is
begin	
	process(clk,r)
	begin
	if r='1' then 
		q<="00";
	else
		if clk='1' and clk'event then
			if load='1' then q<=a;
			else
				q<=q+1;
			end if;
			end if;
		end if;
	end process;
end arhsim_num;

------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use numeric_bit.all; 


entity simulare is
end simulare;

architecture arhsim of simulare is

component sim_num 
	port(clk,r,load:in std_logic;	
	      a:in unsigned (1 downto 0);
	     q:inout unsigned (1 downto 0));
end component sim_num;

signal clk,r,load:std_logic;
signal a:unsigned(1 downto 0); 
signal q:unsigned(1 downto 0);
begin	  
	ust: sim_num port map(clk,r,load,a,q);
	process (clk)
	begin
		if clk='U' then clk<='0';
		else clk<=not clk after 15 ns;
		end if;
	end process;
	
r<='1','0' after 15 ns;
--load<='0','1' after 20 ns,'0' after 30 ns;
stim1: process		 
begin
	load<='0'; wait for 3 ns;
	load<='1'; wait for 30 ns;
	load<='0'; wait;
end process stim1;
end arhsim;
