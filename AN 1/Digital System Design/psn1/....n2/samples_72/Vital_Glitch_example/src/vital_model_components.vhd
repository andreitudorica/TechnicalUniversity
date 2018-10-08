library IEEE;
use IEEE.STD_LOGIC_1164.all;

use IEEE.VITAL_Timing.all;

package VCOMPONENTS is

CONSTANT DefaultTimingChecksOn : Boolean := True;
CONSTANT DefaultXGenerationOn : Boolean := False;
CONSTANT DefPropDelay01      : VitalDelayType01      := (0 ns, 0 ns);
CONSTANT DefGlitchMsgOn      : BOOLEAN       := TRUE;
CONSTANT DefGlitchXOn	: BOOLEAN	:= FALSE;	  

component AND3
   generic(
      TimingChecksOn: Boolean := DefaultTimingChecksOn;
      XGenerationOn: Boolean := DefaultXGenerationOn;
      InstancePath: STRING := "*";
      XOn: Boolean := DefGlitchXOn;
      MsgOn: Boolean := DefGlitchMsgOn;
      tpd_IN1_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN2_Y                      :	VitalDelayType01 := DefPropDelay01;
      tpd_IN3_Y                      :	VitalDelayType01 := DefPropDelay01;
      tipd_IN1                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN2                       :	VitalDelayType01 := DefPropDelay01;
      tipd_IN3                       :	VitalDelayType01 := DefPropDelay01);

   port(
      Y                              :	out   STD_LOGIC;
      IN1                            :	in    STD_LOGIC;
      IN2                            :	in    STD_LOGIC;
      IN3                            :	in    STD_LOGIC);
end component;
end VCOMPONENTS;
