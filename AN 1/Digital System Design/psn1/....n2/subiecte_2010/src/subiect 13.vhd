--Scãzãtor complet pe 1 bit – descriere structuralã
--sau exclusiv
entity xor_b is 
	port (a, b, c: in bit;
	y: out bit);
end xor_b;
architecture sau_exclusiv of xor_b is 
begin 
	y<=a xor b xor c;
end sau_exclusiv;
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
	port (a, b, c: in bit;
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

entity scazator is 
	port (an, t, bn: in bit;
	d, y: out bit);
end scazator;
architecture scasator_arh of scazator is 
	component xor_b is 
		port (a, b, c: in bit;
	y: out bit);
	end component ;
	component not_b is 
	port (a: in bit;
	b : out bit);
	end component ;
	component and_b is 
	port (a, b: in bit;
	y: out bit);
	end component;
	component or_b is 
	port (a, b, c: in bit;
	y: out bit);
	end component; 
	signal ann,x1,x2, x3 : bit;  
	begin 
		c1: xor_b port map (an , bn, t, d);
		c2: not_b port map (an, ann);
		c3: and_b port map (ann, bn, x1);
		c4: and_b port map (t,bn, x2);
		c5: and_b port map (t, ann, x3);
		c6: or_b port map (x1, x2, x3, y);
	end architecture ;
	
	
	
