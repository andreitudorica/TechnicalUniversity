DESCRIPTION:
        This circuit converts data supplied in the Intel HEX format and writes it into
        a 64kB memory. The data is supplied byte by byte on the DI input. The arrival
        of each byte is synchronized by the active (high) value of EN. It is required
        that EN	remains high for no longer than one clock period and remains low for
        at least one clock period. The circuit generates all the signals required
        for writing to the memory. The LRC check is performed for each record cycle.
        If the calculated LRC is not equal to the LRC read from data downloaded data, 
		the ERR output turns HIGH until the next LRC check.
	
        Top level of the project is created with use of BDE (Block Diagram Editor)
	
	
	
CONTROLS (Inputs):
	CLK	- external clock input,
	CLR	- initializes  FSM control
	DI	- 8 bit ASCII character input
	EN	- Valid data on DI (Should stay '1' no longer then one CLK period)
OUTPUTS:
	AB	- Memory address bus
	DB	- Memory data bus
	WR	- Memory write
	ERR	- LRC Error


SIMULATION:
        Design simulation can be done by execution run_me_std.do file it assumes
		using standard verilog project from uut_std.v file with the following test vector
		record 
		:0200FF003C00C3	
		:00000001FF
		
		Other possibility of design simulation is execution of run_me_pli.do file that
		executes PLI version of project stored in uut_pli.v. 
		Before runing this version make sure that Design\Setings... Verilog PLI tab 
		contains PLITols.dll file enabled and file exist on the disk and the path is correct
		
		Results for both version can be observed in hex2bin.txt and mem_wr.dat files
		User can define its own hex file and check simulation results	


 


