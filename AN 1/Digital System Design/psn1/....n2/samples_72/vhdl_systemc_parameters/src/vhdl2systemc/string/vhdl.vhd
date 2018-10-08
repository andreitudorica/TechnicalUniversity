
library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity top is
end top;

architecture top of top is

	signal p : std_logic;

	component inst is
		generic (g : string);
		port ( p : std_logic);
	end component;

begin

	ii0 : inst generic map (g => "abc")
	port map (p => p);

end top;
