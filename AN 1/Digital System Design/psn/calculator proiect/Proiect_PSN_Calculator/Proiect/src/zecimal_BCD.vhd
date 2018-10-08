library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity convertor is
	port(nr_binar:in std_logic_vector(15 downto 0); 
		nr_BCD:out std_logic_vector(15 downto 0));
end entity convertor;

architecture arch_convertor of convertor is
begin
	process(nr_binar)
		variable p_nr_binar:std_logic_vector(15 downto 0);
		variable p_nr_BCD:std_logic_vector(15 downto 0);
	begin	
	 if nr_binar(13 downto 0)> "10011100001111" then nr_BCD<=(others =>'1');
	   else
		p_nr_BCD:="0000000000000000";
		p_nr_binar:=nr_binar;
	  	for i in 0 to 13 loop
			if p_nr_BCD(3 downto 0)>"0100" then p_nr_BCD:=p_nr_BCD +"0000000000000011";end if;
			if p_nr_BCD(7 downto 4)>"0100" then p_nr_BCD:=p_nr_BCD +"0000000000110000";end if;
			if p_nr_BCD(11 downto 8)>"0100" then p_nr_BCD:=p_nr_BCD +"0000001100000000";end if;
			if p_nr_BCD(15 downto 12)>"0100" then p_nr_BCD:=p_nr_BCD +"0011000000000000";end if;
				p_nr_BCD:=p_nr_BCD(14 downto 0) & '0';
				p_nr_BCD(0):=p_nr_binar(13);   
				p_nr_binar:=p_nr_binar(14 downto 0) &'0';
				nr_BCD<=p_nr_BCD;
		end loop;
		end if;
	end process;
end architecture arch_convertor;