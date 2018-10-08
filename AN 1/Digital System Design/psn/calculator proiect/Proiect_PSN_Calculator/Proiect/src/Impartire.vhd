library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use pachet_divide.all;

entity impartire is
	port( 
		CE_impar:in std_logic;
		nr_binar1:in std_logic_vector(15 downto 0);
		nr_binar1_vg:in std_logic_vector(3 downto 0);
		nr_binar2:in std_logic_vector(15 downto 0);
		nr_binar2_vg:in std_logic_vector(3 downto 0);
		nr_rez:out std_logic_vector(14 downto 0);	
		nr_rez_vg:out std_logic_vector(3 downto 0));
end entity impartire;

architecture arch_impartire of impartire is

begin
	process(nr_binar1,nr_binar2,CE_impar)
	variable v_nr_rez:std_logic_vector(15 downto 0);
	variable v_nr_rez_vg:std_logic_vector(13 downto 0);	
	variable svg:std_logic_vector(28 downto 0);
	begin
		if CE_impar='1' and CE_impar'event then
			v_nr_rez:='0' & divide(nr_binar2(13 downto 0),nr_binar1(13 downto 0));
			svg:=nr_binar2(13 downto 0)-nr_binar1(13 downto 0)*v_nr_rez; 
			svg:=(svg(27 downto 0) & '0') + (svg(25 downto 0) &"000");
			v_nr_rez_vg:=divide(svg(13 downto 0),nr_binar1(13 downto 0));
			v_nr_rez(14):=nr_binar1(14) xor nr_binar2(14);
		end if;	   
		nr_rez<=v_nr_rez;
		nr_rez_vg<=v_nr_rez_vg(3 downto 0);
	end process;
end architecture arch_impartire;