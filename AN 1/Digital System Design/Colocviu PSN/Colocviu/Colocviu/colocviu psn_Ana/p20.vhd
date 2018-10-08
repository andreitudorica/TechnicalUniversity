entity registruu_de_deplasare is
	port(Sel, CLK: in bit;
	     Q:inout bit_vector(7 downto 0):="10010001");
end entity registruu_de_deplasare;				    

architecture arh3 of registruu_de_deplasare is
begin			
	process (CLK,Sel)	 
	variable Q1: bit_vector(7 downto 0); 
	begin											  
		Q1:=Q;					
        if (CLK'event) and (CLK='1') then
			if Sel='1' then Q1:=Q1 sll 1; Q1(0) :='0';
			           else Q1:=Q1 srl 1; Q1(7) :='0';end if;
		Q<=Q1;				
		end if;
    end process;			
end;	

entity MSS_registru is
end MSS_registru;

architecture arh_MS_registru of MSS_registru is

signal Sel, CLK: bit; 
signal Q: bit_vector(7 downto 0); 
shared variable END_SIM: BOOLEAN := false;

component registruu_de_deplasare
	port(Sel, CLK: in bit; 
	     Q:inout bit_vector(7 downto 0));
end component;

begin
	UST: registruu_de_deplasare port map(Sel, CLK, Q);
	
	GENERARE_TACT: process
	begin			  
		if not(END_SIM) then 
		CLK<='1';
		wait for 10 ns;
		CLK<='0';
		wait for 10 ns;
		else wait;
		end if;
	 end process GENERARE_TACT;
	
MS: process
	    begin
	    sel<='1';
		wait for 80ns; 
		sel<='0';
		wait for 80ns;
		END_SIM:=true;
		wait;
	end process MS;
end arh_MS_registru;

