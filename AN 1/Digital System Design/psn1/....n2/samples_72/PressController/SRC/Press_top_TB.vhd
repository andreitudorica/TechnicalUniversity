---------------------------------------------------------------------------------------------------
--
-- Title       : Test Bench for press_top
-- Design      : PressController
-- Author      : marcink
-- Company     : Aldec
--
---------------------------------------------------------------------------------------------------
--
-- File        : $DSN\src\TestBench\press_top_TB.vhd
-- Generated   : 6/6/2005, 3:16 PM
-- From        : $DSN\compile\press_top.vhd
-- By          : Active-HDL Built-in Test Bench Generator ver. 1.2s
--
---------------------------------------------------------------------------------------------------
--
-- Description : Automatically generated Test Bench for press_top_tb
--
---------------------------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_textio.all;
use std.textio.all;

	-- Add your library and packages declaration here ...

entity press_top_tb is
end press_top_tb;

architecture TB_ARCHITECTURE of press_top_tb is
	-- Component declaration of the tested unit
	component press_top
	port(
		CLK : in std_logic;
		CLK_T : in std_logic;
		DET : in std_logic;
		RST : in std_logic;
		STP : in std_logic;
		STR : in std_logic;
		clr : in std_logic;
		OUTPUT : out std_logic;
		LIMIT : out std_logic_vector(5 downto 0);
		TIMER : out std_logic_vector(9 downto 0);
		Y : out std_logic_vector(2 downto 0) );
	end component;

	-- Stimulus signals - signals mapped to the input and inout ports of tested entity
	signal CLK : std_logic;
	signal CLK_T : std_logic;
	signal DET : std_logic;
	signal RST : std_logic;
	signal STP : std_logic;
	signal STR : std_logic;
	signal clr : std_logic;
	-- Observed signals - signals mapped to the output ports of tested entity
	signal OUTPUT : std_logic;
	signal LIMIT : std_logic_vector(5 downto 0);
	signal TIMER : std_logic_vector(9 downto 0);
	signal Y : std_logic_vector(2 downto 0);

	--Signal is used to stop clock signal generators
	signal END_SIM: BOOLEAN:=FALSE;
	--  write result file declaration inside architecture
	file RESULTS: TEXT open WRITE_MODE is "behav.txt";

	procedure WRITE_RESULTS(
						   CLK :  std_logic;
						   CLK_T :  std_logic;
						   DET :  std_logic;
						   RST :  std_logic;
						   STP :  std_logic;
						   STR :  std_logic;
						   clr :  std_logic;
						   OUTPUT :  std_logic;
						   LIMIT :  std_logic_vector(5 downto 0);
						   TIMER :  std_logic_vector(9 downto 0);
						   Y :  std_logic_vector(2 downto 0)
						   ) is 
			  variable L_OUT : LINE;
		begin
				write(l_out, now, right, 15, ps);
				write(l_out, CLK, right, 2);
				write(l_out, CLK_T, right, 2);
				write(l_out, DET, right, 2);
				write(l_out, RST, right, 2);
				write(l_out, STP, right, 2);
				write(l_out, STR, right, 2);
				write(l_out, clr, right, 2);
				write(l_out, OUTPUT, right, 2);
				write(l_out, LIMIT, right, 7);
				write(l_out, TIMER, right, 11);
				write(l_out, Y, right, 4);
				writeline(results, l_out);
		end;

	-- Add your code here ...

begin

	-- Unit Under Test port map
	UUT : press_top
		port map (
			CLK => CLK,
			CLK_T => CLK_T,
			DET => DET,
			RST => RST,
			STP => STP,
			STR => STR,
			clr => clr,
			OUTPUT => OUTPUT,
			LIMIT => LIMIT,
			TIMER => TIMER,
			Y => Y
		);

	--Below VHDL code is an inserted .\compile\presscontroller_top.vhs
	--User can modify it ....

