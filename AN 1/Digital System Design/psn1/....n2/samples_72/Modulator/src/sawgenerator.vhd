------------------------------------------------------------------------------
-- Subject     : Waveform and Tcl/Tk Demo
-- File name   : SawGenerator.VHD
-- Revision    : 1.3
-- Date        : 02/24/99
-- Developer   : Michal Pacula
-- Copyright   : (C) 1999 ALDEC Inc.
-- Description : Saw Generator with real type output.
------------------------------------------------------------------------------
library IEEE;
use IEEE.MATH_REAL.all;

entity SawGenerator is
	port (	
		CLK: in bit;   		
		SawEnable: in bit;
		SawFreq: integer;
		SAW1: out real :=0.0
		);
end SawGenerator;

architecture SawGenerator of SawGenerator is 
	signal VALUE_X : real :=0.0;	 
	signal delta : real;
	
	begin	  
	delta <= MATH_PI*real(SawFreq)/1000.0;
	process (clk)
		begin
		if SawEnable='1' then
			if clk='1' and clk'event then 	
				VALUE_X <= "MOD"(VALUE_X+delta,2.0*MATH_PI); 
				SAW1 <= VALUE_X * MATH_1_OVER_PI - 1.0;
			end if;	  
		else
			SAW1 <= 1.0;
		end if;
	end process;
	
end SawGenerator;
