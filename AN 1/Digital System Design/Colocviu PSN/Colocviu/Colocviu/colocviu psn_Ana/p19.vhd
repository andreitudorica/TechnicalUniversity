library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;	
use IEEE.std_logic_arith.all;

entity num2 is
	port (pl,rst,clk : in std_logic;
		  nr_pl: in std_logic_vector (1 downto 0);
		  B: out  std_logic_vector (1 downto 0));
end entity;

architecture arh_num2 of num2 is
begin
	process (clk)
	variable A1: std_logic_vector(1 downto 0):="00"; 
	begin	   
	if clk='1' and clk'event then
	if rst='1' then B<="00";
	elsif pl='1' then B<=nr_pl;
		else
			 A1:=A1+1;
	B<=A1;
	end if;
	end if;
	
	end process;
end arh_num2;


library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;	
use IEEE.std_logic_arith.all;

entity ms_num2 is
end ms_num2;

architecture arh_ms_num2 of ms_num2 is
signal pl,rst :std_logic;	
signal clk :std_logic;
signal nr_pl, B : std_logic_vector (1 downto 0) :="00";
shared variable end_sim : boolean := false;
component num2
port (pl,rst,clk : in std_logic;
	 nr_pl: in std_logic_vector (1 downto 0);
	 B: out  std_logic_vector (1 downto 0));
end component;

begin
	UST: num2 port map (pl,rst,clk,nr_pl,B);
	
	process 
	begin
		if not(end_sim) then 
		 clk<='0';
		 wait for 10 ns;
		 clk<='1';
		 wait for 10 ns;
		else wait;
		end if;
	end process;
	
	process
	begin  
		if not(end_sim) then
		B<="00";
		wait for 20 ns;
		B<="01";
		wait for 20 ns;
		B<="10";	   
		wait for 20 ns;
		B<="11";
		wait for 20 ns;
		end_sim:=true;
		end if;
	end process;
end arh_ms_num2;
		