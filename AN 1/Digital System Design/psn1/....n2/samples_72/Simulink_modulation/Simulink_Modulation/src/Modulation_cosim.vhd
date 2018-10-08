entity Link is
end entity Link;

architecture Impl of Link is
attribute foreign of Impl : architecture is
"VHPI $aldec\simulink\aldec_simulink_pipe; vhpi_link";
begin
end architecture Impl;

library Demodulator;
library ieee;

use ieee.std_logic_arith.all;
use ieee.std_logic_1164.all;
use Demodulator.maths_class.all;

entity Modulation_cosim is
end Modulation_cosim;

architecture COSIMULATION of Modulation_cosim is

component Link
end component;


component mult
	port (
	Sin_wav1 : in std_logic_vector(15 downto 0);
	Sin_wav2 : in std_logic_vector(15 downto 0);
	Out1 : out std_logic_vector(30 downto 0));
end component;


component top_demodulator
	port (
	clk : in std_ulogic;
	reset : in std_ulogic;
	In1 : in std_logic_vector(30 downto 0);
	carrier : out std_ulogic_vector(20 downto 0);
	envelope : out std_ulogic_vector(20 downto 0));
end component;


for \Modulation_cosim/Modulator\ : mult use entity Demodulator.mult(beh);
for \Modulation_cosim/Demodulator\ : top_demodulator use entity Demodulator.top_demodulator(top_demodulator);
signal CLK_2 : std_logic;

--Signals declaration for module Modulation_cosim/Modulator(beh)
signal \Modulation_cosim/Modulator/Sin_wav1\ : std_logic_vector(15 downto 0);
signal \Modulation_cosim/Modulator/Sin_wav2\ : std_logic_vector(15 downto 0);
signal \Modulation_cosim/Modulator/Out1\ : std_logic_vector(30 downto 0);

--Signals declaration for module Modulation_cosim/Demodulator(top_demodulator)
signal \Modulation_cosim/Demodulator/reset\ : std_ulogic;
signal \Modulation_cosim/Demodulator/In1\ : std_logic_vector(30 downto 0);
signal \Modulation_cosim/Demodulator/envelope\ : std_ulogic_vector(20 downto 0);
signal \Modulation_cosim/Demodulator/carrier\ : std_ulogic_vector(20 downto 0);

begin

sim_link: Link;


	\Modulation_cosim/Modulator\ : mult
	port map(
	Sin_wav1 => \Modulation_cosim/Modulator/Sin_wav1\,
	Sin_wav2 => \Modulation_cosim/Modulator/Sin_wav2\,
	Out1 => \Modulation_cosim/Modulator/Out1\);

	\Modulation_cosim/Demodulator\ : top_demodulator
	port map(
	clk => CLK_2,
	reset => \Modulation_cosim/Demodulator/reset\,
	In1 => \Modulation_cosim/Demodulator/In1\,
	envelope => \Modulation_cosim/Demodulator/envelope\,
	carrier => \Modulation_cosim/Demodulator/carrier\);

--Clock signal generator CLK_2
CLOCK_GEN_CLK_2: process
	begin
	loop
		CLK_2 <= '0';
		wait for 25 ms;
		CLK_2 <= '1';
		wait for 25 ms;
	end loop;
end process;


end COSIMULATION;

