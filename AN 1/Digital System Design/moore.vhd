library	ieee;
use ieee.std_logic_1164.all;


entity MOORE is
	port(I: in bit_vector(2 downto 0);
	CLK, RST: in bit;
	Z: out bit_vector(3 downto 1));
end MOORE;

architecture A of MOORE is
type state_type is (Standby, Run, Suspend, Resume, Wait1);
signal curr_state, next_state: state_type;

begin	   
CLC: process(I, curr_state)
     begin
	 case curr_state is
		when Standby => Z(1) <= '1'; 
						Z(2) <= '1';
					    Z(3) <= '0';  
						if I(0) = '0' then
							next_state <= Standby;
						else
							next_state <= Run;
						end if;
		when Run	 => Z(2) <= '1'; 
						Z(3) <= '1';
					    Z(1) <= '0';  
						if I(1) = '0' then
							next_state <= Run;
						else
							next_state <= Suspend;
						end if;					 
		when Suspend => Z(1) <= '1'; 
						Z(2) <= '0';
					    Z(3) <= '0';  
						next_state <= Resume;					
		when Resume	 => Z(1) <= '0'; 
						Z(2) <= '0';
					    Z(3) <= '0';  
						if I(1) = '0' then
							next_state <= Wait1;
						else
							next_state <= Run;
						end if;				
		when Wait1	 => Z(1) <= '1'; 
						Z(2) <= '1';
					    Z(3) <= '0';  
						if I(2) = '0' then
							next_state <= Wait1;
						else
							next_state <= Standby;
						end if;	
		end case;		
	end process CLC;
	
SLC: process(CLK, RST)
	begin				
	if RST = '1' then  
		curr_state <= Standby;
	else
		if CLK'EVENT and CLK = '1' then
			curr_state <= next_state;
		end if;
	end if;
	end process SLC;
end A;
