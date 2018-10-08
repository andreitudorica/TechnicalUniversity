library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity Decodificator is
	 port(
		 a : in BIT;
		 b : in BIT;
		 c : in BIT;
		 d : in BIT;
		 zero : out BIT;
		 unu : out BIT;
		 doi : out BIT;
		 trei : out BIT;
		 patru : out BIT;
		 cinci : out BIT;
		 sase : out BIT;
		 sapte : out BIT;
		 opt : out BIT;
		 noua : out BIT;
		 zece : out BIT;
		 unsprezece : out BIT;
		 doisprezece : out BIT;
		 treisprezece : out BIT;
		 paisprezece : out BIT;
		 cincisprezece : out BIT
	     );
end Decodificator;

--}} End of automatically maintained section

architecture Arhitectura of Decodificator is
begin

	 -- enter your statements here --

zero <= not(not(a) and not(b) and not(c) and not(d));
unu <= not(not(a) and not(b) and not(c) and d);
doi <= not(not(a) and not(b) and c and not(d));
trei <= not(not(a) and not(b) and c and d);
patru <= not(not(a) and b and not(c) and not(d));
cinci <= not(not(a) and b and not(c) and d);
sase <= not(not(a) and b and c and not(d));
sapte <= not(not(a) and b and c and d);
opt <= not(a and not(b) and not(c) and not(d));
noua <= not(a and not(b) and not(c) and d);
zece <= not(a and not(b) and c and not(d));
unsprezece <= not(a and not(b) and c and d);
doisprezece <= not(a and b and not(c) and not(d));
treisprezece <= not(a and b and not(c) and d);
paisprezece <= not(a and b and c and not(d));
cincisprezece <= not(a and b and c and d);

end Arhitectura;
