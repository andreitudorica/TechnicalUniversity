

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use numeric_bit.all;   

entity memfifo is  
	port( a:in bit_vector(0 to 3);
	q:out bit_vector(0 to 3);
	s,clk:in bit;
	plin,gol:out bit);
end memfifo;


architecture arhmemfifo of memfifo is	
type matrice is array (0 to 7) of bit_vector (0 to 3);
signal mem:matrice;
signal index:integer:=-1;
begin
	process(s,a,clk)
	
	begin  
		if(clk='1' and clk'event) then
		 if(s='1' and index <8) then	
		  mem(index+1)<=a;
		  index<=index+1;
		 else 

			if(s='0'and index>-1) then
				q<=mem(0);
				mem(0)<=mem(1);
				mem(1)<=mem(2);
				mem(2)<=mem(3);
				mem(3)<=mem(4);
				mem(4)<=mem(5);
				mem(5)<=mem(6);
				mem(6)<=mem(7);
				mem(7)<="0000";
				index<=index-1;
			end if;
		end if;	 
		end if;
		end process;
	process(index)																						   
	begin
		if(index=7) then
		  plin<='1';
		else
			plin<='0';
		end if;
		
		if (index=-1) then
			gol<='1';
		else
			gol<='0';
		end if;
		end process;
		
end arhmemfifo;
