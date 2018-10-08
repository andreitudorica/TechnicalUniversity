---------------------------------------------------------------------------------------------------
--
-- Title       : No Title
-- Design      : Bilete_tren
-- Author      : Vlad
-- Company     : utcn
--
---------------------------------------------------------------------------------------------------
--
-- File        : c:\My_Designs\Bilete_tren\Bilete_tren\compile\diagrama.vhd
-- Generated   : Sat Apr  6 12:41:16 2013
-- From        : c:\My_Designs\Bilete_tren\Bilete_tren\src\diagrama.bde
-- By          : Bde2Vhdl ver. 2.6
--
---------------------------------------------------------------------------------------------------
--
-- Description : 
--
---------------------------------------------------------------------------------------------------
-- Design unit header --
library IEEE;
use IEEE.std_logic_1164.all;


-- other libraries declarations
-- synopsys translate_off 
library VIRTEX2;
library IEEE;
use IEEE.vital_timing.all;
-- synopsys translate_on 

entity diagrama is
  port(
       Enter : in STD_LOGIC;
       IncarcareBilete : in STD_LOGIC;
       Input1 : in STD_LOGIC;
       RESET : in STD_LOGIC;
       BusInput0 : in STD_LOGIC_VECTOR(7 downto 0);
       CounterValue : in STD_LOGIC_VECTOR(7 downto 0);
       Dist : in STD_LOGIC_VECTOR(7 downto 0);
       Eliberare_bilet : out STD_LOGIC;
       Nr_bilete : out STD_LOGIC_VECTOR(7 downto 0);
       BusBidirectional0 : inout STD_LOGIC_VECTOR(7 downto 0)
  );
end diagrama;

architecture diagrama of diagrama is

---- Component declarations -----

component ADD8
  port (
       A : in STD_LOGIC_VECTOR(7 downto 0);
       B : in STD_LOGIC_VECTOR(7 downto 0);
       CI : in STD_LOGIC;
       CO : out STD_LOGIC;
       OFL : out STD_LOGIC;
       S : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;
component CC8CLED
  port (
       C : in STD_LOGIC;
       CE : in STD_LOGIC;
       CLR : in STD_LOGIC;
       D : in STD_LOGIC_VECTOR(7 downto 0);
       L : in STD_LOGIC;
       UP : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR(7 downto 0);
       TC : out STD_LOGIC;
       CEO : inout STD_LOGIC
  );
end component;
component COMP8
  port (
       A : in STD_LOGIC_VECTOR(7 downto 0);
       B : in STD_LOGIC_VECTOR(7 downto 0);
       EQ : out STD_LOGIC
  );
end component;
component SR8RLE
  port (
       C : in STD_LOGIC;
       CE : in STD_LOGIC;
       D : in STD_LOGIC_VECTOR(7 downto 0);
       L : in STD_LOGIC;
       R : in STD_LOGIC;
       SLI : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR(7 downto 0)
  );
end component;

----     Constants     -----
constant VCC_CONSTANT   : STD_LOGIC := '1';
constant GND_CONSTANT   : STD_LOGIC := '0';

---- Signal declarations used on the diagram ----

signal GND : STD_LOGIC;
signal VCC : STD_LOGIC;
signal BUS266 : STD_LOGIC_VECTOR (7 downto 0);
signal BUS460 : STD_LOGIC_VECTOR (7 downto 0);

---- Configuration specifications for declared components 

-- synopsys translate_off
for U1 : ADD8 use entity virtex2.ADD8;
-- synopsys translate_on
-- synopsys translate_off
for U2 : SR8RLE use entity virtex2.SR8RLE;
-- synopsys translate_on
-- synopsys translate_off
for U3 : SR8RLE use entity virtex2.SR8RLE;
-- synopsys translate_on
-- synopsys translate_off
for U4 : CC8CLED use entity virtex2.CC8CLED;
-- synopsys translate_on
-- synopsys translate_off
for U5 : COMP8 use entity virtex2.COMP8;
-- synopsys translate_on

begin

----  Component instantiations  ----

U1 : ADD8
  port map(
       A => BusBidirectional0,
       B => BusInput0,
       CI => GND,
       S => BUS266
  );

U2 : SR8RLE
  port map(
       C => Input1,
       CE => VCC,
       D => BUS266,
       L => VCC,
       Q => BusBidirectional0,
       R => RESET,
       SLI => GND
  );

U3 : SR8RLE
  port map(
       C => Enter,
       CE => VCC,
       D => Dist,
       L => VCC,
       Q => BUS460,
       R => RESET,
       SLI => VCC
  );

U4 : CC8CLED
  port map(
       C => Enter,
       CE => VCC,
       CLR => RESET,
       D => CounterValue,
       L => IncarcareBilete,
       Q => Nr_bilete,
       UP => GND
  );

U5 : COMP8
  port map(
       A => BusBidirectional0,
       B => BUS460,
       EQ => Eliberare_bilet
  );


---- Power , ground assignment ----

VCC <= VCC_CONSTANT;
GND <= GND_CONSTANT;

end diagrama;
