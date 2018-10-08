#
# rebuild whole project
#

quiet on		  
setactivelib -work
acom "$DSN\src\generator.asf"
acom "$DSN\src\testbench.vhd"

asim conf_testbench_arch
# initialize simulation
wave 
wave RESET
wave Y
wave A
wave B
wave S
wave CLOCK
run 10 us
endsim 
quiet off
#

