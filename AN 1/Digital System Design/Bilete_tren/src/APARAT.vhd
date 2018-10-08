library	ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity APARAT is
	port(SW:in std_logic_vector (6 downto 0);
	BTN1,BTN2:in STD_LOGIC;
	CLK_50H:in STD_LOGIC;
	RESET:in STD_LOGIC;
	SUMA_PREA_MICA,ELIBERARE_BILET,IMPOSIBILITATE_REST,LIPSA_BILETE:out STD_LOGIC:='0';
	REST:out std_logic_vector (8 downto 0);
	Y: out std_logic_vector (6 downto 0);
	DP:out std_logic;
	AN: out std_logic_vector (3 downto 0));
end APARAT;


Architecture bilete of aparat is


component afisare_pret is
	port(I:in std_logic_vector(6 downto 0);
	CLK:in std_logic;
	Y: out std_logic_vector (6 downto 0);
	DP:out std_logic;
	AN: out std_logic_vector (3 downto 0));
end component afisare_pret;

component timer is
	port (SIG,CLK:in std_logic;
	Q:out std_logic);
end component timer;

component registru_9b is
	port( D:in std_logic_vector(8 downto 0);
	CLK,RST:in STD_LOGIC;
	Q:out std_logic_vector(8 downto 0));
end component registru_9b;

component comparator is
	port(A,B:in std_logic_vector(8 downto 0);
	mare,mic,egal:out STD_LOGIC);
end component comparator;

component numarator is
	port(D:in std_logic_vector(8 downto 0);
	CLK,RST,PL,UP:in std_logic;
	Q:out std_logic_vector (8 downto 0));
end component numarator;  

component FA is
	generic (N: natural:=9);
	port(A, B:in STD_LOGIC_VECTOR (N-1 downto 0);
	CARRY_IN :in STD_LOGIC;
	SUM: out STD_LOGIC_VECTOR(N-1 downto 0);
	CARRY_OUT:out std_logic);
end component FA; 

component sumator_scazator is
	port(A,B:in std_logic_vector(8 downto 0);
	SEL:in STD_LOGIC;
	C:out std_logic;
	REZ:out std_logic_vector(8 downto 0));
end component sumator_scazator;

component MUX_2_1 is
	generic( N:natural:=9);
	port(A,B:in std_logic_vector(N-1 downto 0);
	SEL:in std_logic;
	Y:out std_logic_vector (N-1 downto 0));
end component MUX_2_1;	
component MUX_BANI is
	port(SEL:in std_logic_vector(2 downto 0);
	Y:out std_logic_vector (8 downto 0));
