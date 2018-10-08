library ieee;	   
library work;
use ieee.std_logic_1164.all;
use work.all;


entity ps2_controller is
	port(
	serial:in std_logic;
	clk:in std_logic;
	ps2_clock:in std_logic;
	rst:in std_logic;
	seven_segment:out std_logic_vector(6 downto 0);
	anods: out std_logic_vector(3 downto 0));
end ps2_controller;

architecture keyboard of ps2_controller is
	component shift_register
		port (
		din:in std_logic; 
		clk:in std_logic; 
		rst:in std_logic;
		q:out std_logic_vector(7 downto 0));
	end component;
	
	component reg is
		port (
		clk:in std_logic; 
		rst:in std_logic; 
		d:in std_logic_vector(7 downto 0); 
		we:in std_logic;
		q:out std_logic_vector(7 downto 0));
	end component;
	
	component decoder is 
		port(
		data:in std_logic_vector(7 downto 0);
		clk:in std_logic;
		seven_segment:out std_logic_vector(6 downto 0);
		anods:out std_logic_vector(3 downto 0));
	end component;	   
	
	component D_FF
		port(
      clk:in std_logic;
      rst:in std_logic;
      d:in std_logic;
      q:out std_logic);
   end component;  
   
   component counter 
		port(
		clk:in std_logic; 
		tc:out std_logic);
end component; 

component debounce
	port(
    clk:in std_logic; 
	 rst:in std_logic;
    b:in std_logic; 
    r:out std_logic); 
end component;
	
	signal int_shift_mem : std_logic_vector(7 downto 0);
	signal int_mem_dec : std_logic_vector(7 downto 0);
	signal int_reset,rst_we : std_logic;	
	signal ps2_clock_sync:std_logic;
	signal serial_data:std_logic;
	signal ps2_clock_debounced:std_logic;
	signal serial_data_debounced:std_logic;
begin 			
	debounce_clock:debounce 			port map(clk,rst,ps2_clock_sync,ps2_clock_debounced);
	debounce_data:debounce 				port map(clk,rst,serial_data,serial_data_debounced);
	sync_clock:D_FF 						port map(clk,rst,ps2_clock,ps2_clock_sync);
	sync_data:D_FF 						port map(clk,rst,serial,serial_data);
	count_bits:counter 					port map(ps2_clock_debounced,rst_we);
	shift_reg:shift_register 			port map(serial_data_debounced,ps2_clock_debounced,rst,int_shift_mem);
	regist:reg 								port map(clk,rst,int_shift_mem,int_reset,int_mem_dec);
	delay_we:D_FF 							port map(clk, rst,rst_we,int_reset);	  	 
	decode:decoder 						port map(int_mem_dec,clk,seven_segment,anods);
end keyboard;