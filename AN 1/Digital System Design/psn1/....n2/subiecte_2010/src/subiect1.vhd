--sau exclusiv
entity xor_b is 
	port (a, b: in bit;
	y: out bit);
end xor_b;
architecture sau_exclusiv of xor_b is 
begin 
	y<=a xor b;
end sau_exclusiv;

--coincidenta
entity xnor_b is  
	port (a, b: in bit;
	y:out bit);
end	xnor_b;
architecture coincidenta of xnor_b is 
begin 
	y<=a xnor b;
end coincidenta;

--poarta si
entity and_b is 
	port (a, b: in bit;
	y: out bit);
end and_b; 
architecture poarta_si of and_b is 
begin 
	y<=a and b;
end poarta_si ;

--poarta sau 
entity or_b is 
	port (a, b: in bit;
	y: out bit);
end or_b;
architecture poarta_sau of or_b is 
begin 
	y<=a or b;
end poarta_sau;

--poarta nu 
entity not_b is 
	port (a: in bit;
	b : out bit);
end not_b;
architecture poarta_nu of not_b is
begin 
	b<= not a;
end poarta_nu;
-- descrierea structurala si-sau-nu 
entity si_sau_nu is 
	port (a, b, c, d : in bit;
	q: out bit);
end si_sau_nu;
architecture struct of si_sau_nu is 
component and_b is 
	port (a, b: in bit;
	y: out bit);
end component;
component or_b is 
	port (a, b: in bit;
	y: out bit);
end component;
component  not_b is 
	port (a: in bit;
	b : out bit);
end component;
signal x,t, z, y: bit;
begin 
	si1: and_b port map (a, b,x);
	si2: and_b port map (c, d, t);
	sau: or_b port map (x, t, y);
	nu : not_b port map (y, z);
end struct;

	


	
	
