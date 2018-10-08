entity bcd_exces is
	port (A3,A2,A1,A0 :in bit;
		 Q3,Q2,Q1,Q0 :out bit);
end bcd_exces;

architecture arh_bcd_exces of bcd_exces is					 
signal Y_poarta_sau_exclusiv, Y_poarta_si, Y_poarta_sau :bit;

component poarta_sau  
	port(A,B :in bit;
		 Y: out bit);
end component;

component poarta_si
	port(A,B :in bit;
		 Y: out bit);
end component;

component inversor	  
	port(A :in bit;
		 Y: out bit);
end component;

component poarta_sau_exclusiv 
	port(A,B :in bit;
		 Y: out bit);
end component;

begin
	
C1: poarta_si port map(Y_poarta_sau, A2,Y_poarta_si);
C2: poarta_sau port map(A1,A0,Y_poarta_sau);
C3: inversor port map(Y_poarta_sau_exclusiv, Q1);
C4: poarta_sau_exclusiv port map(A1,A0, Y_poarta_sau_exclusiv);
C5: inversor port map(A0,Q0);
C6: poarta_sau_exclusiv port map (y_poarta_sau, A2,Q2);
C7: poarta_sau port map(Y_poarta_si,Y_poarta_sau,Q3);

end arh_bcd_exces;


entity poarta_sau is
	port(A,B :in bit;
		 Y: out bit);
end poarta_sau;
architecture arh_poarta_sau of poarta_sau is
begin
	Y<=A or B;
end arh_poarta_sau;

entity poarta_si is
	port(A,B :in bit;
		 Y: out bit);
end poarta_si;
architecture arh_poarta_si of poarta_si is
begin
	Y<=A and B;
end arh_poarta_si;

entity poarta_sau_exclusiv is
	port(A,B :in bit;
		 Y: out bit);
end poarta_sau_exclusiv;
architecture arh_poarta_sau_exclusiv of poarta_sau_exclusiv is
begin
	Y<=A xor B;
end arh_poarta_sau_exclusiv;

entity inversor is
	port(A :in bit;
		 Y: out bit);
end inversor;
architecture arh_inversor of inversor is
begin
	Y<= not(A);
end arh_inversor;