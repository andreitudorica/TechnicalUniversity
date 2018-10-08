--DEMUX cu parametri generici – exemplificare pt. DEMUX 1:8
library IEEE;
use ieee.numeric_bit.all;
entity demux is 
	generic (nr_selectii: integer:= 3);
	port (y: in bit ;
	s: in  unsigned ((nr_selectii-1) downto 0);
	a: out unsigned (0 to  (2**nr_selectii-1)));
end demux;
architecture demuxx of demux is 
begin 
	process (s, y)
	variable i: integer;
	begin
		i:=to_integer(s);
		a(i)<=y;
	end process;
end demuxx;

		