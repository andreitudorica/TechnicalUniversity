                             GENERATOR
                          ----------------
DESCRIPTION:
        
	This is a simple pulse generator. It generates a pulse
	when signal S changes 0 -> 1. Pulse width determines
	control inputs A, B:
	B A |   Y
	----------
	0 1 |  1 T
	1 0 |  2 T
	1 1 |  3 T
	0 0 |  4 T,      where T - clock period
          
	INPUTS:
	A, B  - pulse width:
	CLOCK - clock input
	RESET - resets the generator
	S     - start input
	
	OUTPUT:
	Y     - pulse output
	
FILES:
	The design contains the following files:

	GENERATOR.ASF is the FSM implementation of pulse generator.
	TESTBENCH.VHD - a testbench for GENERATOR.
	FUNCTIONAL.DO 	is a macro file for compilation and simulation.
	FUNCTIONAL.AWF is a waveform, saved after execution macro functional.do 

SIMULATION
	For functional simulation execute macro functional.do      
          
          

