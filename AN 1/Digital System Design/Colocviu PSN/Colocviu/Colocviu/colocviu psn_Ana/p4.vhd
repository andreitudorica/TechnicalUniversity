entity comparator is
	port (A,B,C,D : in bit;
		  Y: out bit);
end comparator; 

architecture arh_comparator of comparator is 
signal Y1,Y2: bit;


component poarta_si  
	port(A,B :in bit;
		 Y: out bit);
end component;						

component poarta_coincidenta
	port(A,B :in bit;
		 Y: out bit);
end component;
	
begin
C1: poarta_si port map(Y1,Y2,Y);
C2: poarta_coincidenta port map (A,C,Y1); 
C3: poarta_coincidenta port map (B,D,Y2);

end arh_comparator;


entity poarta_si is
	port(A,B :in bit;
		 Y: out bit);
end poarta_si;
architecture arh_poarta_si of poarta_si is
begin
	Y<=A and B;
end arh_poarta_si;


entity poarta_coincidenta is
	port(A,B :in bit;
		 Y: out bit);
end poarta_coincidenta;
architecture arh_poarta_coincidenta of poarta_coincidenta is
begin
	Y<=not(A xor B);
end arh_poarta_coincidenta;