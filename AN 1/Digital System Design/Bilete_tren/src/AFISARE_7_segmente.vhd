library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity BCD_to_7_seg is
	port (I:in std_logic_vector (3 downto 0);
		 a,b,c,d,e,f,g:out std_logic);
end BCD_to_7_seg;

architecture a1 of BCD_to_7_seg is
begin
	process(I)
	begin
	case I is
		when  "0000" => a<='0'; b<='0';c<='0';d<='0';e<='0';f<='0';g<='1';
		when "0001" => a<='1'; b<='0';c<='0';d<='1';e<='1';f<='1';g<='1';
		when "0010"=>  a<='0'; b<='0';c<='1';d<='0';e<='0';f<='1';g<='0';
		when "0011"=>  a<='0'; b<='0';c<='0';d<='0';e<='1';f<='1';g<='0';
		when "0100" =>  a<='1'; b<='0';c<='0';d<='1';e<='1';f<='0';g<='0';
		when "0101"=>  a<='0'; b<='1';c<='0';d<='0';e<='1';f<='0';g<='0';
		when "0110" => a<='0'; b<='1';c<='0';d<='0';e<='0';f<='0';g<='0';
		when  "0111"=> a<='0'; b<='0';c<='0';d<='1';e<='1';f<='1';g<='1';
		when "1000" =>  a<='0'; b<='0';c<='0';d<='0';e<='0';f<='0';g<='0';
		when "1001"=>   a<='0'; b<='0';c<='0';d<='0';e<='1';f<='0';g<='0';
		when others => a<='1'; b<='1';c<='1';d<='1';e<='1';f<='1';g<='1';
	end case;
end process;
end a1;

library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity MUX_4_to_1 is
	port(A:in std_logic_vector(3 downto 0); 
	B:in std_logic_vector(3 downto 0);
	C:in std_logic_vector(3 downto 0);
	D:in std_logic_vector(3 downto 0);
	SEL:in std_logic_vector(1 downto 0);
	Y:out std_logic_vector(3 downto 0));
end MUX_4_to_1;

architecture MUX of MUX_4_to_1 is
begin
	process(SEL)
	begin
	case SEL is
		when "00"=> Y<=A;
		when "01"=> Y<=B;
		when "10"=> Y<=C;
		when "11"=> Y<=D; 
		when others => null;
	end case;
	end process;
	
end MUX;

library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity count_to_3 is
	port(CLK:in std_logic;
	Q:out std_logic_vector(1 downto 0));
end count_to_3;

