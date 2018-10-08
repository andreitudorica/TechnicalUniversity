library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity DFF is
	port(D,CE,CLK,S,R:in std_logic;
	Q:out std_logic:='0';
	NQ:out std_logic:='1');
end DFF;

architecture store of DFF is
begin
	process(CE,CLK,S,R)
	begin
	if(S='0') then Q<='1';NQ<='0';
	elsif R='0' then Q<='0';NQ<='1';
	elsif CE='1' then
		if(CLK'EVENT) and (CLK='1') then
			Q<=D after 10 ns ; NQ<=not D after 10 ns ; 
		end if;
	end if;
	end process;
end store;

library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity CLK_1s is
	port(CLK:in STD_LOGIC;
	CLK2:out std_logic);
end CLK_1s;
architecture divider of CLK_1s is
begin
	process(CLK)
	variable a:STD_LOGIC_vector(25 downto 0):="00000000000000000000000000";variable c:std_logic:='0';
	begin
		if(CLK'EVENT) and (CLK='1') then 
			a:=a+1;
		end if;
		if(a="10111110101111000010000000") then 
			c:=not c; a:="00000000000000000000000000";
		end if;
		CLK2<=c;
	end process;
end divider;


library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity timer is
	port (SIG,CLK:in std_logic;
	Q:out std_logic:='0');
end timer;

architecture time_7_s of timer is
component DFF is
	port(D,CE,CLK,S,R:in std_logic;
	Q:out std_logic:='0';
	NQ:out std_logic:='1');
end component DFF;
component CLK_1s is
	port(CLK:in STD_LOGIC;
	CLK2:out std_logic);
end component CLK_1s;
signal P:std_logic_vector(1 to 7):="0000000"; signal one_s:std_logic;
begin 
	DIvide: CLK_1s port map(CLK,one_s);
	BIST1: DFF port map(D=>SIG,CE=>'1',CLK=>one_s,S=>'0',R=>'0',Q=>P(1));
	LANT: for I in 1 to 6 generate 
		INALNT:DFF port map (D=>P(I),CE=>'1',CLK=>one_s,S=>'0',R=>'0',Q=>P(I+1));
	end generate;
	Q<=P(7);
	

end time_7_s;

