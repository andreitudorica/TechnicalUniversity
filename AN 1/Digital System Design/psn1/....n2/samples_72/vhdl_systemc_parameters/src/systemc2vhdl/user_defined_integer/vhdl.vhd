
package	my_pack is
	subtype my_type is positive range 1 to 100;
end my_pack;


library IEEE;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use work.my_pack.all;

entity inst is
	generic (
		p : my_type := 1
		);
end inst;

architecture arch of inst is
begin

	process
		file results: TEXT open WRITE_MODE is "STD_OUTPUT";
		variable L_OUT : LINE;
	begin
		wait for 1ns;
		write(L_OUT,"p = ");
		write(L_OUT, p);
		writeline(RESULTS,L_OUT);
		wait;
	end process;

end arch;
