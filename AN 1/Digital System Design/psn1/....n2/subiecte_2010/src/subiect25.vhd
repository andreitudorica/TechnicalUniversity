--26. Memorie FIFO 4 x 4 bi—i
library ieee;
use numeric_bit.all;
use std_logic_1164.all;
entity fifo is  
	port (s : in bit;
	a: in bit_vector (0 to 3);
	q: out bit_vector (0to 3);
	plin, gol : out bit);
end fifo;
architecture arh1 of fifo is 
type matrice is array (0 to 3) of bit_vector (0 to 3);
signal memorie :matrice;
signal index :integer:=-1;
begin
	process (s,a)
	begin
		if (s='1') then 
			memorie (index+1)<=a;
			index<=index+1;
		else if (s='0' and index>-1) then 
			q<=memorie (0);
			memorie (0)<=memorie (1);
			memorie (1)<=memorie (2);
			memorie (2)<=memorie (3);
			memorie (3)<="0000";
			index<=index-1;
		end if;
		end if;
	end process;
	process (index) 
	begin 
		if (index=3) then 
			plin<='1';
		else
			plin<='0';
		end if;
		if (index=-1) then 
			gol<='1';
		else 
			gol<='0';
		end if ;
		end process;
		end arh1;
		
		
		
	
	