

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity entxor is
	port(a,b:in bit;
	     y:out bit);	
end entxor;

architecture arhxor of entxor is
begin
	y<=a xor b;
end architecture arhxor;


entity registru is
	port(mode,ser:in bit;
	     a:inout bit_vector (3 downto 0);
		 q:inout bit_vector(3 downto 0));
end registru;		 

architecture arhregistru of registru is	  
signal clkl,clks:bit;
begin 		
	CLOCK:process  
	begin
	clkl<='0'; clks<='0';
	wait for 50 ns;	
	clkl<='1'; clks<='1';
	wait for 50 ns;
	end process CLOCK; 
	process(clkl,clks,mode,a)  
	begin
		if mode='1' then
			if(clkl='1' and clkl'event) then
				q<=a;
			end if;
		else   
			if(mode='0') then
			  if(clks='1' and clks'event) then
				q(0)<=q(1);
				q(1)<=q(2);
				q(2)<=q(3);
				q(3)<=ser;
			  end if;	
			end if;	
			end if;
	end process;
	end arhregistru;
	
	---------------------------------------------
	
	entity final is
		port(mode:in bit;
	     a:inout bit_vector (3 downto 0);
		 q:inout bit_vector(3 downto 0));
	end final;	 
				
	architecture arhfinal of final is 
	
	component entxor 
	port(a,b:in bit;
	     y:inout bit);	
    end component entxor; 
	
	component  registru 
	port(mode,ser:in bit;
	     a:inout bit_vector (3 downto 0);
		 q:inout bit_vector(3 downto 0));
    end component registru;		
	
	signal x:bit;
	
	begin
		u1: registru port map(mode,x,a,q);
		u2: entxor port map(q(0),q(3),x); 

end arhfinal;
