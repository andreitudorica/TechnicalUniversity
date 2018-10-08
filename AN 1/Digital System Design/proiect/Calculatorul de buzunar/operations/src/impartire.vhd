library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity impartire is
	port (	SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0);
	y: out std_logic_vector (7 downto 0));	
end entity;	

architecture division of impartire is 
begin				 
	process(SEL,a,b)
variable rest,cat: std_logic_vector (3 downto 0);
variable z: std_logic_vector (7 downto 0);
variable k:integer;
 begin
	 if(SEL="11") then 
		 if(b /= "0000") then			  -- verificam daca se face impartirea la 0 si afisam eroarea prin aprinderea tuturor ledurilor
	 		z:= "00000000";				  -- initializam restul,catul si vectorul z cu 0
			cat := "0000";
			rest := "0000";
			z := z+a;
			for k in 1 to 16 loop		   -- scadem repetat din z pe b pana vom obtine restul
			if (z >= b) then 	  
				z := z-b;  
				cat := cat + '1';		   -- numaram de cate ori am scazut pentru a creea catul
				end if;
			end loop;  
			rest := z(3 downto 0);		   -- ceea ce a ramas in z este restul impartirii
			
			y(7 downto 4) <= cat;		   -- catul este incarcat in ultimii 4 biti 
			y(3 downto 0) <= rest;		   -- restul este incarcat in primii 4 biti ai outputului
		else 
			y <="11111111" after 5 ns;					-- afisam semnul erorii
		end if;	
		if (a<b) then						 -- daca a < b atunci catul este 0 iar restul il reprezinta a
			y(7 downto 4) <= "0000" after 5 ns;
			y(3 downto 0) <= a after 5 ns;
		end if;	
	end if;	
			
   end process;
end architecture;	