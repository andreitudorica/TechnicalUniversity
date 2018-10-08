acom "$DSN\src\Devices\pr_sr_register.vhd" 
acom "$DSN\src\Devices\TestBench\pr_sr_register_TB.vhd" 
asim -advdataflow TESTBENCH_FOR_pr_sr_register 
wave  
wave nWRS
wave TXC
wave RESET
wave DATAS
wave INT
wave BUSY
wave TXD
run 2.7 us
# The following lines can be used for timing simulation
# acom <backannotated_vhdl_file_name>
# acom "$DSN\src\TestBench\pr_sr_register_TB_tim_cfg.vhd" 
# asim TIMING_FOR_pr_sr_register 
