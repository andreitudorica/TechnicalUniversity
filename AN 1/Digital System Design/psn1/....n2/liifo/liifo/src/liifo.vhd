--26. Memorie LIFO 4 x 4 bi—i			
library ieee;
use numeric_bit.all;
use std_logic_1164.all;
entity lifo is 
	port (s,clk : in bit;
	a : in bit_vector (0 to 3);
	q: out bit_vector (0 to 3);
	plin, gol : out bit);
end lifo;
architecture arh of lifo is 
type matrice is array (0 to 7) of bit_vector (0 to 3);
signal memorie : matrice;
signal index : integer:=-1;
begin
	process (s, a,clk)
	begin 		
		if clk='1' and clk'event then
		if (s='1') then
			memorie (index+1)<=a;
			index<=index+1;		
		else if (s='0' and index > -1) then 
			q<=memorie (index);	
			memorie(7)<=memorie(6);
			memorie(6)<=memorie(5);
			memorie(5)<=memorie(4);
			memorie(4)<=memorie(3);
			memorie(3)<=memorie(2);
			memorie(2)<=memorie(1);	 
			memorie(1)<=memorie(0);
			memorie(0)<="0000";
			index<=index-1;
		end if ;
		end if;	 
		end if;
	end process;
	process (index)
	begin 
		if (index=7) then plin<='1';
		else plin<='0';
		end if;
			if (index=-1) then gol<='1';
			else gol<='0';
			end if;	
			end process;
		end arh;
		
			
	