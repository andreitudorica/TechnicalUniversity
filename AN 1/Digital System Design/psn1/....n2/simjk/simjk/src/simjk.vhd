

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity simjk is	
	port(j,k,clk:in bit;
	     q,nq: inout bit);
end simjk;



architecture arhsimjk of simjk is  	
begin	
	
   process (clk)
   begin	   
   if clk='1' and clk'event	then
	   if j='0' and k='1' then
		   q<='0'; nq<='1';
	   else
		   if j='1' and k='0' then
			   q<='1'; nq<='0';
		   else
			   if j='1' and k='1' then
				   nq<=q; q<=not q;
	 		   end if;
		   end if;
		  end if;
	   end if; 
	    end process;
end arhsimjk;

------------------------------------------------------------

entity simulare is
end simulare;

architecture arhsim of simulare is	

  component simjk is	
	port(j,k,clk:in bit;
	     q,nq: inout bit);
end component simjk;

signal j,k,clk,q,nq:bit; 	

begin 
	ust: simjk port map (j,k,clk,q,nq); 
j<='0', '1' after 20 ns, '0' after 50 ns, '1' after 70 ns;
k<='0', '1' after 30 ns, '0' after 55 ns;
clk<='0','1' after 5 ns, '0' after 15 ns, '1' after 20 ns, '0' after 25 ns,'1' after 30 ns,'0' after 35 ns,'1' after 40 ns,'0' after 45 ns,'1' after 50 ns,'0' after 55 ns,'1' after 60 ns;
	
end arhsim;
