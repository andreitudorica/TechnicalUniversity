library	IEEE;
use IEEE.std_logic_1164.all;


entity sum_scaz is
	port(A,B :in std_logic_vector (3 downto 0);
		sel:in std_logic; 	
		carry_out :out std_logic;
		Y1: out std_logic_vector (3 downto 0));
end sum_scaz;

architecture arh_sum_scaz of sum_scaz is
signal A2 : std_logic_vector (3 downto 0):="0000";
begin
	process(A,B,sel)
	variable Y,C: std_logic_vector(3 downto 0);
	variable A1,B1 : std_logic_vector (3 downto 0):="0000";
	variable ok: bit :='0';
	begin
	A1:=A;
	B1:=B;
	if sel='1' then 
		if (A(0) and B(0)) ='1' then C(0):='1'; Y(0):='0';
		                 else Y(0):= (A(0) or B(0)); C(0):='0';   end if;
		
		for i in 1 to 3 loop					 
		if (A(i) and B(i)) ='1' then
			if  C(i-1)='1' then C(i):='1'; Y(i):='1';
			               else C(i):='1'; Y(i):='0'; end if;
		elsif (A(i) or B(i))='1' then 
			if C(i-1)='1' then Y(i):='0'; C(i):='1';
						  else Y(i):='1'; C(i):='0'; end if;
		else Y(i):=C(i-1); C(i):='0';		
		end if;
		end loop;
		Y1<=Y;
		carry_out<=C(3);
		
		
		
	else
		ok:='0';
		if A1<B1 then
		for i in 0 to 3 loop
			if ok='1' then 
			A1(i):= not(A1(i)); end if;
			if A1(i)='1' then ok:='1'; end if;
		end loop;
		else 	 
			for i in 0 to 3 loop
			if ok='1' then 
			B1(i):= not(B1(i)); end if;
			if B1(i)='1' then ok:='1'; end if;
		end loop;		 
		end if;			
		
		if (A1(0) and B1(0)) ='1' then C(0):='1'; Y(0):='0';
		                 else Y(0):= (A1(0) or B1(0)); C(0):='0';   end if;
		
		for i in 1 to 3 loop					 
		if (A1(i) and B1(i)) ='1' then
			if  C(i-1)='1' then C(i):='1'; Y(i):='1';
			               else C(i):='1'; Y(i):='0'; end if;
		elsif (A1(i) or B1(i))='1' then 
			if C(i-1)='1' then Y(i):='0'; C(i):='1';
						  else Y(i):='1'; C(i):='0'; end if;
		else Y(i):=C(i-1); C(i):='0';		
		end if;
		end loop;
		Y1<=Y;
		carry_out<=C(3); 
		
		end if;
	end process;
end arh_sum_scaz;
			
	
			
				    