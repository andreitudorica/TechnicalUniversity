-------------------------------------------------------------------------------
--
-- Title       : sum_compl_unbit
-- Design      : sum_compl_unbit
-- Author      : Ioana
-- Company     : UTCN
--
-------------------------------------------------------------------------------
--
-- File        : sum_compl_unbit.vhd
-- Generated   : Sat May  7 17:29:57 2011
-- From        : interface description file
-- By          : Itf2Vhdl ver. 1.20
--
-------------------------------------------------------------------------------
--
-- Description : 
--
-------------------------------------------------------------------------------

--{{ Section below this comment is automatically maintained
--   and may be overwritten
--{entity {sum_compl_unbit} architecture {sum_compl_unbit}}

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity sum_compl_unbit is  
	port(a,b,cin:in bit;
	    sum,cout:out bit);
end sum_compl_unbit;



architecture arhsum_compl_unbit of sum_compl_unbit is
signal s1,s2,s3,s4:bit;
begin
  P1:process(b,cin)
  begin
	  s1<=b xor cin;
  end process P1;
  
  P2:process(b,cin)
  begin
	  s2<=b and cin;
  end process P2;
	 
  
  P3:process(a,b)
  begin
	  s3<=a and b;
  end process P3;
  
  
  P4:process(a,cin)
  begin
	  s4<=a and cin;
  end process P4;
  
  P5:process(a,s1)
  begin
	  sum<=a xor s1;
  end process P5;
  
  P6:process(s2,s3,s4)
  begin
	  cout<=s2 or s3 or s4;
  end process P6;
  
end arhsum_compl_unbit;
                     