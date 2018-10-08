setactivelib -work
vlcomp  "$DSN\src\CD4029.v"
vlcomp  "$DSN\src\ASCIIDEC.v"
vlcomp  "$DSN\src\INTELHEX.v"
vlcomp  "$DSN\src\DAT_CNT.v"
vlcomp  "$DSN\src\COMP.v" 
vlcomp  "$DSN\src\REG4.v"	  
vlcomp  "$DSN\src\SUB.v"
vlcomp  "$DSN\src\DATREG.v"
vlcomp  "$DSN\src\ADRCNT.bde"
vlcomp  "$DSN\src\LRC.bde" 
vlcomp  "$DSN\src\DAC_SC1.bde"
vlcomp  "$DSN\src\uut_std.v"
asim -t ps UUT_STD	 
wave
wave AB
wave CLK
wave CLR
wave DB
wave DI
wave EN
wave ERR
wave f
wave f1
wave stc
wave WR
run -all
endsim