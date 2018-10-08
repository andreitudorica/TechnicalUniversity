library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

entity inmultire is
	port (SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0);  
	y: out std_logic_vector (7 downto 0));	
end entity;	
	
architecture multiplication of inmultire is 
begin				 
	process(SEL,a,b)
variable s0,s1,s2,s3: std_logic_vector (7 downto 0); 
 begin
			if(SEL="10") then
	 		y <= "00000000"; s0 := "00000000"; s1 := "00000000"; s2 := "00000000"; s3 := "00000000";              -- initializam vectorii cu 0
			s0(0) := b(0) and a(0); s0(1) := b(0) and a(1); s0(2) := b(0) and a(2); s0(3) := b(0) and a(3);		  -- in fiecare vector incarcam rezultatul de inmultire dintre o cifra a lui b cu tot numarul a
			s1(1) := b(1) and a(0); s1(2) := b(1) and a(1); s1(3) := b(1) and a(2); s1(4) := b(1) and a(3);
			s2(2) := b(2) and a(0); s2(3) := b(2) and a(1); s2(4) := b(2) and a(2); s2(5) := b(2) and a(3);	      -- schimbam poziitiile pentru a evita folosirea unui registru de deplasaree
			s3(3) := b(3) and a(0); s3(4) := b(3) and a(1); s3(5) := b(3) and a(2); s3(6) := b(3) and a(3);
			y <= s0 + s1 + s2 + s3 after 5 ns;	 	                                                                          -- cei 4 vectori sunt adunati la rezultatul final
			end if;	  
			
   end process;
end architecture;			
	