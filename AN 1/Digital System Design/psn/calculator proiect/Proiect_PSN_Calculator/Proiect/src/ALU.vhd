library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use pachet_divide.all;
entity ALU is
	port (Semn:in bit_vector(3 downto 0);
	A: in STD_LOGIC_vector(15 downto 0);
	B: in STD_LOGIC_vector(7 downto 0);
	S: out STD_LOGIC_vector(15 downto 0):="0000000000000000";	 
	rest:out std_logic_vector(7 downto 0):="00000000");
end entity;	 

architecture ALU_arh of ALU is	 
signal Sa,Sb: Integer;
signal Rez: integer:=0;
signal rest_sig:integer:=0;
signal Semn_sig:bit_vector(3 downto 0):="0000";


begin
	ALU:process(A,B,Semn,Rez)  			
	variable v_nr_rez:std_logic_vector(15 downto 0):="0000000000000000";
	variable v_nr_rez_vg:std_logic_vector(15 downto 0):="0000000000000000";
	variable svg:std_logic_vector(31 downto 0):="00000000000000000000000000000000";	  
	begin
	Sa<=conv_integer(A);
	Sb<=conv_integer(B);	  
	if(Semn/=Semn_sig) then
	Semn_sig<=Semn;
	case Semn is
		when "0001" => Rez<=Sa+Sb;	
		when "0010" => Rez<=Sa-Sb;				
		when "0100" => Rez<=Sa*Sb;	
						--Rez<=Rez+rest_sig*Sb;
		when "1000" =>--Rez<=Sa/Sb;
		--rest_sig<=Sa rem Sb;
		v_nr_rez:=divide(A,conv_std_logic_vector(conv_integer(B),16));
		svg(23 downto 0):=A-B*v_nr_rez; 
		
		svg:=(svg(30 downto 0) & '0') + (svg(28 downto 0) &"000");
		v_nr_rez_vg:=divide(svg(15 downto 0),A);
		Rez<=conv_integer(v_nr_rez);
		rest_sig<=conv_integer(v_nr_rez_vg(15 downto 0));
		when others => Rez<=Rez;
	end case;			
	end if;
	end process ALU;  
	S<=conv_std_logic_vector(Rez,16);
    rest<=conv_std_logic_vector(rest_sig,8);
end architecture ALU_arh;
	
		
		