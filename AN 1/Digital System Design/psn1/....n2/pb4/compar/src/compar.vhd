

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity compar is  
	port (a,b,c,d:in bit;
	      f1,f2,f3:out bit); 
end compar;	

entity poarta_sau is
	port(x,y:in bit;
	z:out bit);
end poarta_sau;

architecture arh_sau of poarta_sau is
begin
	z<=x or y;
end arh_sau;


entity poarta_si is
	port(x,y:in bit;
	z:out bit);
end poarta_si; 

 architecture arh_si of poarta_si is
begin
	z<=x and y;
end arh_si;

 entity inversor is
	port(x:in bit;
	z:out bit);
end inversor; 

architecture arh_inv of inversor is
begin
	z<=not x;
end arh_inv;   

entity coincidenta is
	port(x,y:in bit;
	z:out bit);
end coincidenta; 

architecture arh_coincidenta of coincidenta is
begin
	z<=(x and y) or ((not x) and (not y));
end arh_coincidenta;   

										   

architecture arhcompar of compar is	  
component poarta_sau is
	port(x,y:in bit;
	z:out bit);
end component poarta_sau;

component poarta_si is
	port(x,y:in bit;
	z:out bit); 
end component poarta_si;  	 

component inversor is
	port(x:in bit;
	z:out bit); 
end component inversor;		 

component coincidenta is
	port(x,y:in bit;
	z:out bit);
end component coincidenta;

signal 
	  y1,y2,y3,y4,y5,y6,y7,y8,y9,y10,y11,y12,y13:bit;
begin
	u1: inversor port map(c,y1);
	u2:poarta_si port map(a,y1,y2);
	u3:coincidenta port map(a,c,y3);
	u4:inversor port map(d,y4);
	u5:poarta_si port map(b,y4,y5);
	u6:poarta_si port map(y3,y5,y6);
	u7:poarta_sau port map(y2,y6,f1);
	
	u8:coincidenta port map(a,c,y7); 
	u9:coincidenta port map(b,d,y8);
	u10:poarta_si port map(y7,y8,f2);
	
	u11:inversor port map(a,y9);	
	u12:poarta_si port map(y9,c,y10);
	u13:inversor port map(b,y11); 
	u14:poarta_si port map(y11,d,y12);
	u15:poarta_si port map(y7,y12,y13);
	u16:poarta_sau port map(y10,y13,f3);  
	
	 
end arhcompar;
