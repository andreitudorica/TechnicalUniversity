adel -all
cd $dsn\src
buildc testwrapper.dlm	
addfile testwrapper.dll
addsc testwrapper.dll

acom -dbg "$DSN/src/vhdl/clk_gen.vhd"
acom -dbg "$DSN/src/vhdl/rcv_reg.vhd"
acom -dbg "$DSN/src/vhdl/synchronizer.vhd"
acom -dbg "$DSN/src/vhdl/latched_val.vhd"
acom -dbg "$DSN/src/vhdl/rcv.bde"
acom -dbg "$DSN/src/vhdl/test_env.bde"

asim test_env

wave *

run 6 us

endsim