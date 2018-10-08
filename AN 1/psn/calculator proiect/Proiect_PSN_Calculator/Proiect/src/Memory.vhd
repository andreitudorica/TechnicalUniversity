library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_arith.all;

entity Reg_mem is
	port (Semn:in bit_vector(3 downto 0);
	A: in std_logic_vector(15 downto 0);  
	B: in std_logic_vector(7 downto 0);
	A_mem: out std_logic_vector(15 downto 0):="0000000000000000";
	B_mem: out std_logic_vector(7 downto 0):="00000000");
	end;

architecture reg of reg_mem is
begin
	process(A,B,Semn)
	begin

    if( Semn="1100") then A_mem<="0000000000000000";
						  A_mem(7 downto 0)<=B;
	elsif(A="0000000000000000") then B_mem<=B;
	else
		A_mem<=A;
		B_mem<=B;
	end if;
	
	end process;
end;