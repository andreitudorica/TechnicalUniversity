library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all; 
use ieee.numeric_std.all;

entity main is
	port(E: in std_logic_vector(3 downto 0);--the floor at which the command is given
	MEM: in bit;--memorize the comand
	RES: in bit;--reset the entire project
	CLK: in bit;--clock
	HEAVY: in bit;--'1' if the lift is to heavy, '0' otherwise
	DOOR: out bit;--'1' if the doors are open, '0' otherwise
	O: out std_logic_vector (0 to 11));--outputs for the 7 segment
end entity;	



architecture arh_main of main is

--Component used for displaying on the 7 segment
component segment is
	port(E: in std_logic_vector(3 downto 0);
	O: out std_logic_vector (0 to 11));
end component;	

signal ETAJE: bit_vector(0 to 12);--vector used to store the floors where the elevator has to stop 
								  --(if ETAJE(i)='1' then it has to stop at the i-th floor)	
signal iET: std_logic_vector(3 downto 0);--vector which stores the floor at which the elevator is at the given time	 
signal DIR: bit;--the direction in which the elevator is moving ('1' if up, '0' if down)
signal iDOOR: bit;--'1' if the doors are open, '0' otherwise
signal OK: bit;--'1' if the elevator has to stop attribute the current floor
signal ESTE,ESTE1: bit;--used for determining wheather there is a floor with a command 
					   --on the direction(ESTE) or on the opposite direction(ESTE1)
signal nDIR: bit;--nDIR=not DIR
signal SCHIMBAT_DEJA: bit;--used to memorize if the direction has already been changed (usefull for the process proc_ET)	
signal MS_REG: std_logic_vector (29 downto 0);--used for dividing the clock input from the board
signal TICK: bit;--the new clock after dividing it
constant DVS: integer:=25000000;--used for dividing the clock input from the board	   

begin	
	
	--used for creating a slower clock
	proc_TICK: process(CLK)
	begin
	if(CLK'EVENT and CLK='1') then
		if(MS_REG=DVS)then 
			TICK<=not TICK; 
	   end if;
	 end if;
	 end process;
	 
	 --used for creating a slower clock
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
	
	--process which returns in OK '1' if the elevator has to stop at the next floor (given the current floor iET and the direction DIR),
							--and '0' otherwise
	--inputs: TICK,ETAJE,iET,DIR
	--output: OK
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
	
	--process which returns in ESTE '1' if there is a floor on the direction given by DIR at which the elevator has to stop, and '0' otherwise
	--inputs: TICK,ETAJE,iET,DIR
	--output: ESTE
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
	
	--process which returns in ESTE1 '1' if there is a floor on the direction given by nDIR(not DIR) at which the elevator has to stop, and '0' otherwise
	--inputs: TICK,ETAJE,iET,DIR
	--output: ESTE1
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
	
	--process used for memorizing the vector ETAJE and modifying it(like a register)
	--inputs: CLK,RES,MEM,OK,iET,E
	--outputs: ETAJE
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
	
	--process used for memorizing the vector iET and modifying it(increasing/decreasing the floor)
	--inputs: TICK,RES,HEAVY,SCHIMBAT_DEJA,ESTE,ESTE1,DIR
	--output: iET
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
	end process;		 
	
	--process used for memorizing the signal iDOOR and modifying it, and for determining the output DOOR
	--inputs: TICK,RES,HEAVY,OK,ESTE,ESTE1
	--outputs: iDOOR,DOOR
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
	
	--process used for memorizing the signal DIR and modifying it
	--inputs: TICK,RES,ESTE,ESTE1
	--outputs: SCHIMBAT_DEJA,DIR
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
	
	C: segment port map(iET,O);--used for displaying on the 7 segment	
	
end architecture;