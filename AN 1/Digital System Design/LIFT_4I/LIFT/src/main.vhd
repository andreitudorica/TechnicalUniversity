library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use ieee.numeric_std.all;

entity main is
	port(E: in std_logic_vector(3 downto 0);
	MEM: in bit;
	RES: in bit;
	CLK: in bit;
	HEAVY: in bit;
	DOOR: out bit;
	O: out std_logic_vector (0 to 11));
end entity;	

architecture arh_main of main is

component segment is
	port(E: in std_logic_vector(3 downto 0);
	O: out std_logic_vector (0 to 11));
end component;	

signal ETAJE: bit_vector(0 to 12);	
signal iET,ET: std_logic_vector(3 downto 0);	 
signal DIR,iDOOR: bit;				 
signal OK: bit;									  
signal ESTE,ESTE1,nDIR: bit;				
signal SCHIMBAT_DEJA: bit;	
signal MS_REG: std_logic_vector (29 downto 0);
signal TICK: bit;
constant DVS: integer:=25000000;	   

begin
	proc_TICK: process(CLK)
	begin
	if(CLK'EVENT and CLK='1') then
		if(MS_REG=DVS)then 
			TICK<=not TICK; 
	   end if;
	 end if;
	 end process;
	 
	 
	 proc_ms_reg: process(CLK)
	 begin
	 if CLK='1' and CLK'EVENT then
		if RES='1' then
			MS_REG<="000000000000000000000000000000";
		elsif MS_REG=DVS then
			MS_REG<="000000000000000000000000000000";
		else
			MS_REG<=MS_REG+1;
		end if;
	end if;
	 end process;
		
	okey: process(TICK)
	variable t: bit;  
	begin		  
		if TICK='1' and TICK'Event then  
			t:='0';	
			if DIR='1' then
				if ETAJE(to_integer(unsigned(iET))+1)='1' and OK='0' then
					t:='1';
				elsif ETAJE(to_integer(unsigned(iET)))='1' then
					t:='1';
				end if;		
				OK<=t;
			else													 
				if iET/="UUUU" and iET/="0000" then
					if ETAJE(to_integer(unsigned(iET))-1)='1' and OK='0' then
						t:='1';
					elsif ETAJE(to_integer(unsigned(iET)))='1' then
						t:='1';
					end if;		
					OK<=t;
				end if;
			end if;
		end if;
	end process;  
	
	proc_ESTE: process(TICK)			   
	variable x: bit;
	begin		
		if TICK='1' and TICK'EVENT then 
			x:='0';
			for i in 0 to 12 loop
				if DIR='1' then
					if ETAJE(i)='1' and i>iET then
						x:='1';
					end if;
				else
					if ETAJE(i)='1' and i<iET then
						x:='1';
					end if;
				end if;
			end loop;
			ESTE<=x;
		end if;
	end process; 
	
	
	
	proc_ESTE1: process(TICK)			   
	variable x: bit;
	begin		
		if TICK='1' and TICK'EVENT then 
			x:='0';
			for i in 0 to 12 loop
				if nDIR='1' then
					if ETAJE(i)='1' and i>iET then
						x:='1';
					end if;
				else
					if ETAJE(i)='1' and i<iET then
						x:='1';
					end if;
				end if;
			end loop;
			ESTE1<=x;
		end if;
	end process;
	
	proc_Etaje: process(CLK)	
	begin	
		if CLK='1' and CLK'EVENT then	
			if MEM='1' then
				ETAJE(to_integer(unsigned(E)))<='1';
			elsif OK='1' then
				ETAJE(to_integer(unsigned(iET)))<='0';
			end if;
		end if;	
		if RES='1' then
			ETAJE<="0000000000000";	   
		end if;
	end process;
	
	proc_ET: process(TICK)
	begin
		if TICK='1' and TICK'EVENT then
			if OK='0' and (ESTE='1' or (ESTE1='1' and SCHIMBAT_DEJA='1')) and HEAVY='0' then
				if DIR='1' then
					iET<=iET+1;
				else
					iET<=iET-1;
				end if;
			end if;
		end if;
		if RES='1' then
			iET<="0000"; 
		end if;
		ET<=iET;
	end process;		 
	
	proc_DOOR: process(TICK)
	begin		
		if TICK='1' and TICK'EVENT then
			if OK='1' then
				iDOOR<='1';
			elsif OK='0' and (ESTE='1' or ESTE1='1') and HEAVY='0' then
				iDOOR<='0';
			end if;
		end if;
		if RES='1' then  
			iDOOR<='1';
		end if;
		DOOR<=iDOOR;
	end process;  
	
	proc_DIR: process(TICK)
	begin		
		if TICK='1' and TICK'EVENT then  
			if ESTE='0' and ESTE1='1' and SCHIMBAT_DEJA='0' then
				DIR<=not DIR;
				SCHIMBAT_DEJA<='1';
			else	
				SCHIMBAT_DEJA<='0';
			end if;
		end if;	   
		if RES='1' then
			DIR<='1'; 
		end if;
	end process;
	
	nDIR<= not DIR;	
	
	C: segment port map(iET,O);	
	
end architecture;