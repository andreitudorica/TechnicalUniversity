library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;   
entity numarator is
	port(D:in std_logic_vector(8 downto 0);
	CLK,RST,PL,UP:in std_logic;
	Q:out std_logic_vector (8 downto 0));
end numarator;
architecture numara of numarator is
begin
	process(CLK,RST)
	variable a:std_logic_vector(8 downto 0):="000001111";
	begin
	   if(RST='1') then a:="000000000";
	   elsif PL='1' then a:=D;
	   elsif (CLK'EVENT) and (CLK='1') then
		   if(UP='1') then
			   a:=a+1;
		   else
			   a:=a-1;
		   end if;
		   
	   end if;
	Q<=a; 
		   
		
	end process;
end numara;
