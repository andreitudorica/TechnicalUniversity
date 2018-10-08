------------------------------------------------------------------------------
-- Subject     : Waveform and Tcl/Tk Demo
-- File name   : SineGenerator.VHD
-- Revision    : 2.0
-- Date        : 06/07/99
-- Developer   : Michal Pacula
-- Copyright   : (C) 1999 ALDEC Inc.
-- Description : Sine Generator with real type output.
------------------------------------------------------------------------------
library IEEE;
use IEEE.MATH_REAL.all;

entity SineGenerator is
	port (	
		CLK: in bit;  
		SinEnable: in bit;
		SinFreq: integer;
		SIN1: out real :=0.0
		);
end SineGenerator;

architecture SineGenerator of SineGenerator is 
	signal VALUE_X : real :=0.0; 
	signal delta : real;
	begin	
	delta <= MATH_PI*real(SinFreq)/1000.0;
	process (clk,SinEnable)
		begin		
		if SinEnable='1' then
			if clk='1' and clk'event then 
				VALUE_X <= "MOD"(VALUE_X+delta,2.0*MATH_PI); 
				SIN1 <= SIN(VALUE_X);
			end if;
		else
			SIN1 <= 1.0;
		end if;
	end process;
	
end SineGenerator;
