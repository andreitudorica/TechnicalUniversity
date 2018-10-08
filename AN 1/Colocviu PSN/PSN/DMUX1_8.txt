entity dmux1_8 is
	port (I: in bit;
		  sel : in bit_vector (2 downto 0);
		  Y: out bit_vector (7 downto 0));
end dmux1_8;

architecture arh_dmux of dmux1_8 is
begin
	Y <=('0','0','0','0','0','0','0',I) when sel="000" else 
		('0','0','0','0','0','0',I,'0') when sel="001" else	
		('0','0','0','0','0',I,'0','0') when sel="010" else
		('0','0','0','0',I,'0','0','0') when sel="011" else
		('0','0','0',I,'0','0','0','0') when sel="100" else
		('0','0',I,'0','0','0','0','0') when sel="101" else 
		('0',I,'0','0','0','0','0','0') when sel="110" else
		(I,'0','0','0','0','0','0','0') when sel="111";
end arh_dmux;


entity modul_simulare_dmux is
end modul_simulare_dmux;

architecture arh_modul_dmux of modul_simulare_dmux is  
												  
component dmux1_8 
	port (I: in bit;
		  sel : in bit_vector (2 downto 0);
		  Y: out bit_vector (7 downto 0));
end component;


signal I:bit ;
signal sel : bit_vector (2 downto 0) :="000";
signal Y: bit_vector (7 downto 0) :="00000000";

begin
UST : dmux1_8 port map (I=>I,sel=>sel,Y=>Y);

STIM: process
	begin
	I <= '1';
	wait for 40 ns;
	Sel <= "000";
	wait for 40 ns;
	Sel <= "001";
	wait for 40 ns;
	Sel <= "010";
	wait for 40 ns;
	Sel <= "011";
	wait for 40 ns;
	Sel <= "100";
	wait for 40 ns;
	Sel <= "101";
	wait for 40 ns;
	Sel <= "110";
	wait for 40 ns;
	Sel <= "111";
	wait for 40 ns;
	wait;
end process STIM;	   
end arh_modul_dmux;