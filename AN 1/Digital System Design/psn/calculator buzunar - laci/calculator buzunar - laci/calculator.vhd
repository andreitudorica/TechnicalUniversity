library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;	
use ieee.numeric_std.all;
use ieee.numeric_bit.all;
use ieee.std_logic_unsigned.all;

entity calculator is
	port ( clk: in bit;	 ---clock de la buton	
		   clkprincipal : in bit; ---clock de pe placuta pentru afisaje
		   clkafis : buffer std_logic; ---clock pentru afisaje
		   reset: in bit;  ----de la buton
		   egal : in bit;
		   switch : in bit; --pentru alegerea operatiei	si resetarea numarului
		   numar: in std_logic_vector (3 downto 0);
		   operatie: in std_logic_vector(1 downto 0);
		   hanyad_marad : in bit;  --pentru alegerea restul impartirii(maradek) si rezultatul impartirii(hanyados)
		   --rezultat: inout std_logic_vector (15 downto 0);
		   anod : inout std_logic_vector (3 downto 0);	----activarea anodelor
		   seg_out : out std_logic_vector (6 downto 0)  ----pentru afisor
		   );
end calculator;

architecture calc of calculator is 	

signal rezult:integer:=0;
signal x:integer:=0;
signal rezultat: std_logic_vector (15 downto 0);

signal div1ms: integer:=0; ------ pentru divizor de frecventa
  
-----functie de conversie din intreg in 7 segmente----DECODIFICATOR-----
function int7seg (x:integer) return std_logic_vector is
variable dis7seg: std_logic_vector (6 downto 0);
begin
	   if x = 0 then dis7seg := "0000001";
	elsif x = 1 then dis7seg := "1001111";
	elsif x = 2 then dis7seg := "0010010";
	elsif x = 3 then dis7seg := "0000110";
	elsif x = 4 then dis7seg := "1001100";
	elsif x = 5 then dis7seg := "0100100";
	elsif x = 6 then dis7seg := "0100000";
	elsif x = 7 then dis7seg := "0001111";
	elsif x = 8 then dis7seg := "0000000";
	elsif x = 9 then dis7seg := "0000100";
	else dis7seg := "1111111";
end if;
return dis7seg;
end;
------------------------------------------------------------------------------------