architecture count of count_to_3 is
begin
	process(CLK)
	variable A:std_logic_vector(1 downto 0):="00";
	begin
	if (CLK'EVENT) and (CLK='1') then A:=A+1;
	end if;
	Q<=A;
	end process;
end count;

library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity an_select is
	port(SEL:in std_logic_vector(1 downto 0);
	AN:out std_logic_vector(3 downto 0));
end an_select;

architecture an of an_select is
begin
	  process(SEL)
	begin
	case SEL is
		when "00"=> AN(0)<='0'; AN(1)<='1'; AN(2)<='1'; AN(3)<='1';
		when "01"=> AN(0)<='1'; AN(1)<='0'; AN(2)<='1'; AN(3)<='1';
		when "10"=> AN(0)<='1'; AN(1)<='1'; AN(2)<='0'; AN(3)<='1';
		when "11"=> AN(0)<='1'; AN(1)<='1'; AN(2)<='1'; AN(3)<='0';
		when others => null;
	end case;
	end process;
	
end an;


library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity afisare_numar is
	port(C4,C3,C2,C1:in std_logic_vector (3 downto 0);
	CLK:in std_logic;
	Y: out std_logic_vector (6 downto 0);
	DP:out std_logic;
	AN: out std_logic_vector (3 downto 0));
end afisare_numar;

architecture afis_nr of afisare_numar is
signal SELEC:std_logic_vector(1 downto 0);signal Y_temp:STD_LOGIC_VECTOR (3 downto 0);
component an_select is
	port(SEL:in std_logic_vector(1 downto 0);
	AN:out std_logic_vector(3 downto 0));
end component an_select;
component  count_to_3 is
	port(CLK:in std_logic;
	Q:out std_logic_vector(1 downto 0));
end component count_to_3;
component MUX_4_to_1 is
	port(A:in std_logic_vector(3 downto 0); 
	B:in std_logic_vector(3 downto 0);
	C:in std_logic_vector(3 downto 0);
	D:in std_logic_vector(3 downto 0);
	SEL:in std_logic_vector(1 downto 0);
	Y:out std_logic_vector(3 downto 0));
end component MUX_4_to_1;
component BCD_to_7_seg is
	port (I:in std_logic_vector (3 downto 0);	
		 a,b,c,d,e,f,g:out std_logic);
end component BCD_to_7_seg;
begin 
	COUNT: count_to_3 port map (CLK,SELEC);
	MUX_SELECT:MUX_4_to_1 port map(C4,C3,C2,C1,SELEC,Y_temp);
	DECODE:BCD_to_7_seg port map(Y_temp,Y(6),Y(5),Y(4),Y(3),Y(2),Y(1),Y(0));
	ANODE: an_select port map (SELEC,AN);
	process(SELEC)
	begin
	if SELEC="10" then DP<='0';
	else
		DP<='1';
	end if;
		
	end process;

end afis_nr;  

library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity afisare_pret is
	port(I:in std_logic_vector(6 downto 0);
	CLK:in std_logic;
	Y: out std_logic_vector (6 downto 0);
	DP:out std_logic;
	AN: out std_logic_vector (3 downto 0));
end afisare_pret;

architecture AP of afisare_pret is
signal LED0,LED1,LED2:std_logic_vector(3 downto 0);
component afisare_numar is
	port(C4,C3,C2,C1:in std_logic_vector (3 downto 0);
	CLK:in std_logic;
	Y: out std_logic_vector (6 downto 0);
	DP:out std_logic;
	AN: out std_logic_vector (3 downto 0));
end component afisare_numar;
begin
	process(I)
	begin
		case I is
		 
			when "0000000" => LED2<="0000";LED1<="0000";LED0<="0000";
			when "0000001" => LED2<="0000";LED1<="0000";LED0<="0100";
			when "0000010" => LED2<="0000";LED1<="0000";LED0<="1000";
			when "0000011" => LED2<="0000";LED1<="0001";LED0<="0010";
			when "0000100" => LED2<="0000";LED1<="0001";LED0<="0110";
			when "0000101" => LED2<="0000";LED1<="0010";LED0<="0000";
			when "0000110" => LED2<="0000";LED1<="0010";LED0<="0100";
			when "0000111" => LED2<="0000";LED1<="0010";LED0<="1000";
			when "0001000" => LED2<="0000";LED1<="0011";LED0<="0010";
			when "0001001" => LED2<="0000";LED1<="0011";LED0<="0110";
			when "0001010" => LED2<="0000";LED1<="0100";LED0<="0000";
			when "0001011" => LED2<="0000";LED1<="0100";LED0<="0100";
			when "0001100" => LED2<="0000";LED1<="0100";LED0<="1000";
			when "0001101" => LED2<="0000";LED1<="0101";LED0<="0010";
			when "0001110" => LED2<="0000";LED1<="0101";LED0<="0110";
			when "0001111" => LED2<="0000";LED1<="0110";LED0<="0000";
			when "0010000" => LED2<="0000";LED1<="0110";LED0<="0100";
			when "0010001" => LED2<="0000";LED1<="0110";LED0<="1000";
			when "0010010" => LED2<="0000";LED1<="0111";LED0<="0010";
			when "0010011" => LED2<="0000";LED1<="0111";LED0<="0110";
			when "0010100" => LED2<="0000";LED1<="1000";LED0<="0000";
			when "0010101" => LED2<="0000";LED1<="1000";LED0<="0100";
			when "0010110" => LED2<="0000";LED1<="1000";LED0<="1000";
			when "0010111" => LED2<="0000";LED1<="1001";LED0<="0010";
			when "0011000" => LED2<="0000";LED1<="1001";LED0<="0110";
			when "0011001" => LED2<="0001";LED1<="0000";LED0<="0000";
			--when "0011010" =>
			when "0011010" => LED2<="0001";LED1<="0000";LED0<="0100";
			when "0011011" => LED2<="0001";LED1<="0000";LED0<="1000";
			when "0011100" => LED2<="0001";LED1<="0001";LED0<="0010";
			when "0011101" => LED2<="0001";LED1<="0001";LED0<="0110";
			when "0011110" => LED2<="0001";LED1<="0010";LED0<="0000";
			when "0011111" => LED2<="0001";LED1<="0010";LED0<="0100";
			when "0100000" => LED2<="0001";LED1<="0010";LED0<="1000";
			when "0100001" => LED2<="0001";LED1<="0011";LED0<="0010";
			when "0100010" => LED2<="0001";LED1<="0011";LED0<="0110";
			when "0100011" => LED2<="0001";LED1<="0100";LED0<="0000";
			when "0100100" => LED2<="0001";LED1<="0100";LED0<="0100";
			when "0100101" => LED2<="0001";LED1<="0100";LED0<="1000";
			when "0100110" => LED2<="0001";LED1<="0101";LED0<="0010";
			when "0100111" => LED2<="0001";LED1<="0101";LED0<="0110";
			when "0101000" => LED2<="0001";LED1<="0110";LED0<="0000";
			when "0101001" => LED2<="0001";LED1<="0110";LED0<="0100";
			when "0101010" => LED2<="0001";LED1<="0110";LED0<="1000";
			when "0101011" => LED2<="0001";LED1<="0111";LED0<="0010";
			when "0101100" => LED2<="0001";LED1<="0111";LED0<="0110";
			when "0101101" => LED2<="0001";LED1<="1000";LED0<="0000";
			when "0101110" => LED2<="0001";LED1<="1000";LED0<="0100";
			when "0101111" => LED2<="0001";LED1<="1000";LED0<="1000";
			when "0110000" => LED2<="0001";LED1<="1001";LED0<="0010";
			when "0110001" => LED2<="0001";LED1<="1001";LED0<="0110";
			--when "110010"
			when "0110010" => LED2<="0010";LED1<="0000";LED0<="0000";
			when "0110011" => LED2<="0010";LED1<="0000";LED0<="0100";
			when "0110100" => LED2<="0010";LED1<="0000";LED0<="1000";
			when "0110101" => LED2<="0010";LED1<="0001";LED0<="0010";
			when "0110110" => LED2<="0010";LED1<="0001";LED0<="0110";
			when "0110111" => LED2<="0010";LED1<="0010";LED0<="0000";
			when "0111000" => LED2<="0010";LED1<="0010";LED0<="0100";
			when "0111001" => LED2<="0010";LED1<="0010";LED0<="1000";
			when "0111010" => LED2<="0010";LED1<="0011";LED0<="0010";
			when "0111011" => LED2<="0010";LED1<="0011";LED0<="0110";
			when "0111100" => LED2<="0010";LED1<="0100";LED0<="0000";
			when "0111101" => LED2<="0010";LED1<="0100";LED0<="0100";
			when "0111110" => LED2<="0010";LED1<="0100";LED0<="1000";
			when "0111111" => LED2<="0010";LED1<="0101";LED0<="0010";
			--MSB e 1
			when "1000000" => LED2<="0010";LED1<="0101";LED0<="0110";
			when "1000001" => LED2<="0010";LED1<="0110";LED0<="0000";
			when "1000010" => LED2<="0010";LED1<="0110";LED0<="0100";
			when "1000011" => LED2<="0010";LED1<="0110";LED0<="1000";
			when "1000100" => LED2<="0010";LED1<="0111";LED0<="0010";
			when "1000101" => LED2<="0010";LED1<="0111";LED0<="0110";
			when "1000110" => LED2<="0010";LED1<="1000";LED0<="0000";
			when "1000111" => LED2<="0010";LED1<="1000";LED0<="0100";
			when "1001000" => LED2<="0010";LED1<="1000";LED0<="1000";
			when "1001001" => LED2<="0010";LED1<="1001";LED0<="0010";
			when "1001010" => LED2<="0010";LED1<="1001";LED0<="0110";
			--when "1001011"
			when "1001011" => LED2<="0011";LED1<="0000";LED0<="0000";
			when "1001100" => LED2<="0011";LED1<="0000";LED0<="0100";
			when "1001101" => LED2<="0011";LED1<="0000";LED0<="1000";
			when "1001110" => LED2<="0011";LED1<="0001";LED0<="0010";
			when "1001111" => LED2<="0011";LED1<="0001";LED0<="0110";
			when "1010000" => LED2<="0011";LED1<="0010";LED0<="0000";
			when "1010001" => LED2<="0011";LED1<="0010";LED0<="0100";
			when "1010010" => LED2<="0011";LED1<="0010";LED0<="1000";
			when "1010011" => LED2<="0011";LED1<="0011";LED0<="0010";
			when "1010100" => LED2<="0011";LED1<="0011";LED0<="0110";
			when "1010101" => LED2<="0011";LED1<="0100";LED0<="0000";
			when "1010110" => LED2<="0011";LED1<="0100";LED0<="0100";
			when "1010111" => LED2<="0011";LED1<="0100";LED0<="1000";
			when "1011000" => LED2<="0011";LED1<="0101";LED0<="0010";
			when "1011001" => LED2<="0011";LED1<="0101";LED0<="0110";
			when "1011010" => LED2<="0011";LED1<="0110";LED0<="0000";
			when "1011011" => LED2<="0011";LED1<="0110";LED0<="0100";
			when "1011100" => LED2<="0011";LED1<="0110";LED0<="1000";
			when "1011101" => LED2<="0011";LED1<="0111";LED0<="0010";
			when "1011110" => LED2<="0011";LED1<="0111";LED0<="0110";
			when "1011111" => LED2<="0011";LED1<="1000";LED0<="0000";
			when "1100000" => LED2<="0011";LED1<="1000";LED0<="0100";
			when "1100001" => LED2<="0011";LED1<="1000";LED0<="1000";
			when "1100010" => LED2<="0011";LED1<="1001";LED0<="0010";
			when "1100011" => LED2<="0011";LED1<="1001";LED0<="0110";
			--when "1100100"
			when "1100100" => LED2<="0100";LED1<="0000";LED0<="0000";
			when "1100101" => LED2<="0100";LED1<="0000";LED0<="0100";
			when "1100110" => LED2<="0100";LED1<="0000";LED0<="1000";
			when "1100111" => LED2<="0100";LED1<="0001";LED0<="0010";
			when "1101000" => LED2<="0100";LED1<="0001";LED0<="0110";
			when "1101001" => LED2<="0100";LED1<="0010";LED0<="0000";
			when "1101010" => LED2<="0100";LED1<="0010";LED0<="0100";
			when "1101011" => LED2<="0100";LED1<="0010";LED0<="1000";
			when "1101100" => LED2<="0100";LED1<="0011";LED0<="0010";
			when "1101101" => LED2<="0100";LED1<="0011";LED0<="0110";
			when "1101110" => LED2<="0100";LED1<="0100";LED0<="0000";
			when "1101111" => LED2<="0100";LED1<="0100";LED0<="0100";
			when "1110000" => LED2<="0100";LED1<="0100";LED0<="1000";
			when "1110001" => LED2<="0100";LED1<="0101";LED0<="0010";
			when "1110010" => LED2<="0100";LED1<="0101";LED0<="0110";
			when "1110011" => LED2<="0100";LED1<="0110";LED0<="0000";
			when "1110100" => LED2<="0100";LED1<="0110";LED0<="0100";
			when "1110101" => LED2<="0100";LED1<="0110";LED0<="1000";
			when "1110110" => LED2<="0100";LED1<="0111";LED0<="0010";
			when "1110111" => LED2<="0100";LED1<="0111";LED0<="0110";
			when "1111000" => LED2<="0100";LED1<="1000";LED0<="0000";
			when "1111001" => LED2<="0100";LED1<="1000";LED0<="0100";
			when "1111010" => LED2<="0100";LED1<="1000";LED0<="1000";
			when "1111011" => LED2<="0100";LED1<="1001";LED0<="0010";
			when "1111100" => LED2<="0100";LED1<="1001";LED0<="0110";
			--when 500
			when "1111101" => LED2<="0101";LED1<="0000";LED0<="0000";
			when "1111110" => LED2<="0101";LED1<="0000";LED0<="0100";
			when "1111111" => LED2<="0101";LED1<="0000";LED0<="1000";
			
			
			when others => LED2<="1111";LED1<="1111";LED0<="1111";
		  end case;
	end process;
	A_N: afisare_numar port map("1111",LED2,LED1,LED0,CLK,Y,DP,AN);
	
end AP;
