--MUX cu parametri generici – exemplificare pt. MUX 8:1
library  IEEE;
use numeric_bit.all;
use ieee.std_logic_1164.all;
entity mux is 
	generic (nr_selectii: integer:=4);
	port (s: in unsigned ((nr_selectii-1) downto 0);
	a:in unsigned (0 to (2**nr_selectii-1));
	y: out bit);
end mux ;
architecture muxx of mux is
begin 
	process (s, a)
	variable i: integer; 
	begin 
		i:=to_integer (s);
		y<=a(i);
	end process;
end muxx;