-----------FUNCTIE DE CONVERSIE A NUMERELOR DIN BINAR IN BCD------------------------
function to_bcd ( bin : std_logic_vector(15 downto 0) ) return std_logic_vector is
			variable i : integer:=0;
			variable bcd : std_logic_vector(15 downto 0) := (others => '0');
			variable bint : std_logic_vector(15 downto 0) := bin;
			
			begin
				for i in 0 to 15 loop  -- repeating 16 times.
				bcd(15 downto 1) := bcd(14 downto 0);  --shifting the bits.
				bcd(0) := bint(15);
				bint(15 downto 1) := bint(14 downto 0);
				bint(0) :='0';
				
				
				if(i < 15 and bcd(3 downto 0) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(3 downto 0) := bcd(3 downto 0) + "0011";
				end if;
				
				if(i < 15 and bcd(7 downto 4) > "0100") then --add 3 if BCD digit is greater than 4.
				bcd(7 downto 4) := bcd(7 downto 4) + "0011";
				end if;
				
				if(i < 15 and bcd(11 downto 8) > "0100") then  --add 3 if BCD digit is greater than 4.
				bcd(11 downto 8) := bcd(11 downto 8) + "0011";
				end if;	
				
				if(i < 15 and bcd(15 downto 12) > "0100") then  --add 3 if BCD digit is greater than 4.
				bcd(15 downto 12) := bcd(15 downto 12) + "0011";
				end if;
				
				
			end loop;
			return bcd;
		end to_bcd;	 								
--------------------------------SFARSIT FUNCTIE DE CONVERSIE----------------------------------------------	  

-------------------------------FUNCTIE PENTRU IMPARTIRE-------------------------------------------------
function  divide  (a : std_logic_vector; b : std_logic_vector) return std_logic_vector is
variable a1 : std_logic_vector(a'length-1 downto 0):=a;
variable b1 : std_logic_vector(b'length-1 downto 0):=b;
variable p1 : std_logic_vector(b'length downto 0):= (others => '0');
variable i : integer:=0;

begin
for i in 0 to b'length-1 loop
p1(b'length-1 downto 1) := p1(b'length-2 downto 0);
p1(0) := a1(a'length-1);
a1(a'length-1 downto 1) := a1(a'length-2 downto 0);
p1 := p1-b1;
if(p1(b'length-1) ='1') then
a1(0) :='0';
p1 := p1+b1;
else
a1(0) :='1';
end if;
end loop;
return a1;

end divide;
---------------------------------SFARSIT FUNCTIE PENTRU IMPARTIRE----------------------------------------

begin  
------------------DIVIZOR DE FRECVENTA PENTRU AFISAJE DE 1ms------------------------	
p1_1ms:process(reset,clkprincipal)
	   begin
	   		if reset ='1' then
		   		div1ms<= 0;
		   		clkafis<='0';
	    	elsif clkprincipal'event and clkprincipal='1' then
		  		div1ms <= div1ms+1;
	   		end if;
			if div1ms = 250000 then
				clkafis <='1';
			elsif div1ms = 328000 then
				clkafis <='0';
			end if;
			if div1ms = 328000 then
				div1ms <= 0;
			end if;	
		end process;
-----------------------------------------------------------------------
display: process (clkafis,reset)
-----------SEMNALE PENTRU AFISAJ-----------
variable seg_out1: std_logic_vector (6 downto 0):="0000001";
variable seg_out2: std_logic_vector (6 downto 0):="0000001";
variable seg_out3: std_logic_vector (6 downto 0):="0000001";
variable seg_out4: std_logic_vector (6 downto 0):="0000001";
variable count2 : std_logic_vector (1 downto 0):="00";
-----------SEMNALE PENTRU NUMERE-----------------
variable q : std_logic_vector(15 downto 0) := (others => '0');	  
variable Decimal1: std_logic_vector(3 downto 0);	 ----0->9
variable Decimal2: std_logic_vector(3 downto 0);	 ----zece
variable Decimal3: std_logic_vector(3 downto 0);	 ----suta
variable Decimal4: std_logic_vector(3 downto 0);	 ----mie si minus
		   begin		
				if clkafis ='1' and clkafis'event then
					count2 := count2+1;
		  			if reset='1' then
						anod(0)<='0';anod(1)<='0';anod(2)<='0';anod(3)<='0'; 
						seg_out<= int7seg(0);
						count2:="00";
						Decimal1:="0000";
						Decimal2:="0000";
						Decimal3:="0000";
						Decimal4:="0000";
						q:="0000000000000000";
					    		 else					

					if switch='1' then 
				
						case operatie is 
							when "00" => seg_out<="0001000";  --A ->adunare abcdefg
							when "01" => seg_out<="0100100"; --S ->scadere
							when "10" => seg_out<="1001000"; --H ->Multire					
							when "11" => seg_out<="0011000"; --P ->Partire
							when others => null;
						end case;
								
					       		  else
				
					if rezultat="1111111111111111" then
					 	seg_out1:="0110000";
						seg_out2:="0110000";
						seg_out3:="0110000";
						seg_out4:="0110000";
													else	
				
	-----CONVERSIA NUMARULUI DIN BINAR IN BCD-----	
					q:=to_bcd(rezultat);
				
			--		Decimal1:=q(3 downto 0);
				
					Decimal1(0):=q(0);
					Decimal1(1):=q(1);
					Decimal1(2):=q(2);
					Decimal1(3):=q(3);

			--		Decimal2:=q(7 downto 4);

					Decimal2(0):=q(4);
					Decimal2(1):=q(5);
					Decimal2(2):=q(6);
					Decimal2(3):=q(7);	

			--		Decimal3:=q(11 downto 8);

					Decimal3(0):=q(8);
					Decimal3(1):=q(9);
					Decimal3(2):=q(10);
					Decimal3(3):=q(11);
				
					if rezult<0 then
					seg_out4:="1111110";  
								else
			--		Decimal4:=q(15 downto 12);
				
					Decimal4(0):=q(12);
					Decimal4(1):=q(13);
					Decimal4(2):=q(14);
					Decimal4(3):=q(15);
				
					seg_out4:=int7seg(conv_integer(Decimal4));	 --se converteste pe 7 segmente fiecare digit in parte
								
					end if;
					
					seg_out3:=int7seg(conv_integer(Decimal3));
					seg_out2:=int7seg(conv_integer(Decimal2));
					seg_out1:=int7seg(conv_integer(Decimal1));			
			        end if;
				
					if(anod(0)='0') then 
					anod(0)<='1';
					seg_out<= seg_out1;   
					anod(3)<='0';
					elsif (anod(3)='0') then 
					anod(3)<='1';
					seg_out<=seg_out2;   
					anod(2)<='0';
					elsif (anod(2)='0') then 
					anod(2)<='1';
					seg_out<=seg_out3;   
					anod(1)<='0';
					elsif (anod(1)='0') then 
					anod(1)<='1';
					seg_out<=seg_out4;  
					anod(0)<='0';
					end if;	 

				
				end if;
				end if;
			end if;
end process;			
-------------------VERIFICAREA DACA SUNTEM INCA IN INTERVAL-----------------------------------	
	process(x,rezult)
	begin
			if x<9999 then
				rezultat<=conv_std_logic_vector(x,16);
			else
				rezultat<="1111111111111111";
			end if;	
			if egal='1' then
				if rezult<9999 then
					rezultat<=conv_std_logic_vector(rezult,16);
				else
					rezultat<="1111111111111111";
				end if;
				if rezult>-999 then
					rezultat<=conv_std_logic_vector(abs(rezult),16);
				else
					rezultat<="1111111111111111";
				end if;
			end if;	
	end process;	
	
----------------------DESCRIREA CALCULATORULUI--------------------------		 	
process(clk)

variable hanyados:integer:=0;
variable maradek:integer:=0;
variable c:integer:=1;


	begin	
	 if clk'event and clk='1' then
	  if reset='1' then x<=0;	
		  				rezult<=0; 
		  				c:=1;
	  			   else
		if egal='0' then  
----------------INTRODUCEREA NUMARULUI--------------------	 		
			if switch='0' then
	 			x<=x*10+conv_integer(numar);
	 		end if;
	 		if switch='1' then
	 			x<=0;
	 		end if;
-----------SFARSIT INTRODUCEREA NUMARULUR-----------------			 
					else
----------------------OPERATIILE---------------------------				 	  
	 	  case operatie is
		 	when "00" => rezult<=rezult+x;		    --adunare
		 	when "01" => rezult<=rezult-x;		    --scadere
		 	when "10" => rezult<=rezult*x;	 	    --inmultire
		 	when "11" => if x=0 then
				 		 	rezult<=10000;
			 			 	    else  
				 		 if c=1 then
			 			 hanyados:=conv_integer(divide(conv_std_logic_vector(abs(rezult),16),conv_std_logic_vector(x,16)));	--impartire
						  if rezult<0 then
							  maradek:=(rezult+(hanyados*x))*(-1);
							  		  else
						      maradek:=rezult-(hanyados*x);
						  end if;
						 end if;
						 
						 if rezult<0 then
							  if hanyad_marad='0' then
						 		  rezult<=hanyados*(-1); 
							  					  else
								  rezult<=maradek*(-1);
							  end if;
							  		 else
							  if hanyad_marad='0' then
						 		  rezult<=hanyados; 
							  					  else
								  rezult<=maradek;
							  end if;
						end if;
						c:=c+1;
						end if;
			when others => null;
	 	  end case;			
----------------SFARSIT OPERATII---------------------------- 
		 end if;  
	  end if; 
	 end if;
	end process;   
end architecture calc;
	
	