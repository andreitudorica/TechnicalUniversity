 --convertor excess3 to bcd 
 LIBRARY  IEEE;	
 use ieee.numeric_bit.all;
 entity conv_excess3 is 
	 port (a: in unsigned (3 downto 0);
	 b: out unsigned (3 downto 0));
 end conv_excess3;
 architecture convertor of conv_excess3 is 
 begin 
	 process (a)
	 variable s: unsigned (3 downto 0 );
	 begin 
		 case a is
			 when "0011" =>	s:="0000";
			 when "0100" =>	s:="0001";
			 when "0101" =>	s:="0010";
			 when "0110" => s:="0011";     
			 when "0111" => s:="0100"; 
			 when "1000" =>	s:="0101";
			 when "1001" =>	s:="0110";
			 when "1010" =>	s:="0111";
			 when "1011" =>	s:="1000";
			 when "1100" => s:="1001"; 
			 when others => s:="1111";
		 end case;
		 b<=s;
	 end process;
 end convertor;
 
			 
 