library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity adder8 is
  port(
    A, B : in std_logic_vector(3 downto 0);
    dif:out std_logic_vector(3 downto 0);
    SUM : out std_logic_vector(4 downto 0);
     s: in std_logic);
end adder8; 

architecture archit of adder8 is


begin    
process(s,a,b)    
begin if (s='1') then
    sum <= conv_std_logic_vector((conv_integer(A) + conv_integer(B)),5);  
  
else
    dif <= conv_std_logic_vector((conv_integer(A) - conv_integer(B)),4);

  end if; 
  end process;
end archit; 