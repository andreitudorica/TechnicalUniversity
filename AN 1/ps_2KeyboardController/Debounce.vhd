		   
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity debounce is
  generic(
    c_s:integer := 10);  
  port(
    clk:in std_logic;
	 rst:in std_logic;
    b:in std_logic;
    r:out std_logic);
end debounce;

architecture deb of debounce is
  signal ff:std_logic_vector (1 downto 0); 
  signal cset:std_logic;
  signal cout:std_logic_vector(c_s downto 0):=(others=>'0'); 
begin

  cset<=ff(0) xor ff(1);
  
  process(clk,rst)
  begin
		if(rst='1') then
			cout<=(others=>'0');
		else
			if(clk'event)and (clk = '1') then
				ff(0)<=b;
				ff(1)<=ff(0);
				if(cset = '1') then                  
					cout<=(others=>'0');
				elsif(cout(c_s)='0')then			 
					cout<= cout+1;
				else                                       
					r<=ff(1);
				end if;    
			end if;
		end if;
  end process;
end deb;
