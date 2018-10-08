--24. Generator de numere pseudoaleatoare pe 4 bi—i ñ descriere structural„
library ieee;
use std_logic_1164.all;
use numeric_bit.all;  
entity xor_b is 
	port (a,b: in bit;
	c: out bit);
end xor_b;
architecture arh_xor of xor_b is 
begin 
	c<=a xor b;
end arh_xor;
--regisru
entity registru is 
	port (a: inout bit_vector (3 downto 0);
	ser, mode, clks, clkl : in bit;
	q: inout bit_vector (3 downto 0));
end registru;
architecture arhreg of registru is
begin 
	process (clks, clkl, mode, a)
	begin 
		if (mode ='1') then 
			if (clkl='1' and clkl'last_value='0') then 
				q<=a;
			end if;
		else
			if (mode='0') then 
				if (clks='1' and clks'last_value='0') then
					--a(0)<="0000";
					q(0) <= q(1);
					q(1) <= q(2);
					q(2) <= q(3);
					q(3) <= ser;
					
					end if;
			end if;		 
		end if;
		end process;
	end arhreg;
	
			
entity gen_a is 
	port ( a: in bit_vector (3 downto 0);
	mode, clks, clkl : bit;
	q: out bit_vector (3 downto 0));
end gen_a; 

architecture arh_struct of gen_a is 
component xor_b is 
	port (a,b: in bit;
	c: inout bit);
end component;
component registru is 
	port (a: inout bit_vector (3 downto 0);
	ser, mode, clks, clkl : in bit;
	q: inout bit_vector (3 downto 0));
end component;
signal  x : bit;
signal w, u: bit_vector (3 downto 0);
begin
	reg : registru port map (u, x, mode, clks, clkl, w); 
	xor_a: xor_b port map (w(0), w(3), x);
end arh_struct;

	
	
	
	