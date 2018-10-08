library ieee; 	 
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.std_logic_arith.all;

	   
entity operations is
	port(	SEL : in std_logic_vector(1 downto 0);
	a,b: in std_logic_vector (3 downto 0);	 
	y: out std_logic_vector (7 downto 0)); 	
end entity;	   

architecture operatii of operations is	  
component adunare is
	port (SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0); 
	y: out std_logic_vector (7 downto 0));	
end component;

component scadere is
	port (SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0);
	y: out std_logic_vector (7 downto 0));	
end component;

component inmultire is
	port (SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0); 
	y: out std_logic_vector (7 downto 0));	
end component;

component impartire is
	port (SEL: in std_logic_vector (1 downto 0);
	a,b: in std_logic_vector (3 downto 0); 
	y: out std_logic_vector (7 downto 0));	
end component;

component multiplexor is
	port ( SEL: in std_logic_vector (1 downto 0);
	a,b,c,d: in std_logic_vector (7 downto 0);
	y: out std_logic_vector (7 downto 0));
end component;

signal y1,y2,y3,y4: std_logic_vector (7 downto 0);


begin			  
	op_1 : adunare port map (SEL,a,b,y1);		 -- creeam rezultatele pentru fiecare operatie
	op_2 : scadere port map (SEL,a,b,y2);
	op_3 : inmultire port map (SEL,a,b,y3);
	op_4 : impartire port map (SEL,a,b,y4);	  
	
	mux_1: multiplexor port map(SEL,y1,y2,y3,y4,y);	-- outputurile fiecarei operatii va deveni input pentru multiplexor, urmand ca in functie de selectie sa devina output din nou

end operatii;	