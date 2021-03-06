entity ms_scazator is
end ms_scazator;

architecture arh_ms_scazator of ms_scazator is
signal A,B,borrow_in, borrow_out, Y :bit;
component scazator		
	port (A,B, borrow_in: in bit;
	   	  borrow_out,Y: out bit);
end component;



begin
	UST : scazator port map (A=>A,B=>B,borrow_in=>borrow_in,borrow_out=>borrow_out,Y=>Y);

	process								  
	begin
	borrow_in<='1';
	A<='0'; B<='0';
	wait for 20 ns;
	A<='0'; B<='1';
	wait for 20 ns;
	A<='1'; B<='0';
	wait for 20 ns;
	A<='1'; B<='1';
	wait for 20 ns;		  
	
	borrow_in<='0';
	A<='0'; B<='0';
	wait for 20 ns;
	A<='0'; B<='1';
	wait for 20 ns;
	A<='1'; B<='0';
	wait for 20 ns;
	A<='1'; B<='1';
	wait for 20 ns;
	wait;
	end process; 
end arh_ms_scazator;


entity scazator is
	port (A,B, borrow_in: in bit;
		  borrow_out,Y: out bit);
end scazator;

architecture arh_scazator of scazator is
begin
	process (A,B,borrow_in) 
	variable borrow_out1 : bit;
	begin														
		if borrow_in='1' then
			if (A='0' and B='0') then Y<='1'; borrow_out1:='1';
				elsif(A='0' and B='1') then Y<='0'; borrow_out1:='1';
				elsif (A='1' and B='0') then Y<='0'; borrow_out1:='0';
				elsif(A='1' and B='1') then Y<='1'; borrow_out1:='1';
			end if;
		else 																							 
			if (A='0' and B='0') then Y<='0'; borrow_out1:='0';
				elsif(A='0' and B='1') then Y<='1'; borrow_out1:='1';
				elsif (A='1' and B='0') then Y<='1'; borrow_out1:='0';
				elsif(A='1' and B='1') then Y<='0'; borrow_out1:='0';
			end if;
		end if;
	borrow_out<=borrow_out1;
	end process;			
end arh_scazator;
	