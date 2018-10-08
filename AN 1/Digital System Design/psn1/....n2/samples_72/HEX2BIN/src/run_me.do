setactivelib -work
vlcomp "$DSN\src\asciidec.v"
vlcomp "$DSN\src\reg.v"
vlcomp "$DSN\src\lrc.v"
vlcomp "$DSN\src\dat_cnt.v"
vlcomp "$DSN\src\adrcnt.v"
vlcomp "$DSN\src\ihx_fsm.v"
vlcomp "$DSN\src\h2b.v"
vlcomp "$DSN\src\uut.v"
asim UUT   
wave
wave AB
wave CLK
wave CLR
wave DB
wave DI
wave EN
wave ERR
wave f
wave s
wave stc
wave WR
run -all
endsim