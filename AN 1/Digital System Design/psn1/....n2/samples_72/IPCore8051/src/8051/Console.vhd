--------------------------------------------------------------------------------------
-- Copyright (c) 1999 by Alatek. All rights reserved.
--
-- DESIGN        :   AL8051
-- FILE NAME     :   console.vhd
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
library work;
use work.registers.all;


entity console is
    port (
        QQ: in RAMemo;
        BYTE1: in bit_vector (7 downto 0);
        com: in bit_vector (7 downto 0);
        r_tcon: in bit_vector (7 downto 0);
        r_scon: in bit_vector (7 downto 0);
        r_th0: in bit_vector (7 downto 0);
        r_tl0: in bit_vector (7 downto 0);
        r_th1: in bit_vector (7 downto 0);
        r_tl1: in bit_vector (7 downto 0);
        r_bp0: in bit_vector (7 downto 0);
        r_bp1: in bit_vector (7 downto 0);
        r_bp2: in bit_vector (7 downto 0);
        r_bp3: in bit_vector (7 downto 0);
        y : in integer
    );
end console;

architecture console of console is
signal pc :integer;
signal BYTE: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal INSTRUCTION: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal ACC: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal TCON: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal B: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal PSW: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal PCON: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal IE: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal IP: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal TH0: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal TL0: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal TH1: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal TL1: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal SP: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal TMOD: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal DPH: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal DPL: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal SCON: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal SBUF: STD_LOGIC_VECTOR(7 DOWNTO 0);
signal P0: STD_LOGIC_VECTOR(7 DOWNTO 0);  --Port latch P0
signal P1: STD_LOGIC_VECTOR(7 DOWNTO 0);  --Port latch P1
signal P2: STD_LOGIC_VECTOR(7 DOWNTO 0);  --Port latch P2
signal P3: STD_LOGIC_VECTOR(7 DOWNTO 0);  --Port latch P3	

begin
 BYTE <= TO_STDLOGICVECTOR(BYTE1);
 INSTRUCTION <= TO_STDLOGICVECTOR(com);
 pc <= y;
 ACC <= TO_STDLOGICVECTOR(QQ(224));
 B <= TO_STDLOGICVECTOR(QQ(240));
 TCON <= TO_STDLOGICVECTOR(r_tcon);
 PSW <= TO_STDLOGICVECTOR(QQ(208));
 PCON <= TO_STDLOGICVECTOR(QQ(135));
 IE <= TO_STDLOGICVECTOR(QQ(168));
 IP <= TO_STDLOGICVECTOR(QQ(184));
 TH0 <= TO_STDLOGICVECTOR(r_th0);
 TL0 <= TO_STDLOGICVECTOR(r_tl0);
 TH1 <= TO_STDLOGICVECTOR(r_th1);
 TL1 <= TO_STDLOGICVECTOR(r_tl1);
 SP <= TO_STDLOGICVECTOR(QQ(129));
 TMOD <= TO_STDLOGICVECTOR(QQ(137));
 DPH <= TO_STDLOGICVECTOR(QQ(131));
 DPL <= TO_STDLOGICVECTOR(QQ(130));
 SCON <= TO_STDLOGICVECTOR(r_scon);
 SBUF <= TO_STDLOGICVECTOR(QQ(153));
 P0 <= TO_STDLOGICVECTOR(r_bp0);
 P1 <= TO_STDLOGICVECTOR(r_bp1);
 P2 <= TO_STDLOGICVECTOR(r_bp2);
 P3 <= TO_STDLOGICVECTOR(r_bp3);
 
end console;
