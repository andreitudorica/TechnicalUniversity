library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
entity comparator is
	port(A,B:in std_logic_vector(8 downto 0);
	mare,mic,egal:out STD_LOGIC);
end comparator;

architecture comparare of comparator is
begin
	process(A,B)
	begin
	if(A>B) then mare<='1';mic<='0';egal<='0';
	elsif (B=A) then mare<='0';mic<='0';egal<='1';
	else mare<='0';mic<='1';egal<='0';
	end if;
	
	end process;
	
	
end comparare;
