DESCRIPTION:
	Samples in this directory show how to pass parameters from SystemC to
	Verilog and vice versa.  
	
	Parameters for Verilog modules instantiated in SystemC are specified with
	two additional arguments for the foreign Verilog module constructor: the
	number of parameters and an array of const char* with name value pairs.  
	
	If a SystemC module is instantiated in Verilog, it can read parameters from
	the module instantiation statement.  Parameters need to be declared first
	inside SystemC. Three functions are available for integer, real, and string
	parameters: register_int_parameter, register_real_parameter, and
	register_string_parameter.  To read the value of a parameter inside SystemC,
	use the sc_get_param function.  The function is overloaded to allow reading
	parameters to integer, double and std::string values.

LANGUAGE:
	Verilog, SystemC
