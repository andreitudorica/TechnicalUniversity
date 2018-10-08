entity reclama is
	port(intrerupator :in bit;
		 af1,af2:in bit;
		 stins:out bit);
end reclama;

architecture arh_reclama of reclama is
begin 
	process
	begin
		if intrerupator= '1' then
			stins<='0'; wait for 40 ns;
			if af1='1' then
				report "test_psn";
			elsif af2='1' then 
				report "rezultat_psn";	end if;
		elsif intrerupator= '0' then
			stins<='1';
			wait for 60 ns;
		end if;								   
	end process;
end arh_reclama;
		 