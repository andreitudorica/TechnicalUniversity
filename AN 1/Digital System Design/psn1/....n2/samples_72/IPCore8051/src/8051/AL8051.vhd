--------------------------------------------------------------------------------------
-- Copyright (c) 1999 by Alatek. All rights reserved.
--
-- DESIGN        :   AL8051
-- FILE NAME     :   AL8051.vhd
-- DESCRIPTION   :   Top Level
--
-- CREATED       :   01/01/1999
-- MODIFIED      :   
-- VERSION       :   1.0
-- AUTHOR        :   Anatoli Sergyienko, Volodymir Lepekha
-- HISTORY       :   
--------------------------------------------------------------------------------------

library IEEE;
use IEEE.Std_Logic_1164.all;
library work;
use work.registers.all;

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--  I/O wires of the I8051 are the following
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
entity AL8051 is
	Port (
		Port0: inout Std_Logic_Vector (7 downto 0);
		Port1: inout Std_Logic_Vector (7 downto 0);
		Port2: inout Std_Logic_Vector (7 downto 0);
		Port3: inout Std_Logic_Vector (7 downto 0);
		CLK: Std_Logic;
		ALE: out Std_Logic;
		PSEN: out Std_Logic;
		EA: in Std_Logic;
		RST: Std_Logic
		);
end AL8051;

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--  Architecture of the I8031 is the following
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^


architecture AL8051_ARCH of AL8051 is
	signal y,y1,x,z,h,h1,yk,ht,ht1,pop,pop1,popp,ht1p : Integer range 0 to 65535;
--	type BYTE1 is array (0 to 255) of Bit_Vector (7 downto 0);
--	type BYTE2 is array (0 to 1023) of Bit_Vector (7 downto 0);
	type VEC is array (4 downto 0) of Integer range 0 to 100;
	signal DRAM: RAMemo; 
	signal PCBus,zo,zo1,zo2,zo3,zcom,zcom1:Bit_Vector (7 downto 0); 
	signal SMOD,SBUFs,SBUF1,SCONs,SCON1:Bit_Vector (7 downto 0);
	signal zox: Bit_Vector(0 to 2);
	signal z1,u,u1,u1k,u12,u2,u3,u4,u5,u6,z2,zvp,z11,z12,flz2,ft: Bit;
	signal utt,utt1,utt1p,ut0,ut1,ut2,ut3,fal0,fal1,fal2,fal3: Bit;
	signal PRP0,PRP1,PRP00,PRP01,PRP02,PRP03,PRP04,PRP05: Bit;
	signal SDR,SDR1,zpp,strb:Bit;
	signal q1,q2,q3: Std_Logic;
	signal p5,p50,p51:Bit_Vector (4 downto 0);
	signal TMODs,TCONs,TL0s,TH0s,TL1s,TH1s,Accumulator,PSWs: Bit_Vector (7 downto 0);
	signal TCONa,TL0a,TH0a,TL1a,TH1a,dcom,ACOM: Bit_Vector (7 downto 0);
	signal ppp: Bit_Vector (15 downto 0);
	signal ttt:Std_Logic_Vector (7 downto 0);
	signal tt0:Std_Logic_Vector (7 downto 0);
	signal pp3: Bit_Vector (1 downto 0);
	signal zbuf,zpos,zsdv,zpp1,zpp2,start,zh,zh1,outact: Bit;
	signal PRT1,TFP,TFP1,TFP1p,PRR1,PB,RB1,SC2: Bit;
	signal PRBit,PRBit1,flpp,flpp0,flpp1,fr: Bit;
	signal flp0,flp1,flp2,flp3,CLKu,CYCLE : Bit;
	signal larger: Std_Logic;
	signal BUP0,BUP1,BUP2,BUP3: Bit_Vector (7 downto 0);   
	
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	-- this is a program ROM
	-- in file  IPMemory.vhd
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	component  IPMemory
		Port (
			i:  in Integer range 0 to 65535;    --address
			PCBus: inout Bit_Vector (7 downto 0);  --data
			z:  in Bit;                         --
			z1: in Bit
			);
	end component;
	
	component console  
		Port (
			qq: in RAMemo;
			BYTE1: in Bit_Vector (7 downto 0);
			com: in Bit_Vector (7 downto 0); 
			r_TCON: in Bit_Vector (7 downto 0);
			r_SCON: in Bit_Vector (7 downto 0);
			r_TH0: in Bit_Vector (7 downto 0);
			r_TL0: in Bit_Vector (7 downto 0);
			r_TH1: in Bit_Vector (7 downto 0);
			r_TL1: in Bit_Vector (7 downto 0);
			r_bp0: in Bit_Vector (7 downto 0);
			r_bp1: in Bit_Vector (7 downto 0);
			r_bp2: in Bit_Vector (7 downto 0);
			r_bp3: in Bit_Vector (7 downto 0);
			y : in Integer
			);
	end component;
	
	
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	-- this is a Timer Unit of MCS51
	-- 
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	component Timer is
		Port (
			l0: in Bit_Vector (7 downto 0);
			h0: in Bit_Vector (7 downto 0);
			l1: in Bit_Vector (7 downto 0);
			h1: in Bit_Vector (7 downto 0);
			l0a: out Bit_Vector (7 downto 0);        
			h0a: out Bit_Vector (7 downto 0);
			l1a: out Bit_Vector (7 downto 0);
			h1a: out Bit_Vector (7 downto 0);
			TCONa: out Bit_Vector (7 downto 0);
			TMOD: in Bit_Vector (7 downto 0);
			TCON: in Bit_Vector (7 downto 0);
			Port3: in Std_Logic_Vector (7 downto 0); 
			s: in Bit;
			TFP: out Bit
			);
	end component;
	
	begin
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^
	-- Switshing memory and timers
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^
	UPP:  IPMemory
	Port map (
		i => y,    --address 
		PCBus => PCBus,	--data
		z => zh,			  -- output data event
		z1 => zh1			--addres latch event
		);
	
	UUW: console 
	Port map(
		qq => dram,
		BYTE1 => ZCOM1,
		com => dcom,
		r_TCON => TCONa,
		r_SCON => SCONs,
		r_TH0 =>  TH0a,
		r_TL0 =>  TL0a,
		r_TH1 =>  TH1a,
		r_TL1 =>  TL1a,
		r_bp0 =>  bup0,
		r_bp1 =>  bup1,
		r_bp2 =>  bup2,
		r_bp3 =>  bup3,
		y  => y
		);
	
	
	UT: Timer
	Port map (
		TMOD => TMODs,
		l0 => TL0s,
		h0 => TH0s,
		l1 => TL1s,
		h1 => TH1s,
		TCON => TCONs,        
		l0a => TL0a,
		h0a => TH0a,
		l1a => TL1a,
		h1a => TH1a,
		TCONa => TCONa,
		Port3 => Port3,
		s => z1,
		TFP => TFP
		);
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^
	-- Decoding machine cycles,
	-- Reset
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (CLK)
		begin
		CLKu <=to_bit(CLK);
	end process;
		
	CLK_dc: process (CLKu,rst)
		variable a: Bit := '0';
		begin
		
		if ht = 23 then ht <= 0; 
						else ht <= ht +1;
		end if;
		if ht = 0 then utt <= not utt; end if;
		if ht = 10 then ut3 <= not ut3; end if;
		if ht = 20 then ut0 <= not ut0; end if;
		if ht = 21 then ut1 <= not ut1; end if; 
		if ht = 22 then ut2 <= not ut2; end if; 
					-- h- machine phase =0...11
		if h = 11 then h <= 0; else h <= h+1; end if;
					-- ui - machine phases =0, 1
					-- two times slower THan h
		if h = 10 then  u <= not u; end if;
		if h = 1 then  u12 <= not u12; end if; 
		if h = 2 then  u2 <= not u2; end if; 
		if h = 3 then  u3 <= not u3; end if;  
		if h = 4 then  u4 <= not u4; end if;   
		if h = 8 then  u5 <= not u5; end if;   
		if h = 9 then  u6 <= not u6; end if; 
		
		if h = 2 then PSEN <= '1';   end if;     	 --PSEN
		if flz2 = '0' and fr = '1'  then 
			if h = 8 then 
			PSEN <= '0'; end if;				  
		end if; 
		
		if flz2 = '0' then  
			if h = 2 then 
					ALE <= '1'; end if;			--ALE
		end if; 
		if h = 6 then ALE <= '0'; end if; 
	
		u1 <=to_bit(RST); 									--u1 = Reset
		if u1k = '1' then 
			ALE <= '1';
			PSEN <= '1'; 
		end if;
		
	end process CLK_dc;
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	-- Input outer Interrupt signals
	-- through Port3(2) and Port 3(3)
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (Port3(2),PRP00)    -- INT0
		variable a: Bit;
	begin
		if Port3(2) = '0' then
				PRP0 <= '1';
		else PRP0 <= '0';
		end if;   
		if a /= PRP00 then PRP0 <= '0'; end if;    
		a:= PRP00;           
	end process;
	
	
	process (Port3(3),PRP01)    -- INT1
		variable a: Bit;
	begin
		if Port3(3) = '0' then 
				PRP1 <= '1';
		else PRP1 <= '0';
		end if;    
		if a /= PRP01 then PRP1 <= '0'; end if;    
		a:= PRP01;                    
	end process;
	
	
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--  the main process 
--  of the I8051 processor kernel
--
--  there are some procedures
--  which work only in this process
--  and use this process variables
--  as side effects
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	kernel: process
		variable pCLK,s,bank,fpr,fpru,j,k1,k2: Integer range -300 to 65663 := 0;
		variable si,sti,ik,k,ik1,kk,jk: Integer range -300 to 65663 := 0;
		variable PR,pr0,pr1,pr10,prp,pr111,ccom:Bit_Vector (7 downto 0);		
		--	variable com	   :Bit_Vector (7 downto 0);
		variable pr2:Bit_Vector (15 downto 0);
		variable pr3:Bit_Vector (3 downto 0);
		variable pr4:Bit_Vector (2 downto 0);
		variable pr5:Bit_Vector (4 downto 0);	  
		variable pr6:Bit_Vector (6 downto 0);
		variable pr50,pr51:Bit_Vector (4 downto 0);
		variable fl0,fl1,flint,flint1: Bit;         
		variable ff,ffc,b,b1,b2,b3,b4,b5,ff1b:Bit := '0';
		variable G0,G1,CT0,CT1,M00,M01,M10,M11:Bit := '0';
		variable FBit,TR0,TR1,TF0,TF1,INT0,INT1,T0,T1:Bit := '0';
		variable ADBit:Bit_Vector (255 downto 0);
		variable BUFP0,BUFP1,BUFP2,BUFP3: Bit_Vector (7 downto 0);		  
		Variable addrhi:	   Bit_Vector (7 downto 0);	
		variable pre: bit;		   		
		variable adp: integer;	
		variable fli: bit;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- this procedure returns <k1>
-- -Integer value of the byte Vector <com>        
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
		procedure Proc2         					       -- byte ==> Integer
			(variable k1 : out Integer range 0 to 255;
			variable com1 : in Bit_Vector (7 downto 0) )
			is                         
			variable k11 : Integer range 0 to 255;
			variable com11 : Bit_Vector (7 downto 0);
		begin 
			com11 := com1; k11:=0;
			for j in 7 downto 0 loop
				k11:=2*k11;
				if com11(j) = '1' then 
					k11:=k11+1;
				end if;
			end loop;
			k1:= k11;
		end procedure Proc2;
		
---^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- this procedure returns the byte Vector <com1>
-- -representation of the Integer<k1>   	  
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure Proc3         						       -- Integer ==>  byte 
			(variable k1 : in Integer range 0 to 255;
			variable com1 : out Bit_Vector (7 downto 0)	)
			is                         
			variable t,k11 : Integer range 0 to 255;
			variable com11 : Bit_Vector (7 downto 0);
		begin 
			k11:= k1;  t:=128;
			for j in 7 downto 0 loop
				if k11 < t then com11(j) := '0';
								else com11(j) := '1'; k11 := k11 - t; 
				end if;
				t := t/2;
			end loop;    
			com1 := com11; 
		end procedure Proc3;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
-- this procedure returns <k1>
-- -Integer value of a half word Vector <com1>         	
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^  
		procedure Proc21                -- 2 byte ==> Integer
			(variable k1 : out Integer range 0 to 65535;
			variable com1 : in Bit_Vector (15 downto 0)	)
			is                         
			variable k11 : Integer range 0 to 65535;
			variable com11 : Bit_Vector (15 downto 0);
		begin 
			com11 := com1;  k11:=0;
			for j in 15 downto 0 loop
				k11:=2*k11;
				if com11(j) = '1' then k11:=k11+1;  end if;
			end loop;
			k1:= k11;
		end procedure Proc21;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^	  
-- this procedure returns the halphword Vector <com1>
-- -representation of the Integer<k1>   	  	  
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure Proc31                -- Integer ==> 2 byte 
			(variable k1 : in Integer range 0 to 65536;
			variable com1 : out Bit_Vector (15 downto 0))
			is                         
			variable t,k11 : Integer range 0 to 65536;
			variable com11 : Bit_Vector (15 downto 0);
		begin 
			k11:= k1; t:=32768;
			for j in 15 downto 0 loop
				if k11 < t then com11(j) := '0';
								else com11(j) := '1'; k11 := k11 - t; 
				end if;
				t := t/2;
			end loop;    
			com1 := com11; 
		end procedure Proc31;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- this procedure returns byte <com>
