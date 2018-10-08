library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;	
use IEEE.std_logic_arith.all;


entity numar is
	port(clock : in std_logic;
		 rst: in std_logic;
		 Q: out std_logic_vector (7 downto 0));
end numar;

architecture arh_numar of numar is
signal ei1,eo1,ei2,eo2,ei3,eo3,ei4,eo4: bit;	   
signal Y0,Y1,Y2,Y3:  std_logic_vector (0 to 1);


component numarator_p11
	port(clk,rst: in std_logic;
		enable :in bit :='1';	
		enable_out : out bit;
		num: out std_logic_vector(0 to 1));
end component;



begin
	C1: numarator_p11 port map ( clock,rst,'1',eo1,Y0);
	C2: numarator_p11 port map ( clock,rst,eo1,eo2,Y1);
	C3: numarator_p11 port map ( clock,rst,eo2,eo3,Y2);
	C4: numarator_p11 port map ( clock,rst,eo3,eo4,Y3);
	Q(0)<=Y0(1); Q(1)<=Y0(0);
	Q(2)<=Y1(1); Q(3)<=Y1(0);
	Q(4)<=Y2(1); Q(5)<=Y2(0);
	Q(6)<=Y3(1); Q(7)<=Y3(0);
end arh_numar;



library	IEEE;
use IEEE.std_logic_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;	
use IEEE.std_logic_arith.all;

entity numarator_p11 is
	port(clk,rst: in std_logic;
		enable :in bit :='1';	
		enable_out : out bit;
		num: out std_logic_vector(1 downto 0));
end numarator_p11;

architecture arh_numarator_p11 of numarator_p11 is

begin									   
	process(clk)
	variable count: std_logic_vector(1 downto 0):="00";
	variable enable1: bit; 
	begin
		enable1:=enable;
		if enable='1' then
		if clk='1' and clk'event then
			if rst='1' then count :="00";
			else	
				count:=count+1; 
			end if;	 
		end if;	   
	if count="11" then enable1:='1';
				  else enable1:='0';	end if;
	end if;
	num<=count; 
	enable_out<=enable1;
	end process;
		
end arh_numarator_p11;
	