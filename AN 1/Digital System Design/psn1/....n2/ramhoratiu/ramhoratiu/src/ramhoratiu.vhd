   
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sapte is
	port(
		adresa:in bit_vector(3 downto 0);
		data:in bit_vector(15 downto 0);
		clk:in bit;
		write_enable:in bit;
		Y:out bit_vector(15 downto 0)
		);
end sapte;

--}} End of automatically maintained section

architecture arhitectura_sapte of sapte is
begin
	process(clk)
		type matrice is array(0 to 15 ) of bit_vector (15 downto 0);
		variable m:matrice;
		variable citire:bit;
	begin
		if clk'event and clk='1' then
			if citire='0' then
				m(0):="0000000000011111";
				m(1):="1100000000011111";
				m(2):="1000000000011111";
				m(3):="1100000000011111";
				m(4):="1100000000011111";
				m(5):="1100000000011111";
				m(6):="1100000000011111";
				m(7):="1100000000011111";
				m(8):="1100000000011111";
				m(9):="1100000000011111";
				m(10):="1100000000011111";
				m(11):="1100000000011111";
				m(12):="1100000000011111";
				m(13):="1100000000011111";
				m(14):="1100000000011111";
				m(15):="1100000000011111"; 
				citire:='1';
			else
				if write_enable='0' then
					case adresa is 
						when "0000"=> y<=m(0);
						when "0001"=> y<=m(1);
						when "0010"=> y<=m(2);
						when "0011"=> y<=m(3);
						when "0100"=> y<=m(4);
						when "0101"=> y<=m(5);
						when "0110"=> y<=m(6);
						when "0111"=> y<=m(7);
						when "1000"=> y<=m(8);
						when "1001"=> y<=m(9);
						when "1010"=> y<=m(10);
						when "1011"=> y<=m(11);
						when "1100"=> y<=m(12);
						when "1101"=> y<=m(13);
						when "1110"=> y<=m(14);
						when "1111"=> y<=m(15);
						when others=>
					end case;
				else 
					case adresa is
						when "0000"=> m(0):=data;
						when "0001"=> m(1):=data;
						when "0010"=> m(2):=data;
						when "0011"=> m(3):=data;
						when "0100"=> m(4):=data;
						when "0101"=> m(5):=data;
						when "0110"=> m(6):=data;
						when "0111"=> m(7):=data;
						when "1000"=> m(8):=data;
						when "1001"=> m(9):=data;
						when "1010"=> m(10):=data;
						when "1011"=> m(11):=data;
						when "1100"=> m(12):=data;
						when "1101"=> m(13):=data;
						when "1110"=> m(14):=data;
						when "1111"=> m(15):=data;
						when others=>
					end case;
				end if;
			end if;
		end if;
	end process;
	-- enter your statements here --
	
end arhitectura_sapte;
