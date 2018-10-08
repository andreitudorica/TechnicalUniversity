entity Barrel_Shifter is
	port(Q: inout bit_vector(7 downto 0):="10101101"; dir,CLK: in bit);
end Barrel_Shifter;

architecture arh_Barrel_Shifter of Barrel_Shifter is
begin
	process(dir,CLK)
	variable k: natural :=0;
	begin													 
	if(dir'event) then k:=0;end if;						 
		if(CLK='1' and CLK'EVENT) then
			if (dir='1' and k<3) then 
				Q<=Q sll 1;
				Q(7)<='0';
				k:=k+1;
			end if;
		
			if (dir='0' and k<3) then 
				Q<=Q srl 1;
				Q(0)<='0';
				k:=k+1;
			end if;
		end if;
	end process;
end arh_Barrel_Shifter;