-- -a following instruction byte        
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure Proc1 is  -- com := pc
			variable a: Bit; -- flag (0 - vnutr./1 - vnesh.) PP
			variable ih: Integer :=0;
		begin
			ik := (ik + 1) mod 32;
			outact<='0';
			ih := i;
			if EA = '1'or EA='H'  then 
				if i < 4095 then a := '0'; 
								else a := '1'; ih := y; 			-- - 4096; 
					outact<='1';
				end if;
				else a := '1'; ih := y;
			end if;                         
			fr <= a;
			if a = '0'then
				wait on u2;
				zh <= not zh; 			   -- output data event IPMemory
				wait for 0.5 ns;
				for j in 0 to 7 loop
					if PCBus(j) = '1' then com(j) := '1'; 
												else com(j) := '0'; 
					end if;
				end loop;     
				zcom1 <= com; 
				wait on u4;
				zh1 <= not zh1; 			   --addres latch event	 IPMemory
				wait for 0.5 ns;
				wait on u;   
			else 
				BUFP0 := "11111111"; 
				bup0 <= bufp0; wait for 1 ps;
				y1 <= ih;
				wait for 1 ns;
				proc31(ih,pr2);
				ppp <= pr2;
				y1 <= ih;
				wait on u2; 
				
				for j in 0 to 7 loop
					if Port0(j) = '1' then com(j) := '1'; 
											else com(j) := '0'; 
					end if;
				end loop;
				
				zcom1 <= com;
				wait on u3;      
				Port0 <= "ZZZZZZZZ";
				
				wait on u4;
				for j in 0 to 7 loop 
					if pr2(j) = '1' then Port0(j) <= '1'; 
										else Port0(j) <= '0'; 
					end if;
				end loop;
	--	RAM(128):= pr2(7 downto 0);
				for j in 8 to 15 loop
					if pr2(j) = '1' then Port2(j-8) <= '1'; 
										else Port2(j-8) <= '0'; 
					end if;
				end loop;
	--		RAM(160):= pr2(15 downto 8);	
		 		addrhi:= pr2(15 downto 8);
				wait on u5; 
				Port0 <= "ZZZZZZZZ";        
			end if; 
		end procedure Proc1;   						   

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Port3 logic
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	impure	function p3(pin:Std_Logic;i:Integer) return Std_Logic is
			variable lev:Std_Logic;
		begin
			if (bufp3(i)='1' and pin='H') then lev:='H';
															else lev:='0';
			end if;
			return lev;
		end; 
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- this is a Timer Unit  
-- implementation
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

		procedure tajm  is              -- Timer one working cycle 
		begin
			if ft = '0' then
				TH0s <= RAM(140);
				TL0s <= RAM(138);
				TH1s <= RAM(141);
				TL1s <= RAM(139); 
				TMODs <= RAM(137);          -- TMOD
				TCONs <=RAM(136);          -- TCON
				wait on u12;           
				
				z1 <= not z1;
				wait for 0.05 ns;
				
				RAM(140) := TH0a;
				RAM(138) := TL0a;
				RAM(141) := TH1a;
				RAM(139) := TL1a; 
				RAM(136) := TCONa;        -- TCON
			end if;
			ft <= not ft;
			wait for 0.5 ns;
		end procedure tajm;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation MOVX-type instructions
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure rvpd          					      					-- MOVX
			(variable k1 : in  Integer range 0 to 65536;
			c,b : in Bit )is                             						  	-- c=0 then reading
			variable t,k11 : Integer range 0 to 65536;			-- b=0 then address in @ri
			variable pr2 : Bit_Vector (15 downto 0);
			variable pr : Bit_Vector (7 downto 0);
		begin 
			BUFP0 := "11111111";  
			bup0 <= bufp0;
			wait for 0.05 ns;
			larger<='0';
			proc31(k1,pr2);
			yk <= k1;
			wait for 1 ns;
			ik := (ik + 1) mod 32;
			tajm;
			wait on u4;
			   Port0<= to_stdlogicvector(pr2(7 downto 0));

			   RAM(128):= "11111111";
			if b='1' then
				for j in 8 to 15 loop
					if pr2(j) = '1' then Port2(j-8) <= '1'; 
					else Port2(j-8) <= '0'; 
					end if;
				end loop;
			else 
				pr2(7 downto 0) := RAM(160);
				for j in 0 to 7 loop 
					if pr2(j) = '1' then Port2(j) <= 'H'; 
										else Port2(j) <= '0'; 
					end if;
				end loop;
			end if;    
			wait for 0.1 ns;
			flz2 <= '1';
			wait on u6; 
			
			Port0 <= "ZZZZZZZZ";
			Port3(7) <=p3('H',7)  ;
			Port3(6) <= p3('H',6) ;        
			
			if c  = '1' then 
				Port0 <= "ZZZZZZZZ"; 
				wait for 1 ns;
				pr:= RAM(224); 
				for j in 0 to 7 loop 
					if pr(j) = '1' then Port0(j) <= '1'; 
									else Port0(j) <= '0'; 
					end if;
				end loop;  
			end if;
			wait on u; 
			ik := (ik + 1) mod 32;
			tajm;
			if c  = '0' then 
				Port3(7) <= '0';
				wait on u5;
				for j in 0 to 7 loop
					if Port0(j) = '1' then pr(j) := '1'; 
											else pr(j) := '0'; 
					end if;
				end loop;                 
				RAM(224):= pr;
				wait on u6;
				Port0 <= "ZZZZZZZZ";                 
			else 
				Port3(6) <= '0';
				 wait on u6;
			end if;
			
			wait on u;  
			Port3(7) <= p3('H',7)  ;
			Port3(6) <= p3('H',6)  ;  
			flz2 <= '0';
			larger<='1';
			
			wait on u4;
			if outact='0' then
				pr2(7 downto 0) := RAM(128);
				for j in 0 to 7 loop 
					if pr2(j) = '1' then Port0(j) <= 'Z'; 
										else Port0(j) <= '0'; 
					end if;
				end loop;
				pr2(7 downto 0) := RAM(160);
				for j in 0 to 7 loop 
					if pr2(j) = '1' then Port2(j) <= 'H'; 
										else Port2(j) <= '0'; 
					end if;
				end loop;
			end if;   
		end procedure rvpd;  


--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- this is a single command cycle 
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure Proc11 is 
			begin  
			tajm;
			if i=65535 then i:=0;   else	i:=i+1; end if;	 
		
			y <= i;
			wait for 1 ns;
			Proc1; 					
		end procedure Proc11;    
		

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation of a jump-instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure ajmp (l:in Bit_Vector (10 downto 0)) is  
		begin
			ff:='1'; 
			proc2 (k,com); 
			if i=65535 then	 i:=0;   else	i:=i+1;  end if;
			proc31 (i,pr2);
			pr2(10 downto 0):=l;
			proc21 (i,pr2);
			i:=i+k;  
		end procedure ajmp;					  
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation of a call-instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure call is
		begin
			j:=i; 
			proc31(j,pr2);
			proc2(k,RAM(129));
			k:=k+1;
			pr:=pr2(7 downto 0);
			RAM(k):=pr;
			k:=k+1;
			pr:=pr2(15 downto 8);
			RAM(k):=pr;
			proc3(k,RAM(129));
			if k > 255 then k:=0; end if;
			
		end procedure call;		  
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation of a return-instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure ret is
		begin    
			proc2(k,RAM(129));
			pr:=RAM(k);
			pr2(15 downto 8):=pr;
			k:=k-1;
			if k < 0 then k:= 255; end if;
			pr:=RAM(k);
			pr2(7 downto 0):=pr;
			k:=k-1;
			if k < 0 then k:= 255; end if;
			proc3(k,RAM(129));
			proc21(i,pr2);
			ff:='1';
		end procedure ret;			  
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation of an acall-instruction--
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure acall (l1:in Bit_Vector (10 downto 0)) is  
		begin
			call;  
			ajmp(l1);
		end procedure acall;												
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation of a long jump-instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure ljmp is
		begin               
			proc2 (k,com);
			j:= k*256;
			Proc11; 
			proc2 (k,com);                   
			i:= j+k;                   
		end procedure ljmp;      

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation of a long call-instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure lcall is  
		begin
			if i=65535 then	 i:=0;   else 	i:=i+1; end if; 
			call;
			ljmp;
		end procedure lcall;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^	  
-- this procedure returns the Integer <k>
-- -representation of the data pointer    	  	  
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure dptr is  
		begin
			pr2(15 downto 8):= RAM(131);
			pr2(7 downto 0):= RAM(130);
			proc21(k,pr2);
		end procedure dptr;   
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- this procedure signales an error	  
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure prerror is  
		begin	 
			 assert false
					report "***UNAFFORDED INSTRUCTION***"
				severity FAILURE;
				wait;
		end procedure prerror; 				  
		
