library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.NUMERIC_STD.all;
entity lift is
	port(E3,E2,E1,E0:in BIT;
	UP: in BIT;
	MEM,RESET: in BIT;
	USI: out BIT;
	--V: out BIT_VECTOR(0 to 12);
	--acuma: out integer;
	--etaj: out integer
	CLK: in BIT;
	Q3,Q2,Q1,Q0: out BIT);
end lift;

architecture ARCH of lift is 
--subtype iint is integer range 0 to 12;
--type iint is std_logic_vector(3 downto 0);
--signal CLK: BIT;
begin	
	--CLOCK: process
	--begin
	--	CLK<='0';
	--	wait for 10 ns;
	--	CLK<='1';
	--	wait for 10 ns;
	--end process CLOCK;
	
	
	process (CLK)		
	variable VEC,DIR_V: BIT_VECTOR(0 to 12);
	variable ok,t: integer;
	variable now,et,s: std_logic_vector(3 downto 0);
	variable dir: integer:= 0;
	begin 
		if RESET='1' then
			VEC:=('0','0','0','0','0','0','0','0','0','0','0','0','0');	 
			DIR_V:=('0','0','0','0','0','0','0','0','0','0','0','0','0');
			now:="0000";	  
			USI<='1';
			--etaj<=0;   
			dir:=0;
		end if;	 
		
		
		if MEM='1' then
			et:="0000";
			if E0='1' then
				et:="0001";
			end if;
			if E1='1' then
				et:=et+2;
			end if;
			if E2='1' then
				et:=et+4;
			end if;		
			if E3='1' then
				et:=et+8;
			end if;
			
			
			VEC(to_integer(unsigned(et))):='1';
			if UP='1' then
				DIR_V(et):='1';
			end if;	
		end if;
		
		
		if dir=0 then
			for i in 0 to 12 loop
				if VEC(i)='1' then
					if i<now then
						dir:=-1;
					else
						dir:=1;
					end if;
				end if;
			end loop;
		end if;
		
		
		
		if VEC(now)='1' then
			if (DIR_V(now)='1' and dir=1) or (DIR_V(now)='0' and dir=-1) then
				USI<='1';
				dir:=0;
			else 
				ok:=0;
				for i in now+1 to 12 loop
					if 	VEC(i)='1' and ((DIR_V(now)='1' and dir=1) or (DIR_V(now)='0' and dir=-1)) then
						ok:=1;
					end if;
				end loop;
				if ok=0 then
					dir:=0;
					USI<='1';
				end if;
			end if;
		end if;
		

		if CLK='1' and CLK'Event then
			if dir=1 then
				now:=now+1;
			elsif dir=-1 then
				now:=now-1;
			end if;
		end if;	    
		
		
		
		--acuma<=now;
		--V<=VEC;
		--etaj<=et;
		t:=now;
		if t mod 2=1 then
			Q0<='1';
		else
			Q0<='0';
		end if;
		t:=t/2;
		if t mod 2=1 then
			Q1<='1';
		else
			Q1<='0';
		end if;
		t:=t/2;
		if t mod 2=1 then
			Q2<='1';
		else
			Q2<='0';
		end if;
		t:=t/2;
		if t mod 2=1 then
			Q3<='1';
		else
			Q3<='0';
		end if;
		
	end process;
end  ARCH;