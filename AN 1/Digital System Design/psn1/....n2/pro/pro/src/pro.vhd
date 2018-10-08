library	IEEE;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity numardep is  
	port(clk: in bit;	
		num: out bit);
end numardep;



architecture numaratoruldep of numardep is
	signal bitii_mei: std_logic_vector(30 downto 0):=(others=>'0');
	signal biti:bit_vector(30 downto 0):=(others=>'0');
begin 
	
	process(clk)	  
		
	begin
		if (clk'event and clk='1') then
			bitii_mei<=bitii_mei+1;
			biti<=to_bitvector(bitii_mei);
		end if;
		num<=biti(2) and biti(1) and biti(0);--num<=biti(30)
	end process;
	
end numaratoruldep;
--
library IEEE;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity numaraf is  
	port(clk: in bit;	
		num: out bit);
end numaraf;

architecture numaratorulaf of numaraf is
	signal bitii_mei: std_logic_vector(15 downto 0):=(others=>'0');
	signal biti:bit_vector(15 downto 0):=(others=>'0');
begin 
	
	process(clk)	  
		
	begin
		if (clk'event and clk='1') then
			bitii_mei<=bitii_mei+1;
			biti<=to_bitvector(bitii_mei);
		end if;
		num<=biti(0);		   --num<=biti(15);
	end process;
	
end numaratorulaf;
--
entity deplasare is
	port(num,en,s1,s0:in bit;
		af4,af3,af2,af1:out bit_vector(2 downto 0));
end entity;

architecture fct_depla of deplasare is
begin
	process(num,s1,s0)
		variable a:bit_vector(23 downto 0):="000000000000001010011100";
		variable v:integer:=0; 
	begin
		if num='1' and num'event then
			if en='1' then
				if s1='0' and s0='0' then
					a:=a rol 3;
				elsif s1='0' and s0='1' then
					a:=a ror 3;
				elsif s1='1' and s0='0' then  
					a:="001010011100000000000000";
				elsif s1='1' and s0='1' then 
					if v=0 then  a:="000000000000001010011100";
						v:=v+1;
					elsif v>0 and v<9 then a:=a rol 3; 
						v:=v+1;
					elsif v>=9 and v<17 then a:=a ror 3;
						v:=v+1;
						if v=17 then v:=1; end if;
					end if;
				end if;
			end if;
		end if;
		af4<=(a(23)& a(22)& a(21));
		af3<=(a(20)& a(19)& a(18));
		af2<=(a(17)& a(16)& a(15));
		af1<=(a(14)& a(13)& a(12));  																		  
	end process;
end architecture;	
--


entity decodificatorpr is
	port(a4: in bit_vector(2 downto 0);
		a3: in bit_vector(2 downto 0);
		a2: in bit_vector(2 downto 0);
		a1: in bit_vector(2 downto 0);
		iesirede1: out bit_vector(0 to 6);
		iesirede2: out bit_vector(0 to 6);
		iesirede3: out bit_vector(0 to 6);
		iesirede4: out bit_vector(0 to 6));
	
end decodificatorpr;

architecture proiect of decodificatorpr is
begin
	process(a1,a2,a3,a4) 
	begin
		case a1 is	   
			when "001" => iesirede1<="1000111"; 
			when "010" => iesirede1<="1100111";
			when "011" => iesirede1<="1011110";
			when "100" => iesirede1<="1110111";
			when others => iesirede1<="0000000";
		end case;
		case a2 is	   
			when "001" => iesirede2<="1000111"; 
			when "010" => iesirede2<="1100111";
			when "011" => iesirede2<="1011110";
			when "100" => iesirede2<="1110111";
			when others => iesirede2<="0000000";
		end case;
		case a3 is	   
			when "001" => iesirede3<="1000111"; 
			when "010" => iesirede3<="1100111";
			when "011" => iesirede3<="1011110";
			when "100" => iesirede3<="1110111";
			when others => iesirede3<="0000000";
		end case;
		case a4 is	   
			when "001" => iesirede4<="1000111"; 
			when "010" => iesirede4<="1100111";
			when "011" => iesirede4<="1011110";
			when "100" => iesirede4<="1110111";
			when others =>iesirede4<="0000000";
		end case;
	end process;		
	
end proiect;


--entity afis is		 
--	port( 
--		intrare1: in bit_vector(0 to 6);	
--		intrare2: in bit_vector(0 to 6);
--		intrare3: in bit_vector(0 to 6);
--		intrare4: in bit_vector(0 to 6);
--		clk:in bit;
--		an1: out bit;  
--		an2: out bit;
--		an3: out bit;
--		an4: out bit;
--		iesire: out bit_vector(0 to 6));
--	
--end afis;
--
--architecture afisoare of afis is
--begin  
--	process(intrare1,intrare2,intrare3,intrare4,clk)
--		variable count_an:bit_vector(1 downto 0):="00"; 
--	begin  
--		
--		if clk'event and clk='1' then
--			if count_an="00" then
--				an1<='0';an2<='1';an3<='1';an4<='1';
--				iesire<=intrare1;
--				count_an:="01";
--			else
--				if count_an="01" then
--					an1<='1';an2<='0';an3<='1';an4<='1';
--					iesire<=intrare2;
--					count_an:="10";
--				else
--					if count_an="10" then
--						an1<='1';an2<='1';an3<='0';an4<='1';
--						iesire<=intrare3;
--						count_an:="11";
--					else
--						if count_an="11" then
--							an1<='1';an2<='1';an3<='1';an4<='0';
--							iesire<=intrare4;
--							count_an:="00";
--						end if;
--					end if;
--				end if;
--			end if;
--		end if;
--		
--	end process;
--	
--end afisoare;

------------------------
------------------------
library	IEEE;
use IEEE.std_logic_arith.all; 
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;

entity tot is 
	port (clk,s0,s1,en:in bit;
		iesire: out bit_vector(0 to 6);
		an1,an2,an3,an4:out bit);	 
end entity tot;		
architecture struct of tot is 

component numardep
	port(clk: in bit;	
		num: out bit);
end component ;	

component numaraf
	port(clk: in bit;	
		num: out bit);
end component ;


component deplasare 
	port(num,en,s1,s0:in bit;
		af4,af3,af2,af1:out bit_vector(2 downto 0));
end component deplasare;  

component decodificatorpr 
	port(a4: in bit_vector(2 downto 0);
		a3: in bit_vector(2 downto 0); 
		a2: in bit_vector(2 downto 0);
		a1: in bit_vector(2 downto 0);
		iesirede1: out bit_vector(0 to 6);
		iesirede2: out bit_vector(0 to 6);
		iesirede3: out bit_vector(0 to 6);
		iesirede4: out bit_vector(0 to 6));
	
end component decodificatorpr;	 

--component afis 		 
--	port(intrare1: in bit_vector(0 to 6);	
--		intrare2: in bit_vector(0 to 6);
--		intrare3: in bit_vector(0 to 6);
--		intrare4: in bit_vector(0 to 6);
---		clk:in bit;
		--an1: out bit;
		--an2: out bit;
--		an3: out bit;
--		an4: out bit;
--		iesire: out bit_vector(0 to 6));
--	
--	
--end component afis;	 

signal num1:bit;
signal num2:bit;
signal aft3,aft2,aft1,aft4:bit_vector(2 downto 0);
signal iesiredet1:bit_vector(0 to 6);
signal iesiredet2:bit_vector(0 to 6);
signal iesiredet3:bit_vector(0 to 6);
signal iesiredet4:bit_vector(0 to 6);

begin  
c1: numardep port map (clk,num1);
c4: numaraf port map (clk,num2);
c2: deplasare port map(num1,en,s1,s0,aft4,aft3,aft2,aft1);
c3: decodificatorpr port map(aft4,aft3,aft2,aft1,iesiredet1,iesiredet2,iesiredet3,iesiredet4);
--c4: afis port map(iesiredet1,iesiredet2,iesiredet3,iesiredet4,num1,an1,an2,an3,an4,iesire);	   


AFISAS:process(num2)
variable count_an:bit_vector(1 downto 0):="00"; 
	begin  
		if num2'event and num2='1' then
			if count_an="00" then
				an1<='0';an2<='1';an3<='1';an4<='1';
				iesire<=iesiredet1;
				count_an:="01";
			else
				if count_an="01" then
					an1<='1';an2<='0';an3<='1';an4<='1';
					iesire<=iesiredet2;
					count_an:="10";
				else
					if count_an="10" then
						an1<='1';an2<='1';an3<='0';an4<='1';
						iesire<=iesiredet3;
						count_an:="11";
					else
						if count_an="11" then
							an1<='1';an2<='1';an3<='1';an4<='0';
							iesire<=iesiredet4;
							count_an:="00";
						end if;
					end if;
				end if;
			end if;
		end if;
		
	end process AFISAS;


end architecture struct;

