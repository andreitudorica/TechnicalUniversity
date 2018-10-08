--10.Comparator de egalitate pe 2 biti ñ descriere structural„	 
--11.Comparator de egalitate pe 2 bi—i ñ descriere comportamental„
--12.Comparator de egalitate pe 2 bi—i ñ descriere ìflux de dateî
entity comparator is 
	port (s1, s2 : in bit_vector (0 to 1);
	y: out bit_vector(0 to 1));
end comparator;
architecture comportamentala of comparator is 
begin 
	process (s1, s2)
	begin 
		if (s1<s2) then 
			y<="01";
		else if (s1>s2) then 
		y<="10"; else
			y<="00";
		end if;
		end if;
		end process;
	end comportamentala;

architecture flux_de_date of comparator is 
begin
		y<= "01" when (s1<s2)else 
		"10" when (s1>s2) else
		"00";
	end flux_de_date;
	
entity coincidenta is 
	port (a, b: in bit;
	c: out bit);
end coincidenta;
architecture arh_coincidenta of coincidenta is 
begin 
	c<=a xnor b;
end arh_coincidenta;

entity si is 
	port (a, b: in bit;
	c: out bit);
end si;
architecture poarta_si of si is 
begin 
	c<=a and b;
end poarta_si;

architecture structurala of comparator is 
component coincidenta is 
	port (a, b: in bit;
	c: out bit);
end component;
component si is 
	port (a, b: in bit;
	c:out bit);
end component;
signal y1, y2: bit;
begin			     
	c1:coincidenta port map (s1(0), s2(0), y1);
	c2:coincidenta port map (s2(1), s2(1), y2);
	c3: si port map (y1, y2, y(0));
end structurala;

	
	
