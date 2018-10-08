
adel -all

set TARGET systemc.dll

ccomp -sc $dsn/src/systemc2verilog/vector/systemc.cpp -o $TARGET

alog $dsn/src/systemc2verilog/vector/verilog.v
addsc $TARGET

# initialize simulation
asim top

run -all

# uncomment following line to terminate simulation automatically from script
#endsim