--function reading port p address		
  impure	 function RP(k : integer ) return Bit_Vector  is
		   variable T:  Bit_Vector(7 downto 0);
		begin
		   case k is
			   when 128 => T:=to_bitvector(Port0)  ;	
			   when 144 => T:=to_bitvector(Port1)  ;		 
			   when 160 => T:=to_bitvector(Port2)  ;	
		 	   when 176 => T:=to_bitvector(Port3)  ;	
			   when others =>T:= RAM(k)  ;	
		   end case	 ;
		  return T;
		end;
		--function reading port p	bit	
	impure	 function RPB(k : integer ) return Bit  is
		   variable T:  Bit;
		begin
		   case k is
			   when 128 to 135 => T:=to_bit(Port0(k-128))  ;	
			   when 144 to 151 => T:=to_bit(Port1(k-144))  ;		 
			   when 160 to 167 => T:=to_bit(Port2(k-160))  ;	
		 	   when 176 to 185 => T:=to_bit(Port3(k-176))  ;	
			   when others =>T:= ADBit(k)  ;	
		   end case	 ;
		  return T;
		end;
		
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation of a RAM-register move instruction,
-- if t=0 then MOV Reg'l',k  
-- if t=1 then , MOV k,Reg'l', 
-- where l- register absolute address in RAM
-- k- address RAM, 
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^			 		  

		procedure mov_r_ad (l: in Integer range 0 to 256;  
												t:in Integer range 0 to 2) is
		begin
			proc2 (k,com);
			if t = 0 then RAM(l):=  RP(k);--RAM(k);
						else RAM(k):= RP(l);--RAM(l);
			end if;   
		end procedure mov_r_ad;				 

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation MOV ad,#d -instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^ 
	procedure mov_r_d (l: in Integer range 0 to 256) is    
	begin
			RAM(l):=com; 
	end procedure mov_r_d;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation INC -instruction - +1 to RAM cell
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure inc_r (l: in Integer range 0 to 256 ) is        -- INC **
			variable k: Integer range 0 to 300;
		begin	
			Proc2(k,RAM(l));
			if k < 255 then k:=k+1; 
							else k:=0;
			end if;
			Proc3(k,RAM(l));
		end procedure inc_r;			  
		

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--   Implementation DEC -instruction - -1 to RAM cell
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure dec_r (l: in Integer range 0 to 256 ) is         -- DEC **
		begin	
			Proc2(k,RAM(l));
			if k > 0 then k:=k-1; 
						else k:=255; 
			end if;	                
			Proc3(k,RAM(l));
		end procedure dec_r;			  		   
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Exchange bytes in ACC and RAM cell
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure xch (l: inout Bit_Vector (7 downto 0)) is         -- XCH A,*
		begin	
			pr0:= RAM(224); 
			RAM(224):= l;
			l:= pr0;
		end procedure xch;							 
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Addition  in ACC,  Bit by Bit 
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure add (l: in Bit_Vector (7 downto 0);             
									cc: in Bit) is
			variable x: Bit_Vector(0 to 2);
			variable y: Bit_Vector(8 downto 0):="000000000";
			variable t : Integer range 0 to 8;
		begin	
			pr:= RAM(208);
			pr0:= RAM(224);
			if cc = '1' then  y(0):=pr(7);      -- '0' - ADD; '1' - ADDC	                  
			end if;
			for t in 0 to 7 loop
				x(0):= l(t);
				x(1):= pr0(t);
				x(2):= y(t);
				case x is
					when "000" => pr0(t):='0'; y(t+1):='0';
					when "001" => pr0(t):='1'; y(t+1):='0';
					when "010" => pr0(t):='1'; y(t+1):='0';
					when "011" => pr0(t):='0'; y(t+1):='1';
					when "100" => pr0(t):='1'; y(t+1):='0';
					when "101" => pr0(t):='0'; y(t+1):='1';
					when "110" => pr0(t):='0'; y(t+1):='1';
					when "111" => pr0(t):='1'; y(t+1):='1';
				end case;
			end loop;  
			
			pr(6):=y(4);     
			pr(7):=y(8); 
			if y(7) = y(8) then pr(2):= '0';   
									else pr(2):= '1'; 
			end if;
			RAM(208):= pr;
			RAM(224):= pr0;                      
		end procedure add;					
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Subtraction in ACC, Bit by Bit 
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure subb (l: in Bit_Vector (7 downto 0)) is      -- SUBB A,*
			variable x: Bit_Vector(2 downto 0);
			variable y: Bit_Vector(8 downto 0):="000000000";
			variable t : Integer range 0 to 8;
		begin	
			pr:= RAM(208);
			pr0:= RAM(224);
			y(0):=pr(7); 
			zo <= pr0;
			zo1 <= l;
			wait for 1 ns;
			for t in 0 to 7 loop
				x(0):= pr0(t);
				x(1):= l(t);
				x(2):= y(t);
				case x is
					when "000" => pr0(t):='0'; y(t+1):='0';
					when "001" => pr0(t):='1'; y(t+1):='0';
					when "010" => pr0(t):='1'; y(t+1):='1';
					when "011" => pr0(t):='0'; y(t+1):='0';
					when "100" => pr0(t):='1'; y(t+1):='1';
					when "101" => pr0(t):='0'; y(t+1):='0';
					when "110" => pr0(t):='0'; y(t+1):='1';
					when "111" => pr0(t):='1'; y(t+1):='1';
				end case;
			end loop;   
			pr(6):=y(4);     
			pr(7):=y(8);
			if y(7) = y(8) then pr(2):= '0';   
									else pr(2):= '1'; 
			end if;
			RAM(208):= pr;
			RAM(224):= pr0;                  
		end procedure subb;			  
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Deriving relative addres
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure rel is
		begin
			proc2 (j,com);
			ff:='1';
			if j > 128 then i:= i+j - 256; 
							else i:=((i+j) mod 2**16); 
			end if; 
			if i < 0 then i:= 65535 + i; 
			end if;    
		end procedure rel;     						
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation DJNZ - instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure djnz (l1: in Integer range 0 to 256 ) is
			variable al1 : Integer range 0 to 266; 
		begin
			al1 := l1;
			dec_r(al1);         
			if RAM(al1) /= "00000000" then
				Proc11; 
				rel;
				ff:='0'; 
			else  Proc11;
			end if;
		end procedure djnz;          
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Implementation CJNE - instruction
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure cjne (l: in Bit_Vector (7 downto 0);
			l1: in Bit_Vector (7 downto 0) 	) is
			variable a,b: Integer range 0 to 256; 
			variable al,al1: Bit_Vector (7 downto 0);  
		begin   
			al1 := l1;
			al := l;  	 -- if fli='0' then
			if al1 /= al then
				Proc11;
				rel;
				ff:='0';
			else  Proc11;
			end if;
		
			proc2(a,al1);
			proc2(b,al);
			if a > b then 
				ram(208):= ram(208) or "10000000";
			else 
				ram(208):= ram(208) and "01111111";
			end if;      
				-- end if; fli:='0';
		end procedure cjne;  

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- implementation Port buffers p0..p4  and other registers
-- when reading-modification-writing
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure flag is
			variable i:Integer range 0 to 10;
			variable ren: Bit;
			variable ip,cSCON:Bit_Vector (7 downto 0);
		begin
			ip := RAM(k);
			for i in 0 to 7 loop
				if ip(i) = '0' then 
					ttt(i) <= '0';
					tt0(i) <= '0';  
					wait for 0.05 ns;
				else
					ttt(i) <= 'H';
					tt0(i) <= 'Z'; 
					wait for 0.05 ns;
				end if;
			end loop;
			case k is
				when 128    => Port0 <= tt0;  
									BUFP0 := RAM(k);   
									bup0 <= bufp0;
									wait for  0.05 ns;
				when 144    => Port1 <= ttt;                               
										BUFP1 := RAM(k);    
										bup1 <= bufp1;
										wait for  0.05 ns;
				when 160    => Port2 <= ttt;                       
										BUFP2 := RAM(k);   
										bup2 <= bufp2; 
										wait for  0.05 ns;
				when 176    => bufp3 := ram(k);
										pp3 <= bufp3(1 downto 0);  
										Port3 <= ttt;  
										wait for  0.05 ns;                    
										BUFP3 := RAM(k);  
										bup3 <= bufp3; 
										wait for  0.05 ns;
				when 153    => SBUFs <= RAM(153);                       
				--## flag of sending ##
										SDR <= not SDR; 
											SCONs <= RAM(152);
				when 135    =>   SMOD <= RAM(135);
				when 136    =>   TCONs <= RAM(136); 
				when 152    =>	SCONs <= RAM(152); 					  			   
											cSCON:=	RAM(152); 	
											ren:=	 (not cSCON(0)) and cSCON(4);	
					--##  flag of receiving  of edge R1 ##				  
											if	ren='1' then	
														SDR1 <= not SDR1;
											end if;            
				when others =>
			end case;
			pp3<=bufp3(1 downto 0);		   
			wait for  0.05 ns;
		end procedure flag;

		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Exchange 4 lower Bits in ACC and RAM cell
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure xchd (l1: in Integer range 0 to 2 ) is
		begin
			proc2(k,RAM(bank+l1));
			pr:=RP(k);--RAM(k);
			pr0:=RAM(224);
			pr1(3 downto 0):= pr(3 downto 0);        
			pr(3 downto 0):= pr0(3 downto 0);
			pr0(3 downto 0):= pr1(3 downto 0);
			RAM(k):= pr;
			RAM(224):=pr0;
			flag;
		end procedure xchd;  


--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--  Output to Ports		and copy BitRAM to RAM
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure Bit_ram is
			variable j,i,k1:Integer range 0 to 300;
			variable ip:Bit_Vector (7 downto 0);
		begin
			i:= 0;
			for k1 in 32 to 47 loop
				RAM(k1):= ADBit(i+7 downto i);
				i := i+8;  
			end loop;
			
			k1:= 128;
			for j in 0 to 15 loop
				RAM(k1):= ADBit(i+7 downto i);
				i := i+8;  
				k1 := k1+8;		 
			end loop;
			
			if flp0 = '1' then
				ip := RAM(128);
				for i in 0 to 7 loop
					if ip(i) = '0' then 
						Port0(i) <= '0'; 
						wait for 0.1 ns;
					else Port0(i) <= 'Z'; 
						wait for 0.1 ns;
					end if;
				end loop;
				k := 128;
				flag;
			end if;
			
			if flp1 = '1' then
				ip := RAM(144);
				for i in 0 to 7 loop
					if ip(i) = '0' then 
						Port1(i) <= '0';
						wait for 0.1 ns;
					else Port1(i) <= 'H';
						wait for 0.1 ns;
					end if;
				end loop;
				k := 144;
				flag;
			end if;
			
			if flp2 = '1' then
				ip := RAM(160);
				for i in 0 to 7 loop
					if ip(i) = '0' then
						Port2(i) <= '0'; 
						wait for 0.1 ns;
					else Port2(i) <= 'H';
						wait for 0.1 ns;
					end if;
				end loop;
				k := 160;
				flag;
			end if;
			
			if flp3 = '1' then
				ip := RAM(176);
				for i in 0 to 7 loop
					if ip(i) = '0' then 
						Port3(i) <= '0'; 
						wait for 0.1 ns;
					else Port3(i) <= 'H'; 
						wait for 0.1 ns;
					end if;
				end loop;
				k := 176;
				flag;
			end if;  
			flp0 <= '0';
			flp1 <= '0'; 
			flp2 <= '0';
			flp3 <= '0';        
		end procedure Bit_ram;		 	 
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Copy Byte memory to Bit memory
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure ram_Bit is
			variable j,i,k:Integer range 0 to 300;
		begin
			i:= 0;
			for k in 32 to 47 loop
				ADBit(i+7 downto i):= RAM(k);
				i := i+8;  
			end loop;
			
			k:= 128;
			for j in 0 to 15 loop
				ADBit(i+7 downto i):=RAM(k);
				i := i+8;  
				k := k+8;
			end loop;
		end procedure ram_Bit;
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Initialization 
-- after RESET
-- Case of I8051-I8031: 
-- inner or outer Data RAM addresses 0...4095
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure prnach is
		begin
				while rst = '1' loop
					fr <= '0';
				 	u1k <= '1';
					wait for 1 ps;
					i:= 0;
					ik:= 0;
					for j in 0 to 255 loop
						RAM(j):= "00000000";
					end loop;
				RAM(129):= "00000111";                -- SP <= 08H top of stack;
				RAM(128):= "11111111";
				RAM(144):= "11111111";
				RAM(160):= "11111111";
				RAM(176):= "11111111";
				BUFP0 := "11111111";   
				bup0 <= bufp0; 
				wait for  0.05 ns;
				BUFP1 := "11111111";  
				bup1 <= bufp1;
				wait for  0.05 ns;
				BUFP2 := "11111111";  
				bup2 <= bufp2; 
				wait for  0.05 ns;
				BUFP3 := "11111111";  
				bup3 <= bufp3; 
				wait for  0.05 ns;
				prp := "11111111";
				pp3<="11";
				wait for  0.05 ns;
				Ram_Bit;
				ttt <= "HHHHHHHH";
				tt0<="ZZZZZZZZ";
				Port0 <= tt0; --"ZZZZZZZZ";
				Port1 <= ttt; --"HHHHHHHH";
				Port2 <= ttt; --"HHHHHHHH";
				Port3 <= ttt; --"HHHHHHHH";
				wait for 0.1 ns;
			end loop;
			
			u1k <= '0';
			wait on u;  
			y <= i;
			wait for 0.1 ns;
			tajm;
			Proc1;
			ik := 0;
		end procedure prnach;    	   
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Timer and other interrupt control
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure obrab (v: in VEC;
			i1: inout Integer range 0 to 7	 )
			is
			variable pr :Bit_Vector (7 downto 0); 
			variable i11 :Integer range 0 to 7;
		begin
			i11:= i1;
			pr := RAM(136);
			i:=si;  
			call; 
			i:= V(i11);			   --interrupt vector 
			 fli:='1';						  --zapret raboty s i
			if pr(0) = '1' then 
				if i11 = 4 then  
					RAM(136) := RAM(136) and "11111101";
					PRP00 <= not PRP00; 
				end if;
			end if;  
			if i11 = 3 then 
					RAM(136) := RAM(136) and "11011111"; 
			end if;
			if pr(2) = '1' then 
				if i11 = 2 then  
					RAM(136) := RAM(136) and "11110111";     
					PRP01 <= not PRP01; 
				end if;
			end if;  
			if i11 = 1 then 
				RAM(136) := RAM(136) and "01111111"; 
			end if;
			i1 := 0; 
			TCONs<= RAM(136);
			wait for 0.01 ns;
			tajm;		  	   
			y <= i;	
			wait on u;
			
			-- ## 1** begin
			TCONs <= RAM(136);
			wait for 0.01 ns;
			tajm;
			y <= i;
			wait for 0.5ns;
			Proc1;
			com1 := "10100101";		--This for invalid instruction test
			TCONs <= RAM(136);
			wait for 0.01 ns;
			-- ## 1** end 
			
			--## interrupt flag set to serve 1 instruction ##
			flint1 := '1'; 
 	end procedure obrab; 
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Interrupt Control
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		procedure interrup is
			variable pr0,pr1,pr2,pr3:Bit_Vector (7 downto 0);
			variable v : VEC;
			variable j1,i1: Integer range -2 to 7;
			variable m : Bit;
		begin
			pr0 := RAM(136);
			pr1 := "11111111";
			for j1 in 0 to 7 loop
				if Port3(j1) = '0' then 
					pr1(j1) := '0'; 
				end if;
				if Port3(j1) = '1'  or  Port3(j1) =  'H'   then 
					pr1(j1) := '1'; 
				end if;
			end loop;
			
			if pr0(0) = '1' then  pr0(1) := prp0;
									else  pr0(1) := not pr1(2);                   
			end if;  
			
			if pr0(2) = '1' then pr0(3) := prp1; 
									else pr0(3) := not pr1(3);
			end if;                                  
			RAM(136) := pr0 or ram(136) ; 
			V(4) := 3; 
			V(3) := 11;
			V(2) := 19;
			V(1) := 27;
			V(0) := 35;
			pr0:= RAM(184);   -- IP  prioritat reg   B8h
			pr1:= RAM(136);   -- TCON of Timer       88h
			pr2:= RAM(152);   -- SCON of serial  Port  98h
			pr3:= RAM(168);   -- IE interrupt mask reg. A8h
			TCONs <= RAM(136);
			SCONs <= RAM(152);	
			wait for 1 ns;
			if pr3(7) = '1' then
				pr5(4):= pr1(1);
				pr5(3):= pr1(5);
				pr5(2):= pr1(3);
				pr5(1):= pr1(7);
				pr5(0):= pr2(0) or pr2(1);
			else 
				pr5  := "00000";
			end if; 
			pr50 := "00000";
			pr51 := "00000";
			 			
			for i1 in 0 to 4 loop
				if pr3(i1) = '1' then
					if pr0(i1) = '1' then 
						pr51(4 - i1):=pr5(4 - i1);
					else 
						pr50(4 - i1):=pr5(4 - i1);
					end if;               
				end if;
			end loop;
			
			if fl1 = '0' then i1 := 4;
							else i1 := -1;
			end if;             
			while i1 /= -1 loop
				if pr51(i1) = '1' then
					obrab(V,i1);
					fl1 := '1'; 
					i1 := -1; 
				else i1:= i1 -1;
				end if; 
				
			end loop;
			
			if fl1 = '0' then
				if fl0 = '0' then i1 := 4;
								else i1 := -1;
				end if;             
			else i1 := -1;
			end if;             
			while i1 /= -1  loop
				if pr50(i1) = '1' then 
						obrab(V,i1);						--interrupt control
						fl0 := '1';
						i1 := -1; 
				else i1:= i1 -1;
				end if;
			end loop;
		end procedure interrup;
		
		--######################################################
		-- Beginning of the I8051 kernel simulation process
		--######################################################
