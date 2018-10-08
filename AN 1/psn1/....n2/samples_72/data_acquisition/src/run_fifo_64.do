asim -Gfifo_depth=64 test_environment

wave reset
wave rd_clk
wave wr_clk
wave wr_data
wave full
wave empty

run -all
endsim
