
package	my_pack is
	type my_type is (fetch,exe1,exe2);
end my_pack;


library IEEE;
use STD.TEXTIO.all;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_TEXTIO.all;
use work.my_pack.all;

entity inst is
	generic (
		p : my_type := fetch
		);
end inst;

architecture arch of inst is
begin

	process
		file results: TEXT open WRITE_MODE is "STD_OUTPUT";
		variable L_OUT : LINE;
	begin
		wait for 1ns;
		if(p = exe1) then
			write(L_OUT,"p = exe1 ");
		end if;
		writeline(RESULTS,L_OUT);
		wait;
	end process;

end arch;
