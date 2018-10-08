
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top is
end top;

architecture top of top is

	signal p : std_logic;

	component inst is
		generic (g : integer);
		port ( p : std_logic);
	end component;

begin

	ii0 : inst generic map (g => 15)
	port map (p => p);

end top;
