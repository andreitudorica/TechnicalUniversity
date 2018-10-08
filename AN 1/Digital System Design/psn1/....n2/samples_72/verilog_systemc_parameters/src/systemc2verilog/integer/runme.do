
adel -all

set TARGET systemc.dll

ccomp -sc $dsn/src/systemc2verilog/integer/systemc.cpp -o $TARGET
addsc $TARGET

alog $dsn/src/systemc2verilog/integer/verilog.v

# initialize simulation
asim top

run -all

# uncomment following line to terminate simulation automatically from script
#endsim
