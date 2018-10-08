
adel -all

# compile project's source files
set TARGET systemc.dll

ccomp -sc $dsn/src/systemc2vhdl/user_defined_enumeration/systemc.cpp -o $TARGET

acom $dsn/src/systemc2vhdl/user_defined_enumeration/vhdl.vhd
addsc $TARGET

# initialize simulation
asim top

run -all

# uncomment following line to terminate simulation automatically from script
#endsim