STIMULUS: process
begin  -- of stimulus process
--wait for <time to next event>; -- <current time>

	STP <= '1';
	RST <= '1';
	STR <= '1';
	clr <= '0';
	DET <= '0';
    wait for 10 us; --0 fs
	clr <= '1';
    wait for 210 us; --10 us
	STP <= '0';
    wait for 50 us; --220 us
	STP <= '1';
    wait for 258124992 ps; --270 us
	RST <= '0';
    wait for 39775104 ps; --528124992 ps
	RST <= '1';
    wait for 362099904 ps; --567900096 ps
	STP <= '0';
    wait for 40 us; --930 us
	STP <= '1';
    wait for 260 us; --970 us
	STR <= '0';
    wait for 40 us; --1230 us
	STR <= '1';
    wait for 260 us; --1270 us
	STR <= '0';
    wait for 40 us; --1530 us
	STR <= '1';
    wait for 260 us; --1570 us
	STR <= '0';
    wait for 40 us; --1830 us
	STR <= '1';
    wait for 20 us; --1870 us
	DET <= '1';
    wait for 140 us; --1890 us
	DET <= '0';
    wait for 90 us; --2030 us
	RST <= '0';
    wait for 49969590 ps; --2120 us
	RST <= '1';
    wait for 260030410 ps; --2169969 ns
	STR <= '0';
    wait for 40 us; --2430 us
	STR <= '1';
    wait for 40 us; --2470 us
	DET <= '1';
    wait for 110 us; --2510 us
	DET <= '0';
    wait for 90 us; --2620 us
	DET <= '1';
    wait for 110 us; --2710 us
	DET <= '0';
    wait for 90 us; --2820 us
	DET <= '1';
    wait for 110 us; --2910 us
	DET <= '0';
    wait for 210 us; --3020 us
	RST <= '0';
    wait for 50 us; --3230 us
	RST <= '1';
    wait for 100 us; --3280 us
	RST <= '0';
    wait for 40 us; --3380 us
	STP <= '0';
    wait for 60 us; --3420 us
	RST <= '1';
    wait for 40 us; --3480 us
	STP <= '1';
    wait for 210 us; --3520 us
	STR <= '0';
    wait for 39267875 ps; --3730 us
	STR <= '1';
    wait for 40732125 ps; --3769267 ns
	DET <= '1';
    wait for 150 us; --3810 us
	DET <= '0';
    wait for 50 us; --3960 us
	DET <= '1';
    wait for 150 us; --4010 us
	DET <= '0';
    wait for 50 us; --4160 us
	DET <= '1';
    wait for 10 us; --4210 us
	STP <= '0';
    wait for 109553896 ps; --4220 us
	STP <= '1';
    wait for 30446104 ps; --4329553 ns
	DET <= '0';
    wait for 170846795 ps; --4360 us
	STR <= '0';
    wait for 39267875 ps; --4530846 ns
	STR <= '1';
    wait for 40732125 ps; --4570114 ns
	DET <= '1';
    wait for 149153205 ps; --4610846 ns
	DET <= '0';
    wait for 50846795 ps; --4760 us
	DET <= '1';
    wait for 149153205 ps; --4810846 ns
	DET <= '0';
    wait for 50846795 ps; --4960 us
	DET <= '1';
    wait for 149153205 ps; --5010846 ns
	DET <= '0';
    wait for 270 us; --5160 us
	STR <= '0';
    wait for 40 us; --5430 us
	STR <= '1';
    wait for 40 us; --5470 us
	DET <= '1';
    wait for 150 us; --5510 us
	DET <= '0';
    wait for 50 us; --5660 us
	DET <= '1';
    wait for 150 us; --5710 us
	DET <= '0';
    wait for 50 us; --5860 us
	DET <= '1';
    wait for 150 us; --5910 us
	DET <= '0';
    wait for 70 us; --6060 us
	RST <= '0';
    wait for 40 us; --6130 us
	RST <= '1';
    wait for 310 us; --6170 us
	RST <= '0';
    wait for 50 us; --6480 us
	STR <= '0';
    wait for 140 us; --6530 us
	STR <= '1';
    wait for 10 us; --6670 us
	RST <= '1';
    wait for 320 us; --6680 us
	END_SIM <= TRUE;
--	end of stimulus events
	wait;
end process; -- end of stimulus process
	
CLOCK_CLK : process
begin
	--this process was generated based on formula: 0 0 us, 1 50 us -r 100 us
	--wait for <time to next event>; -- <current time>
	if END_SIM = FALSE then
		CLK <= '0';
		wait for 50 us; --0 fs
	else
		wait;
	end if;
	if END_SIM = FALSE then
		CLK <= '1';
		wait for 50 us; --50 us
	else
		wait;
	end if;
end process;

CLOCK_CLK_T : process
begin
	--this process was generated based on formula: 0 0 us, 1 500 ns -r 1 us
	--wait for <time to next event>; -- <current time>
	if END_SIM = FALSE then
		CLK_T <= '0';
		wait for 500 ns; --0 fs
	else
		wait;
	end if;
	if END_SIM = FALSE then
		CLK_T <= '1';
		wait for 500 ns; --500 ns
	else
		wait;
	end if;
end process;




	WRITE_TO_FILE:	WRITE_RESULTS(
			CLK,
			CLK_T,
			DET,
			RST,
			STP,
			STR,
			clr,
			OUTPUT,
			LIMIT,
			TIMER,
			Y );
	-- Add your stimulus here ...

end TB_ARCHITECTURE;

configuration TESTBENCH_FOR_press_top of press_top_tb is
	for TB_ARCHITECTURE
		for UUT : press_top
			use entity work.press_top(schematic);
		end for;
	end for;
end TESTBENCH_FOR_press_top;

