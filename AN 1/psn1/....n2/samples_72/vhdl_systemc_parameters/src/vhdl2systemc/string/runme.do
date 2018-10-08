
adel -all

set TARGET systemc.dll

ccomp -sc $dsn/src/vhdl2systemc/string/systemc.cpp -o $TARGET
addsc $TARGET

acom $dsn/src/vhdl2systemc/string/vhdl.vhd

# initialize simulation
asim top
#asim -Guut/p='m' top
run -all

# uncomment following line to terminate simulation automatically from script
#endsim
