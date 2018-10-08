acom "$DSN\src\Functional\AND2.vhd" 
acom "$DSN\src\Functional\CNT_4b.vhd" 
acom "$DSN\src\Functional\CONTROL.asf" 
acom "$DSN\src\Functional\hex2led.vhd" 
acom "$DSN\src\Functional\CNT_BCD.bde" 
acom "$DSN\src\Functional\top_frqm.bde" 
acom "$DSN\src\TestBench\top_frqm_TB.vhd" 
asim -advdataflow TESTBENCH_FOR_top_frqm 
wave 
wave -noreg F_INPUT
wave -noreg F_PATTERN
wave -noreg RESET
wave -noreg START	
wave -noreg UUT/GATE
wave -noreg UUT/END_RESET
wave -noreg UUT/BCD_B
wave -noreg UUT/BCD_A
wave -noreg LED_A
wave -noreg LED_B
wave -noreg LED_C
wave -noreg LED_D
run 8.000001 us
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# acom "$DSN\src\TestBench\top_frqm_TB_tim_cfg.vhd" 
# asim TIMING_FOR_top_frqm 
