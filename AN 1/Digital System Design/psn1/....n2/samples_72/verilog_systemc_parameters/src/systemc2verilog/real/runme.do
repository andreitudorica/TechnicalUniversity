
adel -all

set TARGET systemc.dll

ccomp -sc $dsn/src/systemc2verilog/real/systemc.cpp -o $TARGET
addsc $TARGET

alog $dsn/src/systemc2verilog/real/verilog.v

# initialize simulation
asim top

run -all

# uncomment following line to terminate simulation automatically from script
#endsim
