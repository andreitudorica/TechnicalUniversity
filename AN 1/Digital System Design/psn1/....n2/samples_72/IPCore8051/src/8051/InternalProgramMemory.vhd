--------------------------------------------------------------------------------------
-- Copyright (c) 1999 by Alatek. All rights reserved.
--
-- DESIGN        :   AL8051
-- FILE NAME     :   InternalProgramMemory.vhd
-- DESCRIPTION   :   Auxiliary
--
-- CREATED       :   01/01/1999
-- MODIFIED      :   
-- VERSION       :   1.0
-- AUTHOR        :   Anatoli Sergyienko, Volodymir Lepekha
-- HISTORY       :   
--------------------------------------------------------------------------------------

library IEEE;
use IEEE.std_logic_1164.all;	
use IEEE.STD_LOGIC_ARITH.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
use IEEE.STD_LOGIC_TEXTIO.all;	
library STD;
use STD.TEXTIO.all;

entity IPMemory  is


 port (
        i: in INTEGER range 0 to 65535;						 -- Address 
        PCBus: inout Bit_vector (7 downto 0);			 -- Instruction or Data Bus
        z: in BIT;        
        z1: in BIT																  --   when z1'edge then address is latched
    );

end IPMemory;

architecture  IPMemory of  IPMemory is

type BYTE2 is array (0 to 4095)  of  STD_LOGIC_VECTOR (7 downto 0);    
file hex: TEXT open READ_MODE is "hex.hex";							--Here the file name is put
 
signal h: INTEGER range 0 to 65;
signal iu: INTEGER range 0 to 65535;

begin

 process (z1)
 begin
 iu <= i;
 end process;	
 
 
 process (z)		--z is  IPMemory reading event
		 variable kk : INTEGER range 0 to 65535;
		 variable PROM : BYTE2;	 
			
			procedure lineoper (L: inout LINE; 
												address : inout STD_LOGIC_VECTOR(15 downto 0);
												table : inout  Byte2;
												EOF : out Boolean )
				is	
				variable value : STD_LOGIC_VECTOR (3 downto 0);		   
				variable value1 : character;
				variable ile	: integer range 16 downto 0;
				variable data : STD_LOGIC_VECTOR (7 downto 0);
			begin
				-- : -character
				read(L, value1);
				-- Count of data
				hread(L, value);
				if value = "0001" then		--full string
					ile := 16;
					hread(L, value);	  --nil
					-- address
					hread(L, value);
					address(15 downto 12) := value;
					hread(L, value);
					address(11 downto 8) := value;  
					hread(L, value);
					address(7 downto 4) := value;	 
					hread(L, value);
					address(3 downto 0) := value;
				else 
					hread(L, value);
					ile := conv_integer(value);
					-- address
					if ile/=0 then
						-- address
						hread(L, value);	 
						address(15 downto 12) := value;
						hread(L, value);	  
						address(11 downto 8) := value;
						hread(L, value);
						address(7 downto 4) := value;	 
						hread(L, value);
						address(3 downto 0) := value;
					else
						for J in 1 to 4 loop
							hread(L, value);
						end loop;
					end if;
				end if;				
				-- End of file
				hread(L, value);
				hread(L, value);		
				--the string head is read
				if value="0001" then
					EOF := True;
					return;
				end if;
				-- Write data to table.
				for K in 1 to ile loop
					hread(L, value); 
					data(7 downto 4) :=value;
					hread(L, value);  
					data(3 downto 0) :=value;
					table(conv_integer(address)) := data;
					address := address + '1';
				end loop;
			end;
			
				
			 variable L_IN  : LINE;
			variable address :STD_LOGIC_VECTOR( 15 downto 0);
			variable EOF : Boolean:=false;	   
			variable ii,add: integer range 0 to 65535;		   
			
	begin		
				 if EOF = false then	 
						write( output, "PROM initialization...." );
		        -- first initialize the RAM array with zeroes
		        for add in 0 to 4095 loop
			          Prom(add) := "00000000";
		        end loop; 
		
		        -- and now read the data file
		        while not eof loop 
					READLINE(hex, L_IN);
					lineoper(L_IN,address,prom,EOF);
				end loop; 					   				
		end if;		
		 
		 if ii < 4096 then
				 ii := iu;
				 PCBus <= to_bitvector(PROM(ii));
 		end if;
 end process;
end IPMemory;






