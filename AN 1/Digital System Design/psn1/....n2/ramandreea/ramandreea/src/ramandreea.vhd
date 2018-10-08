

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity RAM is					
	port(A_RAM:in BIT_VECTOR(3 DOWNTO 0);
	CS_RAM:IN BIT;
	WE:IN BIT;
	D_RAM:OUT BIT_VECTOR(15 DOWNTO 0));
end RAM;



architecture architecture_RAM of RAM is
type MEMRAM IS ARRAY(0 TO 15) OF BIT_VECTOR(15 DOWNTO 0);	 

BEGIN
	PROCESS(CS_RAM,A_RAM,WE)
	VARIABLE 	MEM:MEMRAM;
    begin	
		IF WE='1' THEN
			MEM(0):="0000000000000000";
			MEM(1):="0000000100000000";
			MEM(2):="0000001000000000";
			MEM(3):="0000001100000000";
			MEM(4):="0000010000000000";
			MEM(5):="0000010100000000";
			MEM(6):="0000011000000000";
			MEM(7):="0000011100000000";
			MEM(8):="0000100000000000";
			MEM(9):="0000100100000000";
			MEM(10):="0000100100000000";
			MEM(11):="0000101000000000";
			MEM(12):="0000101100000000";
			MEM(13):="0000110000000000"; 
			MEM(14):="0000110100000000";
			MEM(15):="0000111000000000";  
		ELSE
	IF CS_RAM='1' THEN
	case A_RAM is
		when "0000" => D_RAM<=MEM(0);  
		when "0001" => D_RAM<=MEM(1);  
		when "0010" => D_RAM<=MEM(2);  
		when "0011" => D_RAM<=MEM(3);  
		when "0100" => D_RAM<=MEM(4);
		when "0101" => D_RAM<=MEM(5);
		when "0110" => D_RAM<=MEM(6);
		when "0111" => D_RAM<=MEM(7);
		when "1000" => D_RAM<=MEM(8);
		when "1001" => D_RAM<=MEM(9);
		when "1010" => D_RAM<=MEM(10);
		when "1011" => D_RAM<=MEM(11);
		when "1100" => D_RAM<=MEM(12);
		when "1101" => D_RAM<=MEM(13);
		when "1110" => D_RAM<=MEM(14);
		when "1111" => D_RAM<=MEM(15);
    end case;
	END IF;		
	END IF;
	END PROCESS;	
end architecture_RAM;
