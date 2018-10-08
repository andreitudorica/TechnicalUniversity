adel -all
cd $dsn\src
buildc testwrapper.dlm	
addfile testwrapper.dll
addsc testwrapper.dll

alog -v2k -dbg "$DSN/src/verilog/clk_gen.v"
alog -v2k -dbg "$DSN/src/verilog/rcv_reg.v"
alog -v2k -dbg "$DSN/src/verilog/synchronizer.v"
alog -v2k -dbg "$DSN/src/verilog/latched_val.v"
alog -v2k -dbg "$DSN/src/verilog/rcv.bde"
alog -v2k -dbg "$DSN/src/verilog/test_env.bde"

asim test_env

wave *

run 6 us

endsim