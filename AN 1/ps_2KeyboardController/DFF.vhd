library ieee;
use ieee.std_logic_1164.all;
 
entity d_ff is
   port
   (
      clk:in std_logic;
      rst:in std_logic;	
      d:in std_logic;
      q:out std_logic
   );
end entity d_ff;
 
architecture d_ff of d_ff is
begin
   process (clk,rst)
   begin
		if (rst='1') then   
           q<= '0';
      elsif (clk'event) and (clk='1') then    
            q<= d;
		else
		end if;
   end process;
end architecture d_ff;	