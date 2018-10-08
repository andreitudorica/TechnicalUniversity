---------------------------------------------------------------------------------------------------
--
-- Title       : senzori
-- Design      : bariere_pb2_sub2
-- Author      : 
-- Company     : 
--
---------------------------------------------------------------------------------------------------
--
-- File        : cale_ferata.vhd
-- Generated   : Sat Jun  5 16:17:19 2010
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {senzori} architecture {arh_senzori}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity senzori is	  
	port (S1,S2,CLK:in std_logic;
	B:out std_logic);
end senzori;

--}} End of automatically maintained section

architecture arh_senzori of senzori is 
type state_type is (waiting, left, right, accident);
signal cs,ns:state_type;
begin
	CLC:process(S1,S2,cs)
	begin
		case cs is
			when waiting => B<='0';
				if S1='0' then
				if S2='0' then ns<=waiting;
				else ns<=right;
				end if;
				else
					if S2='1' then ns<=accident;
					else ns<=left;
					end if;
				end if;
			when right => B<='1';
				if S2='1' then ns<=right;
				elsif s1='1' then ns<=accident;
				else ns<=waiting;
				end if;	
			when left => B<='1';
				if S1='1' then ns<=left;
				elsif s2='1' then ns<=accident;
				else ns<=waiting;
				end if;
			when others => B<='1';
							ns<=accident;
			end case;
			end process CLC;
			
	SLC:process(CLK)
	begin		  
		assert cs/=accident report "Accident!!! Trains coming on the same railway!" severity WARNING;
		if CLK='1' and CLK'EVENT then 
			cs<=ns;
		end if;
	end process SLC;			

end arh_senzori;