begin 
	start <= '1'; 			
	 fli:='0';						  --enable raboty s i
		wait for 0.01 ns;
		while u1 = '1' loop
			prnach; 
		end loop;
		psws <=RAM(208);
		wait for 0.1 ns;
		if psws(4) = '0' then 
			if  psws(3) = '0' then
					bank := 0; 
			else bank := 8; 
			end if;                  
		else 
			if  psws(3) = '0' then
					bank := 16; 
			else bank := 24;
			end if;
		end if;
		x <= bank;
		wait for 0.1 ns;
					-- ## PRP03 i PRT1 form interrupt signal  T1  after transmit  ## --
					-- after transmit PRT1 <= '1';
		PRP03 <= '0';
		if PRT1 = '1' then 
			RAM(152):= RAM(152) or "00000010"; 
			PRP03 <= '1';
		end if; 
					-- ## PRP04 i PRR1 form interrupt signal  R1 after receive  ## --
					-- after receive PRR1 <= '1';
		PRP04 <= '0';
		if PRR1 = '1' then 
			RAM(152):= RAM(152) or "00000001"; 
			SCONs <= ram(152);
			wait for 0.05 ns;
			PRP04 <= '1';
		end if; 
		-- ##                            ##-- 
		
		CYCLE <= not CYCLE;
		sti := i;                                      
		if i=65535 then	 i:=0;  else 	i:=i+1;  end if;
		y <= i;       
		wait for 0.5ns;
		tajm;
		Proc1;
		com1 := com;   -- First instruction byte  is OPCODE
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- decoder of 1 byte instructions
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		case com1 is
			when "00000000" =>  ff1b:='1';
			when "00000011" =>  ff1b:='1';
			when "00010011" =>  ff1b:='1';
			when "00000100" =>  ff1b:='1';
			when "00010100" =>  ff1b:='1';
			when "00100010" =>  ff1b:='1';
			when "00110010" =>  ff1b:='1';
			when "00100011" =>  ff1b:='1';
			when "00110011" =>  ff1b:='1';
			when "01110011" =>  ff1b:='1';
			when "10010011" =>  ff1b:='1';
			when "10000011" =>  ff1b:='1';
			when "10100011" =>  ff1b:='1';
			when "10000100" =>  ff1b:='1';
			when "10100100" =>  ff1b:='1';
			when "10100101" =>  ff1b:='1';
			when "10110011" =>  ff1b:='1';
			when "11000011" =>  ff1b:='1';
			when "11000100" =>  ff1b:='1';
			when "11010011" =>  ff1b:='1';
			when "11010100" =>  ff1b:='1';
			when "11100000" =>  ff1b:='1';
			when "11100100" =>  ff1b:='1';
			when "11110000" =>  ff1b:='1';
			when "11110100" =>  ff1b:='1';
			when "11110010" =>  ff1b:='1';
			when "11110011" =>  ff1b:='1';
			when "11100010" =>  ff1b:='1';
			when "11100011" =>  ff1b:='1';
			when "00000110" =>  ff1b:='1';
			when "00000111" =>  ff1b:='1';
			when "00010110" =>  ff1b:='1';
			when "00010111" =>  ff1b:='1';
			when "00100110" =>  ff1b:='1';
			when "00100111" =>  ff1b:='1';
			when "00110110" =>  ff1b:='1';
			when "00110111" =>  ff1b:='1';
			when "01000110" =>  ff1b:='1';
			when "01000111" =>  ff1b:='1';
			when "01010110" =>  ff1b:='1';
			when "01010111" =>  ff1b:='1';
			when "01100110" =>  ff1b:='1';
			when "01100111" =>  ff1b:='1';
			when "10010110" =>  ff1b:='1';
			when "10010111" =>  ff1b:='1';
			when "11000110" =>  ff1b:='1';
			when "11000111" =>  ff1b:='1';
			when "11010110" =>  ff1b:='1';
			when "11010111" =>  ff1b:='1';
			when "11100110" =>  ff1b:='1';
			when "11100111" =>  ff1b:='1';
			when "11110110" =>  ff1b:='1';
			when "11110111" =>  ff1b:='1';
			when "11001000" =>  ff1b:='1';
			when "11001001" =>  ff1b:='1';
			when "11001010" =>  ff1b:='1';
			when "11001011" =>  ff1b:='1';
			when "11001100" =>  ff1b:='1';
			when "11001101" =>  ff1b:='1';
			when "11001110" =>  ff1b:='1';
			when "11001111" =>  ff1b:='1';
			when "10011000" =>  ff1b:='1';
			when "10011001" =>  ff1b:='1';
			when "10011010" =>  ff1b:='1';
			when "10011011" =>  ff1b:='1';
			when "10011100" =>  ff1b:='1';
			when "10011101" =>  ff1b:='1';
			when "10011110" =>  ff1b:='1';
			when "10011111" =>  ff1b:='1';
			when "01101000" =>  ff1b:='1';
			when "01101001" =>  ff1b:='1';
			when "01101010" =>  ff1b:='1';
			when "01101011" =>  ff1b:='1';
			when "01101100" =>  ff1b:='1';
			when "01101101" =>  ff1b:='1';
			when "01101110" =>  ff1b:='1';
			when "01101111" =>  ff1b:='1';
			when "00001000" =>  ff1b:='1';
			when "00001001" =>  ff1b:='1';
			when "00001010" =>  ff1b:='1';
			when "00001011" =>  ff1b:='1';
			when "00001100" =>  ff1b:='1';
			when "00001101" =>  ff1b:='1';
			when "00001110" =>  ff1b:='1';
			when "00001111" =>  ff1b:='1';
			when "00011000" =>  ff1b:='1';
			when "00011001" =>  ff1b:='1';
			when "00011010" =>  ff1b:='1';
			when "00011011" =>  ff1b:='1';
			when "00011100" =>  ff1b:='1';
			when "00011101" =>  ff1b:='1';
			when "00011110" =>  ff1b:='1';
			when "00011111" =>  ff1b:='1';
			when "01001000" =>  ff1b:='1';
			when "01001001" =>  ff1b:='1';
			when "01001010" =>  ff1b:='1';
			when "01001011" =>  ff1b:='1';
			when "01001100" =>  ff1b:='1';
			when "01001101" =>  ff1b:='1';
			when "01001110" =>  ff1b:='1';
			when "01001111" =>  ff1b:='1';
			when "01011000" =>  ff1b:='1';
			when "01011001" =>  ff1b:='1';
			when "01011010" =>  ff1b:='1';
			when "01011011" =>  ff1b:='1';
			when "01011100" =>  ff1b:='1';
			when "01011101" =>  ff1b:='1';
			when "01011110" =>  ff1b:='1';
			when "01011111" =>  ff1b:='1';
			when "00101000" =>  ff1b:='1';
			when "00101001" =>  ff1b:='1';
			when "00101010" =>  ff1b:='1';
			when "00101011" =>  ff1b:='1';
			when "00101100" =>  ff1b:='1';
			when "00101101" =>  ff1b:='1';
			when "00101110" =>  ff1b:='1';
			when "00101111" =>  ff1b:='1';
			when "00111000" =>  ff1b:='1';
			when "00111001" =>  ff1b:='1';
			when "00111010" =>  ff1b:='1';
			when "00111011" =>  ff1b:='1';
			when "00111100" =>  ff1b:='1';
			when "00111101" =>  ff1b:='1';
			when "00111110" =>  ff1b:='1';
			when "00111111" =>  ff1b:='1';
			when "11101000" =>  ff1b:='1';
			when "11101001" =>  ff1b:='1';
			when "11101010" =>  ff1b:='1';
			when "11101011" =>  ff1b:='1';
			when "11101100" =>  ff1b:='1';
			when "11101101" =>  ff1b:='1';
			when "11101110" =>  ff1b:='1';
			when "11101111" =>  ff1b:='1';
			when "11111000" =>  ff1b:='1';
			when "11111001" =>  ff1b:='1';
			when "11111010" =>  ff1b:='1';
			when "11111011" =>  ff1b:='1';
			when "11111100" =>  ff1b:='1';
			when "11111101" =>  ff1b:='1';
			when "11111110" =>  ff1b:='1';
			when "11111111" =>  ff1b:='1';
		when others     => if i=65535 then	i:=0;    else 	i:=i+1; end if;
			ff1b:= '0';
		end case;
		
		case com1 is
			when "11100010" => 
			when "11100011" =>  
			when "11110010" =>  
			when "11110011" =>  
			when "11100000" => 
			when "11110000" =>  
			when others     =>   
			y <= i;
			wait for 0.5ns;
			tajm;
			Proc1;
		end case;
		
		flint := '0';
		--## forj RETI ##
		if com1 = "00110010" then flint := '1'; end if;
		
		--## for  Bit instructions ##
		pr3(3 downto 1):= com(7 downto 5);
		pr3(0):= com(3);    
		case com1 is
			when "11000010" => if pr3 = "1011" then flint := '1'; end if;
			when "11010010" => if pr3 = "1011" then flint := '1'; end if;
			when "10110010" => if pr3 = "1011" then flint := '1'; end if;
			when "10010010" => if pr3 = "1011" then flint := '1'; end if;
			when others =>
		end case;
		
		--## for byte processing instructions ##
		pr6(6 downto 4):= com(7 downto 5);
		pr6(3 downto 0):= com(3 downto 0);
		pr5:= com(7 downto 3); 
		if pr5 = "10001" then 
			if pr6 = "1011000" then 
				flint := '1';
			end if;
		end if; 
		dcom <= com1;
		wait for 0.05 ns;  
		case com1 is
			when "11110101" => if pr6 = "1011000" then flint := '1'; end if;
			when "01110101" => if pr6 = "1011000" then flint := '1'; end if;
			when "10000101" => if pr6 = "1011000" then flint := '1'; end if;
			when "10000110" => if pr6 = "1011000" then flint := '1'; end if;
			when "10000111" => if pr6 = "1011000" then flint := '1'; end if;
			when "11000101" => if pr6 = "1011000" then flint := '1'; end if;
			when "11000110" => if pr6 = "1011000" then flint := '1'; end if;
			when "11000111" => if pr6 = "1011000" then flint := '1'; end if;
			when "11010110" => if pr6 = "1011000" then flint := '1'; end if;
			when "11010111" => if pr6 = "1011000" then flint := '1'; end if;
			when others =>
		end case;
		
		if flint1 = '1' then flint := '1'; flint1 := '0'; end if;
		if flint = '0' then 
			if ff = '1' then 
				ff:='0'; 
				si := sti;
			else 
				si := sti;    
			end if;
			interrup; 										  --interrupt control
		end if;
		-- ## loading SCON into RAM ##
		RAM(153):= SBUF1;
		if flpp = '1' then   
			SCONs(2) <= sc2;
			if sc2 = '0' then 
					RAM(152):= RAM(152) and "11111011";
			else RAM(152):= RAM(152) or  "00000100";
			end if; 
			flpp1 <= not flpp1;
		end if;
		
		--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		-- Main instruction decoder
		--
		--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		case com1 is    
			when "00000000" => j:=j;            				       -- NOP   
			when "00000001" => ajmp("00000000000");    -- AJMP 000+ad 8  
			when "00000010" => ljmp;               				    -- LJMP ad 16
			when "00000011" =>                 					        -- RR A         1 b.
								pr := RAM(224);
								pr1(6 downto 0):=pr(7 downto 1);
								pr1(7):=pr(0);
								RAM(224):=pr1;
			when "00000100" =>  inc_r(224);            -- INC A        1 b.                    
			when "00000101" =>                         			-- INC ad       2 b.
								proc2 (j,com);
								if j = 128 then RAM(128):= BUFP0; end if;
								if j = 144 then RAM(144):= BUFP1; end if;
								if j = 160 then RAM(160):= BUFP2; end if;
								if j = 176 then RAM(176):= BUFP3; end if;                    
								inc_r(j);
								k := j;
								flag;
			when "00000110" =>                         -- INC @R0      1 b.
								proc2(j,RAM(bank+0));
								if j = 128 then RAM(128):= BUFP0; end if;
								if j = 144 then RAM(144):= BUFP1; end if;
								if j = 160 then RAM(160):= BUFP2; end if;
								if j = 176 then RAM(176):= BUFP3; end if;                    
								inc_r(j);
								k := j;
								flag;
			when "00000111" =>                         -- INC @R1      1 b.
								proc2(j,RAM(bank+1));
								if j = 128 then RAM(128):= BUFP0; end if;
								if j = 144 then RAM(144):= BUFP1; end if;
								if j = 160 then RAM(160):= BUFP2; end if;
								if j = 176 then RAM(176):= BUFP3; end if;                    
								inc_r(j);
								k := j;
								flag;
								                   
			when "00010000" =>                   		   -- JBC Bit,rel  3 b.
								proc2 (k,com);
								case com(7 downto 3) is
									when "10000" => ADBit(135 downto 128) := BUFP0; flp0 <= '1';
									when "10010" => ADBit(151 downto 144) := BUFP1; flp1 <= '1';
									when "10100" => ADBit(167 downto 160) := BUFP2; flp2 <= '1';
									when "10110" => ADBit(183 downto 176) := BUFP3; flp3 <= '1';
									when others => flp0 <= '0'; flp1 <= '0'; flp2 <= '0'; flp3 <= '0';
								end case;                  
								Proc11;
								if ADBit(k) = '1' then rel;
									ADBit(k) := '0';
									fBit := '1';
									ff:='0';
								end if;
			when "00010001" =>  acall("00000000000");    -- ACALL 000+ad8  2 b.
			when "00010010" =>  lcall;              			     -- LCALL ad 16  3 b.
			when "00010011" =>                         				  -- RRC A        1 b.
								pr := RAM(224);
								pr0:= RAM(208);
								pr1(6 downto 0):=pr(7 downto 1);
								pr1(7):=pr0(7);
								pr0(7):= pr(0);
								RAM(224):=pr1;
								RAM(208):=pr0;
			when "00010100" =>  dec_r(224);            -- DEC A        1 b.                    
			when "00010101" =>       			                  -- DEC ad       2 b.
								proc2 (j,com);
								if j = 128 then RAM(128):= BUFP0; end if;
								if j = 144 then RAM(144):= BUFP1; end if;
								if j = 160 then RAM(160):= BUFP2; end if;
								if j = 176 then RAM(176):= BUFP3; end if;
								dec_r(j);
								k := j;
								flag;
			when "00010110" =>                          -- DEC @R0      1 b.
								proc2(j,RAM(bank+0));
								if j = 128 then RAM(128):= BUFP0; end if;
								if j = 144 then RAM(144):= BUFP1; end if;
								if j = 160 then RAM(160):= BUFP2; end if;
								if j = 176 then RAM(176):= BUFP3; end if;
								dec_r(j);
								k := j;
								flag;
								
			when "00010111" =>                           -- DEC @R1      1 b.
								proc2(j,RAM(bank+1));
								if j = 128 then RAM(128):= BUFP0; end if;
								if j = 144 then RAM(144):= BUFP1; end if;
								if j = 160 then RAM(160):= BUFP2; end if;
								if j = 176 then RAM(176):= BUFP3; end if;
								dec_r(j);
								k := j;
								flag;         
			when "00100000" =>                            -- JB Bit,rel     3 b.
								proc2 (k,com);
								Proc11;
								if RPB(k) = '1' then rel; end if; --ADBit(k) = '1' then rel; end if;
			when "00100001" => ajmp("00100000000");      -- AJMP 001+ad 8  2 b.                     
			when "00100010" =>  ret;                      -- RET            1 b.
			when "00100011" =>                            -- RL A           1 b.
								pr := RAM(224);
								pr1(7 downto 1):=pr(6 downto 0);
								pr1(0):=pr(7);
								RAM(224):=pr1;
			when "00100100" =>                          -- ADD A,#d       2 b.
								add(com,'0');
			when "00100101" =>                           -- ADD A,ad       2 b.
								proc2(k,com);
								add(RP(k),'0');--add(RAM(k),'0');
			when "00100110" =>                            -- ADD A,@R0      1 b.
								proc2(k,RAM(bank+0));
								add(RP(k),'0');--add(RAM(k),'0');
			when "00100111" =>                            -- ADD A,@R1      1 b.
								proc2(k,RAM(bank+1));
								add(RP(k),'0');--add(RAM(k),'0');
			when "00110000" =>                             -- JNB bir,rel    3 b.
								proc2 (k,com);
								x <= k;
								zo <= RAM(128);
								wait for 1 ps;
								Proc11;
								if RPB(k) = '0' then rel; end if; --	if ADBit(k) = '0' then rel;  end if;
			when "00110001" =>   acall("00100000000");      -- ACALL 001+ad8  2 b.
			when "00110010" =>                              -- RETI            1 b.
								ret; 
								if  fl1 = '1' then fl1 := '0';
								else fl0 := '0';
								end if; 
								flint1 := '1';
			when "00110011" =>                              -- RLC A           1 b.
								pr := RAM(224);
								pr0:= RAM(208);
								pr1(7 downto 1):=pr(6 downto 0);
								pr1(0):=pr0(7);
								pr0(7):= pr(7);
								RAM(224):=pr1;
								RAM(208):=pr0;
			when "00110100" =>                        -- ADDC A,#d       2 b.
								add(com,'1');
			when "00110101" =>                        -- ADDC A,ad       2 b.
								proc2(k,com);
								add(RP(k),'1');--add(RAM(k),'1');
			when "00110110" =>                        -- ADDC A,@R0      1 b.
								proc2(k,RAM(bank+0));
								add(RP(k),'1');--add(RAM(k),'1');
			when "00110111" =>                        -- ADDC A,@R1      1 b.
								proc2(k,RAM(bank+1));
								add(RP(k),'1');--add(RAM(k),'1');
			when "01000000" =>                                   -- JC rel   2 b.  
								ccom := com;
								y <= i;
								wait for 0.5ns;
								tajm;
								Proc1;
								com:= ccom;
								if ADBit(215) = '1' then rel; end if;
			when "01000001" =>  ajmp("01000000000");             -- AJMP 010+ad 8  2 b. 
			when "01000010" =>                                   -- ORL ad,A       2 b.   
								proc2(k,com);
								if k = 128 then RAM(128):= BUFP0; end if;
								if k = 144 then RAM(144):= BUFP1; end if;
								if k = 160 then RAM(160):= BUFP2; end if;
								if k = 176 then RAM(176):= BUFP3; end if;
								RAM(k):= RAM(k) or RAM(224);
								flag;
			when "01000011" =>                                   -- ORL ad,#d      3 b.     
								proc2(k,com);
								if k = 128 then RAM(128):= BUFP0; end if;
								if k = 144 then RAM(144):= BUFP1; end if;
								if k = 160 then RAM(160):= BUFP2; end if;
								if k = 176 then RAM(176):= BUFP3; end if;
								proc11;
								RAM(k):= RAM(224) or com;
								flag;
			when "01000100" =>                                      -- ORL A,#d       2 b. 
								RAM(224):= RAM(224) or com;
			when "01000101" =>                                      -- ORL A,ad       2 b.  
								proc2(k,com);
								RAM(224):= RAM(224) or RP(k); --RAM(k);
			when "01000110" =>                                      -- ORL A,@R0      1 b.      1 b.
								proc2(k,RAM(bank+0));
								RAM(224):= RAM(224) or RP(k); --RAM(k);
			when "01000111" =>                                      -- ORL A,@R1      1 b.
								proc2(k,RAM(bank+1));
								RAM(224):= RAM(224) or RP(k); --RAM(k);
			when "01010000" =>                                      -- JNC rel        2 b.   
								ccom := com;
								y <= i;
								wait for 0.5ns;
								tajm;
								Proc1; 
								com := ccom;
								if ADBit(215) = '0' then  rel; end if;
			when "01010001" =>   acall("01000000000");               -- ACALL 010+ad8  2 b.
			when "01010010" =>                                       -- ANL ad,A       2 b.
								proc2(k,com);
								if k = 128 then RAM(128):= BUFP0; end if;
								if k = 144 then RAM(144):= BUFP1; end if;
								if k = 160 then RAM(160):= BUFP2; end if;
								if k = 176 then RAM(176):= BUFP3; end if;
								RAM(k):= RAM(224) and RAM(k);
								flag;
			when "01010011" =>            
								proc2(k,com);
								if k = 128 then RAM(128):= BUFP0; end if;
								if k = 144 then RAM(144):= BUFP1; end if;
								if k = 160 then RAM(160):= BUFP2; end if;
								if k = 176 then RAM(176):= BUFP3; end if;
								proc11;
								RAM(k):= RAM(k) and com;
								flag;
			when "01010100" =>                                       -- ANL A,#d      2 b.
								RAM(224):= RAM(224) and com;
			when "01010101" =>                                       -- ANL A,ad      2 b.
								proc2(k,com);
								RAM(224):= RAM(224) and RP(k); --RAM(k);
			when "01010110" =>                                       -- ANL A,@R0      1 b.
								proc2(k,RAM(bank+0));
								RAM(224):= RAM(224) and RP(k); --RAM(k);
			when "01010111" =>                                       -- ANL A,@R1      1 b.
								proc2(k,RAM(bank+1));
								RAM(224):= RAM(224) and RP(k); --RAM(k);
			when "01100000" =>                                        -- JZ rel         2 b.   
								ccom := com;
								y <= i;
								wait for 0.5ns;
								tajm;
								Proc1; 
								com := ccom;
								if RAM(224) = "00000000" then  rel; end if;
			when "01100001" =>  ajmp("01100000000");                   -- AJMP 011+ad 8  2 b.          
			when "01100010" =>                                         -- XRL ad,A       2 b.
								proc2(k,com);
								if k = 128 then RAM(128):= BUFP0; end if;
								if k = 144 then RAM(144):= BUFP1; end if;
								if k = 160 then RAM(160):= BUFP2; end if;
								if k = 176 then RAM(176):= BUFP3; end if;
								RAM(k):= RAM(224) xor RAM(k);
								flag;
			when "01100011" =>                                         -- XRL ad,#d   3 b.
								proc2(k,com);
								if k = 128 then RAM(128):= BUFP0; end if;
								if k = 144 then RAM(144):= BUFP1; end if;
								if k = 160 then RAM(160):= BUFP2; end if;
								if k = 176 then RAM(176):= BUFP3; end if;
								proc11;
								RAM(k):= RAM(k) xor com;
								flag;
			when "01100100" =>                                         -- XRL A,#d       2 b.
								RAM(224):= RAM(224) xor com;
			when "01100101" =>                                         -- XRL A,ad       2 b.
								proc2(k,com);
								RAM(224):= RAM(224) xor RP(k); --RAM(k);
			when "01100110" =>                                         -- XRL A,@R0      1 b.
								proc2(k,RAM(bank+0));
								RAM(224):= RAM(224) xor RP(k); --RAM(k);
			when "01100111" =>                                         -- XRL A,@R1      1 b.
								proc2(k,RAM(bank+1));
								RAM(224):= RAM(224) xor RP(k); --RAM(k);
			when "01110000" =>                                         -- JNZ rel        2 b.   
								ccom := com;
								y <= i;
								wait for 0.5ns;
								tajm;
								Proc1; 
								com := ccom;
								if RAM(224) /= "00000000" then  rel;
										else  
								end if;
			when "01110001" =>   acall("01100000000");    -- ACALL 011+ad8  2 b.
			when "01110010" =>                            -- ORL C,Bit      2 b.
								proc2(k,com);
								pr:=RAM(208);
								pr(7):=pr(7) or RPB(k); --AdBit(k);
								RAM(208):=pr; 
								ff:= '1';
			when "01110011" =>                            -- JMP @A+DPTR    1 b.
								dptr;
								proc2(j,RAM(224));
								ff:='1';
								i:=k+j;                     
								if i > 65535 then i:= i - 65536; end if;
			when "01110100" =>   mov_r_d (224);               -- MOV A,#d       2 b.                   
			when "01110101" =>                                -- MOV ad,#d   3 b.
								proc2(k,com);
								proc11;
								mov_r_d (k);
								flag;
			when "01110110" =>                             -- MOV @R0,#d  2 b.                 
								proc2(k,RAM(bank+0));
								mov_r_d (k);
								flag;
			when "01110111" =>                             -- MOV @R1,#d  2 b.
								proc2(k,RAM(bank+1));
								mov_r_d (k);
								flag;
			when "10000000" =>    
								rel;                        -- SJMP rel       2 b.
			when "10000001" =>  ajmp("10000000000");  -- AJMP 100+ad 8  2 b. 
			when "10000010" =>                        -- ANL C,Bit      2 b.
								proc2(k,com);
								pr:=RAM(208);
								pr(7):=pr(7) and RPB(k); --AdBit(k);
								RAM(208):=pr;
								ff:='1';
			when "10000011" =>                        -- MOVC A,@A+PC   1 b.
								proc2(j,RAM(224)); 
								k:=j+i;
								if k > 65535 then k:= k - 65535; end if;
								tajm; 
								y <= k;
								wait for 1 ns;
								proc1;
								tajm; 
								y <= i;
								wait for 1 ns;
								proc1;
								RAM(224):=com;
			when "10000100" =>                         -- DIV AB         1 b.
								proc2(k,RAM(224));
								proc2(j,RAM(240));
								if j = 0 then 
									RAM(208):= RAM(208) or "00000100"; 
								else
									k1:=k mod j;
									proc3(k1,RAM(240));
									k:=k - k1;
									k:=k/j;
									proc3(k,RAM(224)); 
									RAM(208):= RAM(208) and "01111011"; 
								end if;
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
			when "10000101" =>                         -- MOV add,ads    3 b.
								proc2(k,com);
								proc11;
								proc2(j,com);
								RAM(j):=RP(k);--RAM(k); 
								flag;
			when "10000110" =>                          -- MOV ad,@R0     2 b. 
								proc2(k,com);
								proc2(j,RAM(bank+0));
								RAM(k):=RP(j);--RAM(j);
								flag;
			when "10000111" =>                           -- MOV ad,@R1     2 b.
								proc2(k,com);
								proc2(j,RAM(bank+1));
								RAM(k):=RP(j);--RAM(j);
								flag;             
			when "10010000" =>                           -- MOV DPTR,#d16   3 b.
								RAM(131):=com;
								proc11;
								RAM(130):=com;
			when "10010001" =>   acall("10000000000");    -- ACALL 100+ad8  2 b.
			when "10010010" =>                            -- MOV Bit,C       2 b.
								proc2(k,com);
								case com(7 downto 3) is
									when "10000" => ADBit(135 downto 128) := BUFP0; flp0 <= '1';
									when "10010" => ADBit(151 downto 144) := BUFP1; flp1 <= '1';
									when "10100" => ADBit(167 downto 160) := BUFP2; flp2 <= '1';
									when "10110" => ADBit(183 downto 176) := BUFP3; flp3 <= '1';
									when others =>		 flp0 <= '0'; flp1 <= '0'; flp2 <= '0'; flp3 <= '0';
								end case;                
								pr:=RAM(208);
								AdBit(k):= pr(7);
								FBit := '1';  
								ff:='1';                  
			when "10010011" =>                             -- MOVC A,@A+DPTR   1 b.
								dptr;
								proc2(j,RAM(224)); 
								k:=j+k;
								if k > 65535 then k:= k - 65535; end if; 
								tajm; 
								y <= k;
								wait for 1 ns;
								proc1;
								tajm; 
								y <= i;
								wait for 1 ns;
								proc1;
								RAM(224):=com;
			when "10010100" =>                        -- SUBB A,#d       2 b.
								subb(com);
			when "10010101" =>                        -- SUBB A,ad       2 b.
								proc2(k,com);
								subb(RP(k));--subb(RAM(k));
			when "10010110" =>                        -- SUBB A,@R0      1 b.
								proc2(k,RAM(bank+0));
								subb(RP(k));--subb(RAM(k));
			when "10010111" =>                        -- SUBB A,@R1      1 b.
								proc2(k,RAM(bank+1));
								subb(RP(k));--subb(RAM(k));
			when "10100000" =>                        -- ORL C,/Bit      2 b.
								proc2(k,com);
								b1:=RPB(k); --AdBit(k);
								pr:=RAM(208);
								b1:= not b1;
								pr(7):=pr(7) or b1;
								RAM(208):=pr;
								ff := '1';
			when "10100001" =>  ajmp("10100000000");      -- AJMP 101+ad 8  2 b. 
			when "10100010" =>                            -- MOV C,Bit      2 b.
								proc2(k,com);
								pr:=RAM(208);
								pr(7):= RPB(k);--AdBit(k);
								RAM(208):=pr;
			when "10100011" =>                             -- INC DPTR       1 b.
								dptr;
								if k > 65534 then k:=0;
								else k:=k+1;
								end if;
								proc31(k,pr2);
								RAM(130):= pr2(7 downto 0);
								RAM(131):= pr2(15 downto 8);   
								proc1; tajm;
								proc1; tajm;
			when "10100100" =>                           -- MUL AB         1 b.       
								proc2(k,RAM(224));
								proc2(j,RAM(240));
								k:=k*j;
								if k > 255 then RAM(208):= (RAM(208) and "01111111") or "00000100";
												else RAM(208):= RAM(208) and "01111011";
								end if;           
								proc31(k,pr2);
								RAM(240):=pr2(15 downto 8);                    
								RAM(224):=pr2(7 downto 0);
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
								proc1; tajm;
			when "10100101" =>     j:=j; --prerror ;        -- invalid instruction
			when "10100110" =>                           -- MOV @R0,ad     2 b.
								proc2(k,com);
								proc2(j,RAM(bank+0));
								RAM(j):=RP(k);--RAM(k);
			when "10100111" =>                           -- MOV @R1,ad     2 b.
								proc2(k,com);
								proc2(j,RAM(bank+1));
								RAM(j):=RP(k);--RAM(k);   
			when "10110000" =>                           -- ANL C,/Bit     2 b.
								proc2(k,com);
								b1:=RPB(k);--AdBit(k);
								pr:=RAM(208);
								b1:= not b1;
								pr(7):=pr(7) and b1;
								RAM(208):=pr;
								ff:='1';
			when "10110010" =>                             -- CPL Bit        2 b.
								proc2(k,com);
								case com(7 downto 3) is
									when "10000" => ADBit(135 downto 128) := BUFP0; flp0 <= '1';
									when "10010" => ADBit(151 downto 144) := BUFP1; flp1 <= '1';
									when "10100" => ADBit(167 downto 160) := BUFP2; flp2 <= '1';
									when "10110" => ADBit(183 downto 176) := BUFP3; flp3 <= '1';
									when others =>		 flp0 <= '0'; flp1 <= '0'; flp2 <= '0'; flp3 <= '0';
								end case;                
								AdBit(k):=not AdBit(k);
								FBit := '1'; 
			when "10110011" =>                           -- CPL C          1 b.
								pr:=RAM(208);
								pr(7):= not pr(7);
								RAM(208):=pr;
			when "10110100" =>                            -- CJNE A,#d,rel  3 b.
								cjne(RAM(224),com);
			when "10110101" =>                            -- CJNE A,ad,rel  3 b.
								proc2(k,com);
								cjne(RAM(224),RP(k));--RAM(k));
			when "10110110" =>                            -- CJNE @R0,#d,rel  3 b.
								proc2(k,RAM(bank+0));
								cjne(RP(k),com);--RAM(k),com);
			when "10110111" =>                            -- CJNE @R1,#d,rel  3 b.
								proc2(k,RAM(bank+1));
								cjne(RP(k),com);--RAM(k),com);
			when "11000000" =>                            -- PUSH ad       2b.
								proc2(k,RAM(129));
								k:=k+1;
								proc3(k,RAM(129));
								proc2(j,com);
								RAM(k):= RP(j);--RAM(j);
			when "11000001" =>  ajmp("11000000000");       -- AJMP 110+ad 8  2 b. 
			when "11000010" =>                             -- CLR Bit        2 b.
								proc2(k,com);
								case com(7 downto 3) is
									when "10000" => ADBit(135 downto 128) := BUFP0; flp0 <= '1';
									when "10010" => ADBit(151 downto 144) := BUFP1; flp1 <= '1';
									when "10100" => ADBit(167 downto 160) := BUFP2; flp2 <= '1';
									when "10110" => ADBit(183 downto 176) := BUFP3; flp3 <= '1';
									when others =>		 flp0 <= '0'; flp1 <= '0'; flp2 <= '0'; flp3 <= '0';
								end case;                
								ADBit(k):='0';
								FBit := '1'; 
			when "11000011" =>  ADBit(215):='0';              -- CLR C          1 b.
								FBit := '1'; 
								flp0 <= '0'; flp1 <= '0'; 
								flp2 <= '0'; flp3 <= '0';
			when "11000100" =>                                -- SWAP A         1 b.                    
								pr:= RAM(224);
								pr0(3 downto 0):=pr(3 downto 0);
								pr(3 downto 0):=pr(7 downto 4);
								pr(7 downto 4):=pr0(3 downto 0);
								RAM(224):=pr;
			when "11000101" =>                    -- XCH A,ad       2 b.
								proc2(k,com);
								xch(RP(k));--RAM(k));
								flag;
			when "11000110" =>                    -- XCH A,@R0      1 b.                   
								proc2(k,RAM(bank+0));
								xch(RP(k));--(RAM(k));
								flag;
			when "11000111" =>                    -- XCH A,@R1      1 b.
								proc2(k,RAM(bank+1));
								xch(RP(k));--(RAM(k));
								flag;
			when "11010000" =>                        -- POP ad         2 b.
								proc2(k,com);
								proc2(j,RAM(129));
								RAM(k):=RP(j);--RAM(j);
								j:=j-1;
								proc3(j,RAM(129));
			when "11010001" =>   acall("11000000000");    -- ACALL 110+ad8  2 b.
			when "11010010" =>                         -- SETB Bit        2 b.
								proc2(k,com);
								case com(7 downto 3) is
									when "10000" => ADBit(135 downto 128) := BUFP0; flp0 <= '1';
									when "10010" => ADBit(151 downto 144) := BUFP1; flp1 <= '1';
									when "10100" => ADBit(167 downto 160) := BUFP2; flp2 <= '1';
									when "10110" => ADBit(183 downto 176) := BUFP3; flp3 <= '1';
									when others =>		 flp0 <= '0'; flp1 <= '0'; flp2 <= '0'; flp3 <= '0';
								end case;                
								ADBit(k):='1';
								FBit := '1';
			when "11010011" =>  ADBit(215):='1';          -- SETB C          1 b. 
								FBit := '1';
								flp0 <= '0'; flp1 <= '0'; 
								flp2 <= '0'; flp3 <= '0'; 
			when "11010100" =>                            -- DA A             1 b.
								pr10:=RAM(224);
								pr1:=RAM(208);
								b1:=pr1(7);
								if pr1(6) = '1' then
										add("00000110",'0');
								else
									pr10:=pr10 and "00001111";
									proc2(j,pr10);
									if j > 9 then
										add("00000110",'0');
									end if;
								end if;
								
								pr111:=RAM(208);
								pr1(7):=b1 or pr111(7);
								b1:=pr1(7);
								pr10:=RAM(224);
								if pr1(7) = '1' then  
										add("01100000",'0');
								else
									pr10:=pr10 and "11110000";
									proc2(j,pr10);
									if j > 144 then  
										add("01100000",'0');
									end if;
								end if;
								pr111:=RAM(208);
								pr1(7):=b1 or pr111(7);
								RAM(208):=pr1;                             
			when "11010101" =>                            -- DJNZ ad,rel      3 b.
								proc2(k,com);
								jk := k;
								if k = 128 then RAM(128):= BUFP0; end if;
								if k = 144 then RAM(144):= BUFP1; end if;
								if k = 160 then RAM(160):= BUFP2; end if;
								if k = 176 then RAM(176):= BUFP3; end if;
								djnz(k);
								k:= jk;
								flag;   
			when "11010110" =>                           -- XCHD A,@R0       1 b.
								proc2(k,RAM(bank+0));
								xchd(0);
								--flag;
			when "11010111" =>                            -- XCHD A,@R1       1b                  
								proc2(k,RAM(bank+1));
								xchd(1);
								--flag;
			when "11100000" =>                            -- MOVX A,@DPTR   1 b.
								dptr;
								rvpd(k,'0','1');
								y <= i;
			wait for 1 ns;
								tajm;
								Proc1;
			when "11100001" =>  ajmp("11100000000");      -- AJMP 111+ad 8  2 b.                  
			when "11100010" =>                            --  MOVX A,@R0     1 b.
								proc2(k,RAM(bank+0));
								rvpd(k,'0','0');
								y <= i;
								wait for 1 ns;
								tajm;
								Proc1;
			when "11100011" =>                             -- MOVX A,@R1     1 b.
								proc2(k,RAM(bank+1));
								rvpd(k,'0','0');
								y <= i;
								wait for 1 ns;
								tajm;
								Proc1;
			when "11100100" =>  RAM(224):= "00000000";  -- CLR A          1 b.
			when "11100101" =>                          -- MOV A,ad       2 b.
								proc2(k,com);
								RAM(224)  := RP(k);--RAM(k);
			when "11100110" =>                           -- MOV A,@R0      1 b.
								proc2(k,RAM(bank+0));
								RAM(224)  := RP(k);--RAM(k);
			when "11100111" =>                           -- MOV A,@R1      1 b.
								proc2(k,RAM(bank+1));
								RAM(224)  := RP(k);--RAM(k);
			when "11110000" =>                            -- MOVX @DPTR,A   1 b.
								dptr;
								rvpd(k,'1','1');
								y <= i;
								wait for 1 ns;
								tajm;
								Proc1;
			when "11110001" =>   acall("11100000000");    -- ACALL 111+ad8  2 b.
			when "11110010" =>                            -- MOVX @R0,A    1 b.
								proc2(k,RAM(bank+0));
								rvpd(k,'1','0');
								y <= i;
								wait for 1 ns;
								tajm;
								Proc1;
			when "11110011" =>                             -- MOVX @R1,A    1 b.
								proc2(k,RAM(bank+1));
								rvpd(k,'1','0');
								y <= i;
								wait for 1 ns;
								tajm;
								Proc1;
			when "11110100" =>  RAM(224) := not RAM(224);  -- CPL A         1 b.
			when "11110101" =>                             -- MOV ad,A  
								proc2(k,com);
								RAM(k)  := RAM(224);
								flag;
			when "11110110" =>                           -- MOV @R0,A     1 b.
								proc2(k,RAM(bank+0));
								RAM(k)  := RAM(224);
								flag;
			when "11110111" =>                           -- MOV @R1,A     1 b.
								proc2(k,RAM(bank+1));
								RAM(k)  := RAM(224);
								flag;
			
			when others => pr3(3 downto 0):= com1(7 downto 4);
								pr1:= "00000111" and com1;
								proc2(j,pr1);
								
								case pr3 is
									when "0010" => add(RAM(bank+j),'0');                   -- ADD A,Rj
									when "0011" => add(RAM(bank+j),'1');                   -- ADDC A,Rj.
									when "1111" => RAM(bank+j):= RAM(224);                 -- MOV Rj,A
									when "1110" => RAM(224):= RAM(bank+j);                 -- MOV A,Rj 
									when "1101" =>                                                -- DJNZ Rj,rel 
									dec_r(bank+j);                                    
									if RAM(bank+j) /= "00000000" then rel; 
									else 
										ccom := com;
										y <= i;     
										wait for 0.5ns;
										tajm;
										Proc1; 
										com := ccom;
										
									end if;
									when "1100" => xch(RAM(bank+j));                       -- XCH A,Rj 
									when "1011" => cjne(RAM(bank+j),com);                  -- CJNE Rj,#d,rel
									when "1010" => mov_r_ad(bank+j,0); ff:='1';                     -- MOV Rj,ad 
									when "1001" => subb(RAM(bank+j));                      -- SUBB A,Rj 
									when "1000" => proc2(k,RAM(bank+j));                   -- MOV ad,Rj 
									mov_r_ad(bank+j,1);  flag; ff:='1';                     
									when "0111" => mov_r_d(bank+j);                        -- MOV Rj,#d  
									when "0110" => RAM(224):= RAM(224) xor RAM(bank+j);    -- XRL A,Rj 
									when "0101" => RAM(224):= RAM(224) and RAM(bank+j);    -- ANL A,Rj 
									when "0100" => RAM(224):= RAM(224) or RAM(bank+j);     -- ORL A,Rj      
									when "0001" => dec_r(bank+j);                          -- DEC Rj  
									when "0000" => inc_r(bank+j);                          -- INC Rj 
								end case;
								
		end case;
		wait for 0.1 ns;
		if FBit = '0' then Ram_Bit;
		else Bit_ram; 
				FBit := '0';
		end if;										  
		
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Calculating parity Bit 
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
		pr:= RAM(224);
		b2:= '0';
		for j in 0 to 7 loop
			if b2 = pr(j) then  b2 := '0'; 
								else  b2 := '1';
			end if;
		end loop;
		pr := RAM(208);
		pr(0) := b2;
		RAM(208):= pr;
		if (ik mod 2) = 1 then
			y <= (i mod 2**16);   
			wait for 0.5 ns;
			tajm;
			Proc1;
			ffc := '1';
		end if;
		
		if ff = '1' then y <= i;
			wait for 0.5 ns;
			tajm;
			Proc1;
			y <= i;
			wait for 0.5 ns;
			tajm;
			Proc1;
		else 
		end if;
		
		zcom <= com; 
		DRAM <= RAM;
		Accumulator <= RAM(224);
		wait for 0.5 ns;
		
		SCONs <= RAM(152);			
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Reading Ports
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^				  
--
--		prp := RAM(128);
--		for j in 0 to 7 loop
--			if Port0(j) = '0' then prp(j) := '0'; end if;
--			if Port0(j) = '1' then prp(j) := '1'; end if;
--		end loop;
--		RAM(128) := prp;
--
--		prp := RAM(144); 
--		for j in 0 to 7 loop
--			if Port1(j) = '0' then prp(j) := '0'; end if;
--			if Port1(j) = '1' or Port1(j) ='H' then prp(j) := '1'; end if;
--		end loop; 
--		RAM(144) := prp;
--		prp := RAM(160);
--		for j in 0 to 7 loop
--			if Port2(j) = '0' then prp(j) := '0'; end if;
--			if Port2(j) = '1' or Port2(j) ='H' then prp(j) := '1'; end if;
--		end loop;
--		RAM(160) := prp;
--		prp := RAM(176);
--		for j in 0 to 7 loop 
--			if Port3(j) = '0' then prp(j) := '0'; end if;
--			if Port3(j) = '1'  or Port3(j) ='H' then prp(j) := '1'; end if;
--		end loop; 
--		RAM(176) := prp; 	
	
		-- reading  Ports      end   --
		
	end process kernel;			   
	
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	--
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (TFP,strb)
		variable i,j: Integer range 0 to 200;
		begin
		if strb'event then i:= 0; j:=0; end if;
		if SMOD(7) = '0' then j:= 2;
		else j:= 1;
		end if;  
		if ( i = 31 or  ( SMOD(7) = '0'  and  i = 30))
			then TFP1 <= not TFP1;
			i:=0;
			else  i:= i+j;
		end if;
		pop <= i;               
	end process;
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	--
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (CLK,strb)
		variable i,j: Integer range 0 to 200;
		begin 
		if strb'event then i:= 0; j:=0; end if;
		if SMOD(7) = '0' then j:= 2;
		else j:= 1; 
		end if;  
		if (i = 63 or ( SMOD(7) = '0'  and  i = 62 ))	 then
			utt1 <= not utt1;
					i:=0;
			else  i:= i+j;
		end if;
		ht1 <= i;               
	end process;
	
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--		Trigger of event
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (sdr1, PRP05)
		variable a: Bit;
		begin
		if a /= PRP05 then ZPP2 <= '0'; end if;    
		a:= PRP05;           
	end process;
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	--
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (flpp0,flpp1)
		variable a,b: Bit;
		begin 
		if flpp0 /= a then flpp <= '1'; end if;
		a:= flpp0; 
		if flpp1 /= b then flpp <= '0'; end if;
		b:= flpp1;
	end process;
	

