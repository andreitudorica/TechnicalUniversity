-------------------------------------------------------------------------------
--
-- Title       : exces3
-- Design      : exces3
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : exces3.vhd
-- Generated   : Sat May  7 20:44:39 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {exces3} architecture {exces3}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity exces3 is
	port(b0,b1,b2,b3:in bit;
	e0,e1,e2,e3:out bit);
end entity exces3;

entity poarta_si2 is
	port(a,b:in bit;
	     ysi:out bit);
end poarta_si2;

architecture arh_si2 of poarta_si2 is
begin	   
	 ysi<=a and b;
end arh_si2;	

 entity poarta_sau2 is
	port(a,b:in bit;
	     ysau:out bit);
end poarta_sau2;

architecture arh_sau2 of poarta_sau2 is
begin	   
	 ysau<=a or b;
end arh_sau2;	


entity poarta_sau3 is
	port(a,b,c:in bit;
	     ysau3:out bit);
end poarta_sau3;

architecture arh_sau3 of poarta_sau3 is
begin	   
	 ysau3<=a or b or c;
end arh_sau3;	

entity poarta_si3 is
	port(a,b,c:in bit;
	     ysi3:out bit);
end poarta_si3;

architecture arh_si3 of poarta_si3 is
begin	   
	 ysi3<=a and b and c;
end arh_si3;	



entity inversor is
	port(a:in bit;
	     yn:out bit);
end inversor;

architecture arh_inv of inversor is
begin	   
	 yn<=not a;
end arh_inv;	


architecture arhexces3 of exces3 is
component poarta_si2 is
	port(a,b:in bit;
	     ysi:out bit);
end component poarta_si2;	   

component poarta_sau2 is
	port(a,b:in bit;
	     ysau:out bit);
end component poarta_sau2;		   

component poarta_sau3 is
	port(a,b,c:in bit;
	     ysau3:out bit);
end component poarta_sau3;

component inversor is
	port(a:in bit;
	     yn:out bit);
end component inversor;	

component poarta_si3 is
	port(a,b,c:in bit;
	     ysi3:out bit);
end component poarta_si3;
 
	signal x0,x1,x2,x3:bit;	
	signal y0,y1,y2,y3,y4,y5,y6,y7,y8,y9,y10:bit;
	signal i0,i1,i2,i3:bit;
	
	begin
		u1: poarta_si2 port map (b1,b3,y0);
		u2: poarta_si2 port map (b1,b2,y1);
		u3: poarta_sau3	port map(b0,y0,y1,e0);

		u4: inversor port map (b1,y2);
		u5: poarta_si2 port map (b3,y2,y3);
		u6: poarta_si2 port map (b2,y2,y4);		
		u7: inversor port map (b2,y5);
		u8: inversor port map (b3,y6);
		u9: poarta_si3 port map (y5,y6,b1,y7); 
		u10:poarta_sau3 port map (y3,y4,y7,e1);
		
		u11:poarta_si2 port map (y5,y6,y8);	
		u12:poarta_si2 port map (b2,b3,y9);
		u13:poarta_sau2 port map (y8,y9,e2);  
		
		u14:poarta_si2 port map(b2,y6,y10);
		u15:poarta_sau2 port map(y8,y10,e3);
		
		
			
end arhexces3;