end component MUX_BANI;
signal distanta:std_logic_vector(8 downto 0):="000000000";
signal pret:std_logic_vector(8 downto 0):="000000000";
signal bani:std_logic_vector(8 downto 0):="000000000";
signal suma_curenta:std_logic_vector(8 downto 0):="000000000";
signal suma_temp:std_logic_vector(8 downto 0):="000000000"; 
signal selectie_bani:std_logic_vector(2 downto 0):="000";
--
signal bilete_ramase:std_logic_vector(8 downto 0):="000001111";
signal nr_monezi:std_logic_vector(8 downto 0):="000001111";
--
signal diferenta_bani:std_logic_vector(8 downto 0):="000000000";
signal rest_temp:std_logic_vector(8 downto 0):="000000000";
signal adunare_moneda:std_logic:='0';
signal suma_exacta:std_logic:='0'; 
signal suma_prea_mare:std_logic:='0';
signal eliberare_temp:std_logic:='0';
signal suma_nenula:std_logic:='0';
signal elib_bilet_timer:std_logic:='0';
signal reset_suma_curenta:std_logic:='0';
signal rest_exact,rest_posib:std_logic:='0';
signal rest_eliberat:std_logic:='1';
signal scaderer:std_logic_vector(8 downto 0):="000001111";
signal dist_nenula:std_logic;
begin 
	INTRODUCERE_BANI:block--in:sw(6 to 8),BTN1; out: suma_curenta,nr_monezi (8 downto 0)
	begin
		selectie_bani<=SW(2 downto 0);
		select_bani: MUX_BANI port map (selectie_bani,bani);
		adunare_bani: sumator_scazator port map(A=>bani,B=>suma_curenta,SEL=>'0',REZ=>suma_temp);
		inregistrare_bani: registru_9b port map(D=>suma_temp,CLK=>BTN1,RST=>reset_suma_curenta,Q=>suma_curenta);
		adunare_moneda<=BTN1 and (not(selectie_bani(2))) and (not(selectie_bani(1))) and (not(selectie_bani(0))) ;
		Numarator_monede: numarator port map (CLK=>adunare_moneda,Q=>nr_monezi,D=>scaderer,RST=>'0',PL=>rest_eliberat,UP=>'1');
		end block 	INTRODUCERE_BANI;
	
	
	INTRODUCERE_DISTANTA: block --in: SW(2 to 8),BTN2; out: pret,bilete_ramase(8 downto 0),LIPSA_BILETE, 7-seg
	begin
	process(SW)
	variable temp:std_logic_vector(8 downto 0);
	begin
		for I in 6 downto 0 loop
			 temp(I+2):=SW(I);
		end loop;
	temp(1):='0';
	temp(0):='0';
	distanta<=temp;
	end process;
	incarcare_dist:registru_9b port map (distanta,BTN2,'0',pret);  
	afis_7_seg: afisare_pret port map (distanta(8 downto 2),CLK_50H,Y,DP,AN);
	counter_bilete: numarator port map ("000001111",BTN2,'0',RESET,'0',bilete_ramase);
	process(bilete_ramase)
	begin
	if(bilete_ramase="000000000")then
		LIPSA_BILETE<='1';
	else
		LIPSA_BILETE<='0';
	end if;
	end process;
	end block INTRODUCERE_DISTANTA;
	
	
	COMPARARE_PRET_SUMA:block--in: suma_curenta,pret(8 downto 0),elib_bilet_timer,reset_suma_curenta; out :SUMA_PREA_MICA,suma_exacta,suma_prea_mare,ELIBERARE_BILET
	begin
		COMPARARE: comparator port map(A=>suma_curenta,B=>pret,mic=>SUMA_PREA_MICA,egal=>suma_exacta,mare=>suma_prea_mare);
		eliberare_temp<=suma_exacta or suma_prea_mare;
		process(suma_curenta)
		begin
		if(suma_curenta = "000000000")then suma_nenula<='0';
		else
			suma_nenula<='1';
		end if;
		if(pret="000000000") then dist_nenula<='0';
		else dist_nenula<='1';
		end if;
		end process;
		elib_bilet_timer<=suma_nenula and eliberare_temp and dist_nenula;
		ELIBERARE_BILET<=elib_bilet_timer;
		--
		--temoporizare_7secunde: timer port map (SIG=>elib_bilet_timer,CLK=>CLK_50H,Q=>reset_suma_curenta);
		reset_suma_curenta<=elib_bilet_timer after 7000 ms;
		--resetare_suma_curenta: registru_9b port map(suma_temp,'0',reset_suma_curenta,suma_curenta);
	end block COMPARARE_PRET_SUMA;
	
	
	NECESITATE_REST:block
	
	begin 
		MUX_REST:MUX_2_1 port map ("000000000",diferenta_bani,suma_prea_mare,rest_temp);
		REST_TEMPORAT: sumator_scazator port map (A=>suma_curenta,B=>pret,SEL=>'1',REZ=>diferenta_bani);
		REST<=rest_temp;
		VERIFICARE_MONEZI: comparator port map(B=>rest_temp,A=>nr_monezi,mic=>IMPOSIBILITATE_REST,egal=>rest_exact,mare=>rest_posib);
		rest_eliberat<=rest_exact or rest_posib;
		SCADERE_REST: sumator_scazator port map (A=>nr_monezi,B=>rest_temp,SEL=>'1',REZ=>scaderer);
		--Numarator_monede_dupa_rest: numarator port map (CLK=>adunare_moneda,Q=>nr_monezi,D=>scaderer,RST=>'0',PL=>'1',UP=>'0');
	end block NECESITATE_REST;
	
end bilete;