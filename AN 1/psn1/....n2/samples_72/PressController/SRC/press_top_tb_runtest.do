acom "$DSN\src\automachine.asf" 
acom "$DSN\src\counters.vhd" 
acom "$DSN\src\press.bde" 
acom "$DSN\src\press_top.bde" 
acom "$DSN\src\Press_top_TB.vhd" 
asim -ieee_nowarn TESTBENCH_FOR_Press_top 
wave  
wave CLR
wave CLK
wave CLK_T
wave DET
wave STR
wave STP
wave RST
wave Y
wave OUTPUT
wave TIMER
wave LIMIT
run 7 ms
endsim