library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity afisoare is
	port(clk:in std_logic;					
		nr_zecimal1:in std_logic_vector(15 downto 0);
		anod:out std_logic_vector(3 downto 0);
		catod:out std_logic_vector(7 downto 0));
end entity afisoare;

architecture arch_afisoare of afisoare is
component convertor is
	port(nr_binar:in std_logic_vector(15 downto 0); 
		nr_BCD:out std_logic_vector(15 downto 0));
end component;
component div_frec is
	port(clk:in std_logic;
		clk_div:out std_logic;
		clk_div_afis:out std_logic_vector(1 downto 0));
end component;
signal clk_div:std_logic;
signal s_nr_BCD:std_logic_vector(15 downto 0);
signal clk_div_afis2:std_logic_vector(1 downto 0);
begin
	P1:div_frec port map(clk,clk_div,clk_div_afis2);
	P2:convertor port map(nr_zecimal1,s_nr_BCD);		
	P4:process(clk_div_afis2)
		variable segment7:std_logic_vector(7 downto 0):="00000000";
		variable p_anod:std_logic_vector(3 downto 0):="0000";	
		begin
		 case clk_div_afis2 is	 
			when "00" =>
			p_anod:="1110";
			case  s_nr_BCD(3 downto 0) is
			when "0000"=> segment7 :="00000011";  
			when "0001"=> segment7 :="10011111";  
			when "0010"=> segment7 :="00100101";  
			when "0011"=> segment7 :="00001101";  
			when "0100"=> segment7 :="10011001";
			when "0101"=> segment7 :="01001001";  
			when "0110"=> segment7 :="01000001"; 
			when "0111"=> segment7 :="00011111"; 
			when "1000"=> segment7 :="00000001";
			when "1001"=> segment7 :="00001001"; 
			when others=> segment7 :="11111111";
				end case;
			when "01" =>
			p_anod:="1101";
			case  s_nr_BCD(7 downto 4) is
			when "0000"=> segment7 :="00000011";  
			when "0001"=> segment7 :="10011111";  
			when "0010"=> segment7 :="00100101";  
			when "0011"=> segment7 :="00001101";  
			when "0100"=> segment7 :="10011001";
			when "0101"=> segment7 :="01001001";  
			when "0110"=> segment7 :="01000001"; 
			when "0111"=> segment7 :="00011111"; 
			when "1000"=> segment7 :="00000001";
			when "1001"=> segment7 :="00001001"; 
			when others=> segment7 :="11111111";
				end case;
			when "10"	=>
			p_anod:="1011";
			case  s_nr_BCD(11 downto 8) is
			when "0000"=> segment7 :="00000011";  
			when "0001"=> segment7 :="10011111";  
			when "0010"=> segment7 :="00100101";  
			when "0011"=> segment7 :="00001101";  
			when "0100"=> segment7 :="10011001";
			when "0101"=> segment7 :="01001001";  
			when "0110"=> segment7 :="01000001"; 
			when "0111"=> segment7 :="00011111"; 
			when "1000"=> segment7 :="00000001";
			when "1001"=> segment7 :="00001001"; 
			when others=> segment7 :="11111111";
				end case;
				when "11"=>
				p_anod:="0111";
			case  s_nr_BCD(15 downto 12) is
			when "0000"=> segment7 :="00000011";  
			when "0001"=> segment7 :="10011111";  
			when "0010"=> segment7 :="00100101";  
			when "0011"=> segment7 :="00001101";  
			when "0100"=> segment7 :="10011001";
			when "0101"=> segment7 :="01001001";  
			when "0110"=> segment7 :="01000001"; 
			when "0111"=> segment7 :="00011111"; 
			when "1000"=> segment7 :="00000001";
			when "1001"=> segment7 :="00001001"; 
			when others=> segment7 :="11111111"; 
			end case;
			when others =>p_anod:="1111";
				end case; 
			
	 anod<=p_anod;
	 catod<=segment7;
	end process;
end architecture arch_afisoare;	