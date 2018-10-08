setactivelib -work
cd $DSN\src
buildc $dsn\src\external\read_byte_ex.dlm
alog  "$DSN\src\CD4029.v"
alog  "$DSN\src\ASCIIDEC.v"
alog  "$DSN\src\INTELHEX.v"
alog   "$DSN\src\DAT_CNT.v"
alog  "$DSN\src\COMP.v" 
alog  "$DSN\src\REG4.v"	  
alog  "$DSN\src\SUB.v"
alog  "$DSN\src\DATREG.v"
alog  "$DSN\src\ADRCNT.bde"
alog  "$DSN\src\LRC.bde" 
alog  "$DSN\src\DAC_SC1.bde"
alog  "$DSN\src\uut_std.v"
alog -pli "$DSN\src\external\read_byte_ex.dll" "$DSN\src\uut_pli.v"
asim -t ps -pli $dsn\src\external\read_byte_ex.dll  UUT_PLI  
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
run 25 ns
endsim