--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
--  Serial Port. Receiving 
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- ### prijom po posl. Portu        begin ###-- 
	process  -- (SDR1)
		variable pr6:Bit_Vector (1 downto 0);
		variable i,j: Integer range 0 to 10;
		variable a: Bit;
		variable SBUFa1: Bit_Vector(7 downto 0);
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-- Port3 Logic
--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
impure		function p3(pin:Std_Logic;i:Integer) return Std_Logic is
			variable lev:Std_Logic;
		begin
			if (pp3(i)='1') and pin='H' then lev:='H';
			else lev:='0';
			end if;
			return lev;
		end; 
		begin
-- signals  zbuf,zpos,zsdv,zpp
		
		-- PRR1 is interrupt from T1
		if  PRP04 = '1' then PRR1 <= '0'; end if;
		wait for 5 ns;
		if start = '1' then 
			 pr6(0) := SCONs(7);
			pr6(1) := SCONs(6); 
	case pr6 is
		when "00"   =>
				if (SCONs(4) = '1' and SCONs(0) = '0' and prr1 = '0') then	
					PRP05 <= not PRP05;
					L_10:          for j in 0 to 0 loop 
						
						exit L_10 when rst = '1'; 
						Port3(1) <= p3('H',1) ;
						wait for 10 ns;
						L_1:           for i in 0 to 7 loop 			  
							wait on u6; Port3(1) <= '0'; wait on ut1; Port3(1) <= p3('H',1);
							PRBit <= utt;
							wait for 2 ns;
							While PRBit = utt loop 
								exit L_10 when zpp2 = '1';  
								exit L_10 when rst = '1'; 
								wait for 2 ns;
							end loop; 
							SBUFa1(0) :=  SBUFa1(1) ;       
							SBUFa1(1) :=  SBUFa1(2) ;      
							SBUFa1(2) :=  SBUFa1(3) ;      
							SBUFa1(3) :=  SBUFa1(4) ;      
							SBUFa1(4) :=  SBUFa1(5) ;      
							SBUFa1(5) :=  SBUFa1(6) ;      
							SBUFa1(6) :=  SBUFa1(7) ; 
							if Port3(0) = '1'  or  Port3(0) =  'H' then SBUFa1(7) := '1';                          
							else SBUFa1(7) := '0';
							end if;
						end loop;                              
						
						wait on utt;  
						Port3(1)<=p3('H',1)  ;
						Port3(0)<=p3('H',0)  ;                             
						PRR1 <= '1';                 -- form. interrupt  R1
						SBUF1 <= SBUFa1;
					end loop;
				else         
					Port3(1)<=  'H';
					Port3(0)<=  'H';        
					
					end if;
		when "01"   => 
				L_20:          for j in 0 to 0 loop               
					PRP05 <= not PRP05;
					While Port3(0) = '1' or  Port3(0) = 'H'  loop 
						exit L_20 when zpp2 = '1';  
						exit L_20 when rst = '1';  
						pr6(0) := SCONs(7);
						pr6(1) := SCONs(6); 
						exit L_20 when pr6 /= "01";  
						wait for 2 ns;
					end loop;
					
					strb <= not strb;   --counter reset
					PRBit <= utt1;
					wait for 2 ns;
					While PRBit = utt1 loop 
						exit L_20 when zpp2 = '1';  
						exit L_20 when rst = '1'; 
															  --noise removing:
						if ht1 = 7 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1';end if;  
								if Port3(0) = '0'  then q1 <= '0'; end if; 
						end if;
						if ht1 = 8 then 
								if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if; 
								if Port3(0) = '0'  then q2 <= '0'; end if; 
						end if;
						if ht1 = 9 then 
								if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
								if Port3(0) = '0'  then q3 <= '0'; end if;
						end if;
						wait for 2 ns;
					end loop;
					q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
					wait for 1 ps;
					exit L_20 when q1 = '1';
					
					L_2:           for i in 0 to 7 loop 
						exit L_2 when zpp2 = '1'; 
						exit L_2 when rst = '1'; 
						
						PRBit <= utt1;
						wait for 2 ns;
						While PRBit = utt1 loop 
							exit L_20 when zpp2 = '1';  
							exit L_20 when rst = '1'; 		 
									  --noise removing:
							if ht1 = 7 then 
									if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1'; end if; 
									if Port3(0) = '0'  then q1 <= '0'; end if; 
							end if;
							if ht1 = 8 then
									if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if;
									if Port3(0) = '0'  then q2 <= '0'; end if; 
							end if;
							if ht1 = 9 then
									if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
									if Port3(0) = '0'  then q3 <= '0'; end if; 
							end if;
							
							wait for 2 ns;
						end loop;		
						SBUFa1(0) :=  SBUFa1(1) ;       
						SBUFa1(1) :=  SBUFa1(2) ;      
						SBUFa1(2) :=  SBUFa1(3) ;      
						SBUFa1(3) :=  SBUFa1(4) ;      
						SBUFa1(4) :=  SBUFa1(5) ;      
						SBUFa1(5) :=  SBUFa1(6) ;      
						SBUFa1(6) :=  SBUFa1(7) ;  
						q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
						wait for 0.05 ns;
						if q1 = '1' then SBUFa1(7) := '1';
										else SBUFa1(7) := '0';
						end if;                                                
					end loop;
					
					
					PRBit <= utt1;
					wait for 2 ns;
					While PRBit = utt1 loop 
						exit L_20 when zpp2 = '1';  
						exit L_20 when rst = '1'; 				
														  	  --noise removing:
						if ht1 = 7 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1'; end if; 
								if Port3(0) = '0'  then q1 <= '0'; end if; 
						end if;
						if ht1 = 8 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if;
								if Port3(0) = '0'  then q2 <= '0'; end if; 
						end if;
						if ht1 = 9 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
								if Port3(0) = '0'  then q3 <= '0'; end if; 
						end if;
						
						wait for 2 ns;
					end loop;
					q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
					wait for 0.05 ns;
					
					if SCONs(5) = '0' then             
						PRR1 <= '1';  							
						SBUF1 <= SBUFa1;
						if q1 = '1' then sc2 <= '1' ;
										else sc2 <= '0'; 
						end if;  	
						flpp0 <= not flpp0;     
					else  
						if q1 = '1' then 
							SBUF1 <= SBUFa1;
							PRR1 <= '1'; 	 
							if q1 = '1' then sc2 <= '1'; 
											else sc2 <= '0'; end if;  	
							flpp0 <= not flpp0;  
							end if;          -- form. interrupt R1                    
					end if;            
					wait for 20 ns;
					
					While Port3(0) = '0' loop 
						exit L_20 when zpp2 = '1';  
						exit L_20 when rst = '1'; 
						wait for 2 ns;
					end loop;
					
				end loop;
				when "10"   => 
				L_30:          for j in 0 to 0 loop   
					PRP05 <= not PRP05;
					
					While Port3(0) = '1' or  Port3(0) = 'H'  loop 
						exit L_30 when zpp2 = '1';  
						exit L_30 when rst = '1';  
						pr6(0) := SCONs(7);
						pr6(1) := SCONs(6); 
						exit L_30 when pr6 /= "10"; 
						wait for 2 ns;
					end loop;
					
					strb <= not strb;   --counter reset
					PRBit <= TFP1;
					wait for 2 ns;
					While PRBit = TFP1 loop 
						exit L_30 when zpp2 = '1';  
						exit L_30 when rst = '1';  		 
												 -- noise filtering:
						if pop = 7 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1';  end if; 
								if Port3(0) = '0'  then q1 <= '0'; end if; 
						end if;
						if pop = 8 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if; 
								if Port3(0) = '0'  then q2 <= '0'; end if; 
						end if;
						if pop = 9 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
								if Port3(0) = '0'  then q3 <= '0'; end if; 
						end if;
						wait for 2 ns;
					end loop;               
					q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
					wait for 1 ps;
					exit L_30 when q1 = '1';
					
					for i in 0 to 7 loop 
						
						PRBit <= TFP1;
						wait for 2 ns;
						While PRBit = TFP1 loop 
							exit L_30 when zpp2 = '1';  
							exit L_30 when rst = '1';  			
																 --noise filtering:
							if pop = 7 then 
									if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1'; end if; 
									if Port3(0) = '0'  then q1 <= '0'; end if; 
							end if;
							if pop = 8 then
									if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if;
									if Port3(0) = '0'  then q2 <= '0'; end if; 
							end if;
							if pop = 9 then
									if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if;
									if Port3(0) = '0'  then q3 <= '0'; end if; 
							end if;
							wait for 2 ns;
							
						end loop;
						SBUFa1(0) :=  SBUFa1(1) ;       
						SBUFa1(1) :=  SBUFa1(2) ;      
						SBUFa1(2) :=  SBUFa1(3) ;      
						SBUFa1(3) :=  SBUFa1(4) ;      
						SBUFa1(4) :=  SBUFa1(5) ;      
						SBUFa1(5) :=  SBUFa1(6) ;      
						SBUFa1(6) :=  SBUFa1(7) ;  
						q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
						wait for 1 ps;
						if q1 = '1' then SBUFa1(7) := '1';           
											else SBUFa1(7) := '0';
						end if;                                             
					end loop;
				
					
					PRBit <= TFP1;
					wait for 2 ns;
					While PRBit = TFP1 loop 
						exit L_30 when zpp2 = '1';  
						exit L_30 when rst = '1'; 		 
														 --noise filtering
						if pop = 7 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1'; end if; 
								if Port3(0) = '0'  then q1 <= '0'; end if;
						end if;
						if pop = 8 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if; 
								if Port3(0) = '0'  then q2 <= '0'; end if;
						end if;
						if pop = 9 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
								if Port3(0) = '0'  then q3 <= '0'; end if; 
						end if;
						wait for 2 ns; 
					end loop;            
					q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
					wait for 1 ps;
					
					
					if SCONs(5) = '0' then   
						SBUF1 <= SBUFa1;
						PRR1 <= '1';     
						if q1 = '1' then sc2 <= '1'; 
									else sc2 <= '0';
						end if;  		
					flpp0 <= not flpp0;              
					else  
						if q1 = '1' then 
							SBUF1 <= SBUFa1;
							PRR1 <= '1'; 
							if q1 = '1' then sc2 <= '1'; 
											else sc2 <= '0';
							end if;  
							flpp0 <= not flpp0;  
						end if;          -- form. interrupt R1
					end if;            --						PRR1 <= '1';          
					wait for 20 ns;

				end loop;
		when "11"   => 
				L_40:          for j in 0 to 0 loop 
					PRP05 <= not PRP05;
         
					While Port3(0) = '1' or  Port3(0) = 'H' loop 
						exit L_40 when zpp2 = '1';  
						exit L_40 when rst = '1'; 
						pr6(0) := SCONs(7);
						pr6(1) := SCONs(6); 
						exit L_40 when pr6 /= "11";   
						wait for 2 ns;
					end loop;
					strb <= not strb;   --counter reset
					PRBit <= TFP1;
					wait for 2 ns;
					While PRBit = TFP1 loop 
						exit L_40 when zpp2 = '1';  
						exit L_40 when rst = '1';  	
												   					 --noise filtering
						if pop = 7 then 
								if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1'; end if;
								if Port3(0) = '0'  then q1 <= '0'; end if; 
						end if;
						if pop = 8 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if; 
								if Port3(0) = '0'  then q2 <= '0'; end if; 
						end if;
						if pop = 9 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
								if Port3(0) = '0'  then q3 <= '0'; end if; 
						end if;
						
						wait for 2 ns;
					end loop;             
					q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
					wait for 1 ps;
					exit L_40 when q1 = '1';
					
					for i in 0 to 7 loop            
						PRBit <= TFP1;
						wait for 2 ns;
						While PRBit = TFP1 loop 
							exit L_40 when zpp2 = '1';   
							exit L_40 when rst = '1'; 
							if pop = 7 then
									if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1'; end if; 
									if Port3(0) = '0'  then q1 <= '0'; end if;
							end if;
							if pop = 8 then
									if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if; 
									if Port3(0) = '0'  then q2 <= '0'; end if; 
							end if;
							if pop = 9 then
									if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
									if Port3(0) = '0'  then q3 <= '0'; end if;  
							end if;
							
							wait for 2 ns;
						end loop;     
						SBUFa1(0) :=  SBUFa1(1) ;       
						SBUFa1(1) :=  SBUFa1(2) ;      
						SBUFa1(2) :=  SBUFa1(3) ;      
						SBUFa1(3) :=  SBUFa1(4) ;      
						SBUFa1(4) :=  SBUFa1(5) ;      
						SBUFa1(5) :=  SBUFa1(6) ;      
						SBUFa1(6) :=  SBUFa1(7) ;  
						
						q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
						wait for 0.05 ns;
						if q1 = '1' then SBUFa1(7) := '1';                   
										else SBUFa1(7) := '0';
						end if;               
					end loop;           
					
					PRBit <= TFP1;
					wait for 2 ns;
					While PRBit = TFP1 loop 			--noise filtering
						exit L_40 when zpp2 = '1';  
						exit L_40 when rst = '1'; 
						if pop = 7 then 
								if Port3(0) = '1' or  Port3(0) = 'H' then q1 <= '1'; end if; 
								if Port3(0) = '0'  then q1 <= '0'; end if;
						end if;
						if pop = 8 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q2 <= '1'; end if;
								if Port3(0) = '0'  then q2 <= '0'; end if;
						end if;
						if pop = 9 then
								if Port3(0) = '1' or  Port3(0) = 'H' then q3 <= '1'; end if; 
								if Port3(0) = '0'  then q3 <= '0'; end if; 
						end if;
						wait for 2 ns; 
					end loop;            
					q1 <= (q1 and q2) or (q1 and q3) or (q2 and q3);
					wait for 0.05 ns;
					
					if SCONs(5) = '0' then 
						SBUF1 <= SBUFa1;
						PRR1 <= '1';  
						if q1 = '1' then sc2 <= '1';
										else sc2 <= '0';
						end if;  	
						flpp0 <= not flpp0;                
					else  
						if q1 = '1' then 
							SBUF1 <= SBUFa1;
							PRR1 <= '1';  
							if q1 = '1' then sc2 <= '1'; 
										else sc2 <= '0';
							end if;  		 
						flpp0 <= not flpp0;  
						end if;          -- form. interrupt R1
					end if;
					wait for 20 ns;
					While Port3(0) = '0' loop 
						exit L_40 when zpp2 = '1';  
						exit L_40 when rst = '1'; 
						wait for 2 ns;
					end loop;
					
			end loop;                                      
		end case; 
	end if;
		
		
		wait for 0.1 ns;
