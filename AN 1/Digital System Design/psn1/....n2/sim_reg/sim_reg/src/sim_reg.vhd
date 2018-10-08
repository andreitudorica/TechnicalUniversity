

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use numeric_bit.all;
entity sim_reg is 
	port(load,clk,ds,dd,r:in std_logic;	
	a:in unsigned (7 downto 0); 
	q:inout unsigned (7 downto 0));	     
end sim_reg;



architecture arhsim_reg of sim_reg is
begin  
	process(clk,r)
	begin
	   if r='1' then q<="00000000";	
	else
		if clk='1' and clk'event then
			if load='1' then q<=a;
			else
				if dd='1' then
					q<=q srl 1;
				else 
					if ds='1' then
						q<=q sll 1;
					end if;
				end if;
				end if;
			end if;
			end if;
	 
  end process;
end arhsim_reg;
----------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use numeric_bit.all;

entity simulare is
end simulare;

architecture arh_sim of simulare is
component sim_reg is 
	port(load,clk,ds,dd,r:in std_logic;	
	a:in unsigned (7 downto 0); 
	q:inout unsigned (7 downto 0));	     
end component sim_reg; 

signal load,clk,ds,dd,r:std_logic;
signal a:unsigned (7 downto 0);  
signal q:unsigned (7 downto 0);	
begin 
	ust: sim_reg port map(load,clk,ds,dd,r,a,q);

	process(clk)
	 begin
	     if clk='U' then clk<='0';
	        else clk<=not clk after 3 ns;
	     end if;
	end process; 	
a<="00011011";
r<='1','0' after 5ns;	
load<='0','1' after 10 ns, '0' after 20 ns;
ds<='0','1' after 30 ns,'0' after 50 ns;
dd<='0','1' after 50 ns,'0' after 70 ns;

end arh_sim;	
	
