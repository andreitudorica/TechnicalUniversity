library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_textio.all;
use IEEE.std_logic_arith.CONV_STD_LOGIC_VECTOR;
use IEEE.std_logic_unsigned.CONV_INTEGER;
use STD.textio.all;

entity hex_ram_tb is
	generic(filename : string := "results_vhd.txt");
end entity;

architecture ahex_ram_tb of hex_ram_tb is

	function char_to_slv(arg : character) return std_logic_vector is
	begin
		return CONV_STD_LOGIC_VECTOR(character'POS(arg), 8);
	end function;

	function slv_to_char(arg : std_logic_vector) return character is
	begin
		return character'VAL(CONV_INTEGER(arg));
	end function;

	procedure gen_clk(signal clk : inout std_logic; cycle : integer; period : time) is
	begin
		for i in 1 to cycle loop
			wait for period;
			clk <= not clk;
			wait for period;
			clk <= not clk;
		end loop;
	end procedure;
	
	procedure mon(file results : text; CLK,CLR,EN,C0,DUMP_RAM : std_logic; CHR : character; WR,ERR : std_logic; ADDR,DATA : std_logic_vector) is
		variable ln : line;
	begin
		write(ln, now, right, 10);
		write(ln, CLK, right, 3);
		write(ln, CLR, right, 3);
		write(ln, EN, right, 3);
		write(ln, C0, right, 3);
		write(ln, DUMP_RAM, right, 3);
		write(ln, CHR, right, 3);
		write(ln, WR, right, 3);
		write(ln, ERR, right, 3);
		write(ln, ADDR, right, 20);
		write(ln, DATA, right, 10);
		writeline(results, ln);
	end procedure;
	
	component hex_ram is
		port(CLK,CLR,EN,C0,DUMP_RAM : in std_logic;
			CHR : in std_logic_vector(7 downto 0);
			WR,ERR : out std_logic;
			ADDR : out std_logic_vector(15 downto 0);
			DATA : out std_logic_vector(7 downto 0)
			);
	end component;

	file stimulus : text;
	file results_f : text open write_mode is filename;

	signal CLK,CLR,EN,C0,DUMP_RAM : std_logic;
	signal CHR : std_logic_vector(7 downto 0);
	signal CHR_int : character;
	signal WR,ERR : std_logic;
	signal ADDR : std_logic_vector(15 downto 0);
	signal DATA : std_logic_vector(7 downto 0);
	
begin
	
sc_u : hex_ram port map (CLK => CLK,
	CLR => CLR,
	EN => EN,
	C0 => C0,
	DUMP_RAM => DUMP_RAM,
	CHR => CHR,
	WR => WR,
	ERR => ERR,
	ADDR => ADDR,
	DATA => DATA
	);

	CHR <= char_to_slv(CHR_int);
	
	process
		variable ln : line;
		variable read_char : character;
		variable isFileOK : file_open_status;
	begin
		
		FILE_OPEN (isFileOK, results_f, filename, WRITE_MODE);		
		if(isFileOK /= open_ok) then
			ASSERT false REPORT "Fatal ERROR: results file could not be opened!" SEVERITY error;
			wait;
		end if;

		FILE_OPEN (isFileOK, stimulus, "$dsn\src\dcfa1.hex", READ_MODE);		
		if(isFileOK /= open_ok) then
			ASSERT false REPORT "Fatal ERROR: Input file not found!" SEVERITY error;
			wait;			
		end if;
		
		DUMP_RAM <= '0';
		C0 <= '0';
		CLK <= '0';
		CLR <= '1';
		EN <= '0';
		CHR_int <= 'G';
		write(ln, string'("Conversion started..."));
		writeline(output, ln);
		wait for 10 ns;
		gen_clk(CLK, 5, 10 ns);
		CLR <= '0';
		gen_clk(CLK, 20, 10 ns);
		
		while not ENDFILE(stimulus) loop
			READLINE(stimulus, ln);
			while ln'length > 0 loop
				READ(ln, read_char);
				gen_clk(CLK, 2, 10 ns);
				CHR_int <= read_char;
				EN <= '1';
				gen_clk(CLK, 1, 10 ns);		
				EN <= '0';
			end loop;
		end loop;
		
		write(ln, string'("Conversion completed"));
		writeline(output, ln);
		DUMP_RAM <= '1';
		
		wait;
	end process;
	
	mon(results_f, CLK,CLR,EN,C0,DUMP_RAM,slv_to_char(CHR),WR,ERR,ADDR,DATA);
	
end architecture;
