DESCRIPTION:
	Samples in this directory show how to pass generics from SystemC to VHDL and
	vice versa.  
	
	Generics for VHDL modules instantiated in SystemC are specified with two
	additional arguments for the foreign VHDL module constructor: the number 
	of generics and an array of const char* with name value pairs.  
	
	If a SystemC module is instantiated in VHDL, it can read generics from the
	generic map.  Generics (or parameters) need to be declared first inside the
	instantiated SystemC module.  Three functions are available for integer,
	real, and string generics: register_int_parameter, register_real_parameter,
	and register_string_parameter.  To read the value of a generic inside
	SystemC, use the sc_get_param function.  The function is overloaded to allow
	reading generics to integer, double and std::string values.

LANGUAGE:
	VHDL, SystemC

