
adel -all

set TARGET systemc.dll

ccomp -sc $dsn/src/verilog2systemc/real/systemc.cpp -o $TARGET
addsc $TARGET

alog $dsn/src/verilog2systemc/real/verilog.v

# initialize simulation
asim top

run -all

# uncomment following line to terminate simulation automatically from script
#endsim