end process; 
	-- ### Serial port receiving          end ###--  
	
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	--
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (TFP,strb)
		variable i,j: Integer range 0 to 200;
	begin
		if strb'event then i:= 0; j:=0; end if;
		if SMOD(7) = '0' then j:= 2;
									else j:= 1; 
		end if;  
		if ( i = 31 or  ( SMOD(7) = '0'  and  i = 30)) 	  then 
			TFP1p <= not TFP1p;
			i:=0;
		else  i:= i+j;
		end if;
		popp <= i;               
	end process;
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	--
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process (CLK,strb)
		variable i,j: Integer range 0 to 200;
	begin 
		if strb'event then 
			i:= 0;
			j:=0;  
		end if;
		if SMOD(7) = '0' then j:= 2;
									else j:= 1; 
		end if;  
		if (i = 63 or  ( SMOD(7) = '0'  and  i = 62)) then 
			utt1p <= not utt1p;
			i:=0;
		else  i:= i+j;
		end if;
		ht1p <= i;               
	end process;
	

	process (sdr, PRP02)
		variable a: Bit;
	begin
		zpp1 <= '1' after 1 ns,
						'0' after 5 ns;
		zpp <= '1';        
		if a /= PRP02 then 
				ZPP <= '0';
		end if;    
		a:= PRP02;           
	end process;
	
	
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	--  Serial Port. Sending
	--^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
	process 
		variable pr6:Bit_Vector (1 downto 0);
		variable i,j: Integer range 0 to 10;
		
	impure	function p3(pin:Std_Logic;i:Integer) return Std_Logic is
			variable lev:Std_Logic;
		begin
			if( (pp3(i)='1') and pin='H')	 then
					lev:='H';
			else lev:='0';
			end if;
			return lev;
		end; 
		
		begin
		if  PRP03 = '1' then PRT1 <= '0'; end if;
		if start = '1' then
			--### zpp is formed by SDR and reset by PRP02
			if zpp = '1' then
				pr6(0) := SCONs(7);
				pr6(1) := SCONs(6);  
				wait on utt;
				PRP02 <= not PRP02;
				case pr6 is
					when "00"   =>
								Port3(1)<=p3('H',1)  ;
								wait for 10 ns;
				L_1:          for i in 0 to 7 loop 
									exit L_1 when zpp = '1';   
									exit L_1 when rst = '1'; 
									wait on utt;             
									if SBUFs(i) = '1' then Port3(0)<=p3('H',0);
									else Port3(0)<= '0';
									end if;
									wait on ut3;
									Port3(1)<= '0';
									wait on ut2; 
									Port3(1)<= p3('H',1);
								end loop;                              
								if zpp = '0' then
									wait on utt;                                             
									PRT1 <= '1';      -- form. interrupt T1   
								end if;         
								Port3(1)<=p3('H',1); 
								Port3(0)<=p3('H',0);   
					
					when "01"   => 
				L_20:         for j in 0 to 0 loop              
								Port3(1)<= p3('H',1);
								wait for 10 ns;
								Port3(1)<= '0';           -- start Bit
								if zpp = '0' then
									L_2:           for i in 0 to 7 loop 
										exit L_2 when zpp = '1';  
										exit L_20 when rst = '1'; 
										PRBit1 <= utt1p;
										wait for 2 ns;
										While PRBit1 = utt1p loop 
											exit L_20 when zpp = '1';   
											exit L_20 when rst = '1'; 
											wait for 2 ns;
										end loop;
										
										if SBUFs(i) = '1' then Port3(1)<=p3('H',1);
										else Port3(1)<= '0';
										end if;                                                
									end loop;
								if zpp = '0' then
										PRBit1 <= utt1p;
										wait for 2 ns;
										While PRBit1 = utt1p loop 
											exit L_20 when zpp = '1';   
											exit L_20 when rst = '1'; 
											wait for 2 ns;
										end loop;
										if SCONs(3) = '1' then 
												Port3(1)<=p3('H',1);
										else Port3(1)<= '0';				 -- 9 Bit TB8
								end if;  
										
										if zpp = '0' then 
											PRBit1 <= utt1p;
											wait for 2 ns;
											While PRBit1 = utt1p loop 
												exit L_20 when zpp = '1';   
												exit L_20 when rst = '1'; 
												wait for 2 ns;
											end loop;
											
											Port3(1)<= p3('H',1);                 -- stop Bit
											PRT1 <= '1';                    -- form. interrupt T1
											wait for 20 ns;
											Port3(1) <= p3('H',1);
										end if;
									end if;
								end if;
							end loop; 
					when "10"   => 
						L_30:     for j in 0 to 0 loop 
									Port3(1)<= p3('H',1);
									wait for 10 ns;
									PRBit1 <= TFP1p;
									wait for 2 ns;
									While PRBit1 = TFP1p loop 
										exit L_30 when zpp = '1';   
										exit L_30 when rst = '1'; 
										wait for 2 ns;
									end loop;
									Port3(1)<= '0';                     -- start Bit
									if zpp = '0' then
					    L_3:           for i in 0 to 7 loop 
											exit L_3 when zpp = '1';   
											exit L_30 when rst = '1'; 
											PRBit1 <= TFP1p;
											wait for 1 ns;
											While PRBit1 = TFP1p loop 
												exit L_30 when zpp = '1';   
												exit L_30 when rst = '1'; 
												wait for 1 ns;
											end loop;
											
											if SBUFs(i) = '1' then
												    Port3(1)<= p3('H',1);  
											else Port3(1)<= '0'; 
											end if;                                                        
										end loop;
										if zpp = '0' then
											PRBit1 <= TFP1p;
											wait for 1 ns;
											While PRBit1 = TFP1p loop 
												exit L_30 when zpp = '1';   
												exit L_30 when rst = '1'; 
												wait for 1 ns;
											end loop;
											
											Port3(1)<=p3('H',1);                 -- stop Bit
											PRT1 <= '1';                    -- form. interrupt T1
											wait for 20 ns;
											Port3(1) <= p3('H',1);
										end if; 
									end if; 
								end loop;              
					when "11"   => 
					L_40:          for j in 0 to 0 loop 
									Port3(1)<=p3('H',1);
									wait for 10 ns;
									PRBit1 <= TFP1p;
									wait for 2 ns;
									While PRBit1 = TFP1p loop 
										exit L_40 when zpp = '1';   
										exit L_40 when rst = '1'; 
										wait for 2 ns;
									end loop;
									Port3(1)<= '0';                   -- start Bit
									if zpp = '0' then               
										L_4:           for i in 0 to 7 loop 
											exit L_4 when zpp = '1';  
											exit L_40 when rst = '1'; 
											PRBit1 <= TFP1p;
											wait for 2 ns;
											While PRBit1 = TFP1p loop 
												exit L_40 when zpp = '1';   
												exit L_40 when rst = '1'; 
												wait for 2 ns;
											end loop;
											
											if SBUFs(i) = '1' then 
													Port3(1)<= p3('H',1);
											else Port3(1)<= '0';
											end if;                                                
										end loop;
										if zpp = '0' then
											PRBit1 <= TFP1p;
											wait for 2 ns;
											While PRBit1 = TFP1p loop 
												exit L_40 when zpp = '1';   
												exit L_40 when rst = '1'; 
												wait for 2 ns;
											end loop;              
											
											if SCONs(3) = '1' then
													Port3(1)<=p3('H',1);
											else Port3(1)<= '0';				 -- 9 Bit TB8
											end if;  
											if zpp = '0' then               
												
												PRBit1 <= TFP1p;
												wait for 2 ns;
												While PRBit1 = TFP1p loop 
													exit L_40 when zpp = '1';   
													exit L_40 when rst = '1'; 
													wait for 2 ns;
												end loop;
												Port3(1)<=p3('H',1);                   -- stop Bit
												PRT1 <= '1';                      -- form. interrupt T1
												wait for 20 ns;
											end if;
										end if;
									end if;             
								end loop;                 
								Port3(1) <= p3('H',1); 
				end case;                       
			end if;
		else PRP02 <= not PRP02;
		end if;
		Port3(0) <= 'H';
		Port3(1) <= 'H'; 
		wait for 0.1 ns;
	end process; 
	-- ### Serial port sending   end ###--  
	
end AL8051_ARCH;









