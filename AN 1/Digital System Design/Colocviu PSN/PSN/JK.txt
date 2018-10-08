entity JK is
	port(J,K,S,R,CLK: in bit;
	     Q,nQ: out bit);
end JK;

architecture arh_JK of JK is   
begin
	process(J,K,S,R,CLK)			  
	variable Q1: bit;
	variable stare_anterioara: bit;
	begin
		if (CLK='1' and CLK'EVENT) then
			if(J='0' and K='0') then Q1:=stare_anterioara;
	     		elsif(J='0' and K='1') then Q1:='0';
				elsif(J='1' and K='0') then Q1:='1';
				else Q1:=not(stare_anterioara);
	        end if;
		end if;		
	stare_anterioara:=Q1;
	Q<=Q1;
	nQ<=not(Q1);
	end process;
end arh_JK;
