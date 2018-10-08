
library IEEE;
use IEEE.STD_LOGIC_1164.all;
use numeric_bit.all;

entity secventa is 
	port(a,clk:in bit;
	     q: inout unsigned(1 downto 0));	
end secventa;


architecture arhsecventa of secventa is

signal y:bit_vector(3 downto 0);

begin			 
	
   process(a,clk)	
   begin  
	   if clk='1' and clk'event	 then
	   if y="1100" then  q<=q+1;
		   y(3)<=y(2);
	       y(2)<=y(1);
	       y(1)<=y(0); 
		   y(0)<=a;	
	   	 else
	  		y(3)<=y(2);
	       y(2)<=y(1);
	       y(1)<=y(0); 
		   y(0)<=a;	
		    
	  end if;
	   end if;
	end process;
end arhsecventa;
