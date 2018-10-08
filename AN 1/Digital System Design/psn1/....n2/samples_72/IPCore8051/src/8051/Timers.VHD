--------------------------------------------------------------------------------------
-- Copyright (c) 1999 by Alatek. All rights reserved.
--
-- DESIGN        :   AL8051
-- FILE NAME     :   timers.vhd
-- DESCRIPTION   :   Auxiliary
--
-- CREATED       :   01/01/1999
-- MODIFIED      :   
-- VERSION       :   1.0
-- AUTHOR        :   Anatoli Sergyienko, Volodymir Lepekha
-- HISTORY       :   
--------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;
use work.registers.all;

entity Timer is
	port (
		l0: in BIT_VECTOR (7 downto 0);
		h0: in BIT_VECTOR (7 downto 0);
		l1: in BIT_VECTOR (7 downto 0);
		h1: in BIT_VECTOR (7 downto 0);
		TCON: in BIT_VECTOR (7 downto 0);
		l0a: out BIT_VECTOR (7 downto 0);        
		h0a: out BIT_VECTOR (7 downto 0);
		l1a: out BIT_VECTOR (7 downto 0);
		h1a: out BIT_VECTOR (7 downto 0);
		tcona: out BIT_VECTOR (7 downto 0);
		TMOD: in BIT_VECTOR (7 downto 0);        
		port3: in std_logic_vector (7 downto 0);  
		s: in BIT;
		TFP: out BIT
		);
end Timer;

architecture Timer of Timer is
	
	signal bb,aa :bit; 
	
begin
	
	process(s)
		variable pr,pr1,TL0,TH0,TL1,TH1:Bit_vector (7 downto 0);
		variable pr60,pr61:Bit_vector (1 downto 0);
		variable b,b1,b2,b3,b4:Bit := '0';
		variable G0,G1,CT0,CT1,M00,M01,M10,M11:Bit := '0';
		variable TR0,TR1,TF0,TF1,INT0,INT1,T0,T1:Bit := '0';
		variable fp: BIT;					   
		
		procedure inc (l: inout Bit_vector (7 downto 0) ) is        -- INC 
			variable j: integer range 0 to 8;
			
		begin	
			for j in 0 to 7 loop
				if b /= l(j) then l(j):= '1'; b:= '0';
				else b:= b and l(j); l(j):= '0';
				end if;            
			end loop;	                
		end procedure inc;
		
		
		begin
		if port3(2) = '1' or port3(2) = 'H' then INT0 := '1'; end if;
		if port3(2) = '0' then INT0 := '0'; end if;
		if port3(3) = '1' or port3(3) = 'H' then INT1 := '1'; end if;
		if port3(3) = '0' then INT1 := '0'; end if;
		if port3(4) = '1' or port3(4) = 'H' then T0 := '1'; end if;
		if port3(4) = '0' then T0 := '0'; end if;
		if port3(5) = '1' or port3(5) = 'H' then T1 := '1'; end if;
		if port3(5) = '0' then T1 := '0'; end if;
		
		TH0:= h0;
		TL0:= l0;
		TH1:= h1;
		TL1:= l1; 
		pr:= TMOD;          -- TMOD
		pr1:=TCON;          -- TCON
		
		G0:= pr(3);
		G1:= pr(7);
		CT0:= pr(2);
		CT1:= pr(6);
		M00:= pr(0); 
		M01:= pr(1);
		M10:= pr(4);
		M11:= pr(5);
		TR0:= pr1(4);
		TR1:= pr1(6);
		TF1 := '0';
		TF0 := '0';
		-- timer0
		b:= '0';
		b1:= G0 and (G0 xor INT0);
		if TR0 = '1' then
			if b1 = '0' then
				if CT0 = '0' then b:= '1';
				else b:= b2 and (not T0); b2:= T0;
				end if;            
			end if;             
		end if;
		pr60(1):= M01; pr60(0):= M00;
		case pr60 is
			when "00" => 
								inc(TL0);
								b:= TL0(5); 
								TL0:= TL0 and "00011111";
								inc(TH0);
								TF0:= b;
			when "01" => inc(TL0);
								inc(TH0); 
								TF0:= b;
			when "10" => inc(TL0); 
								TF0:= b;
								if b = '1' then TL0:= TH0; end if;
			when "11" => inc(TL0);
								TF0:= b;
								b1:= (G1 and (G1 xor INT1)) or CT1;
								b:='0';
								if TR1 = '1' then
									if b1 = '0' then b:= '1';
									end if;      
								end if;
								 inc(TH0); TF1:= b;
		end case;
		pr1(7):= TF1 or pr1(7);
		pr1(5):= TF0 or pr1(5);
		b:= '0';
		
		b1:= (G1 and (G1 xor INT1)) or (M11 and M10);
		if TR1 = '1' then
			if b1 = '0' then
				if CT1 = '0' then b:= '1';
				else b:= b2 and (not T1); 
						b2:= T1;
				end if;            
			end if;             
		end if;
		pr61(1):= M11; pr61(0):= M10;
		case pr61 is
			when "00" => inc(TL1);
								b:= TL1(5); 
								TL1:= TL1 and "00011111";
								inc(TH1); 
								TF1:= b;
			when "01" => inc(TL1);
								inc(TH1);
								TF1:= b;
			when "10" => inc(TL1); 
								TF1:= b; 
								if b = '1' then
										TL1:= TH1;
										FP := not FP;
								end if;
								TFP <= FP;
			when "11" => 
		end case;
		-- end timer1
		if PR60 /= "11" then
					pr1(7):= TF1 or pr1(7); 
		end if; 
		pr1(5):= TF0 or pr1(5);
		TCONa <= pr1;
		h0a <= TH0;
		l0a <= TL0;
		h1a <= TH1;
		l1a <= TL1;
		bb <= b;
	end process;  
end Timer;






