`timescale 1ns / 1ns

module hex_ram_tb;
localparam integer EOF = -1;
localparam lf = 8'h0A;
localparam cr = 8'h0D;

reg CLK,CLR,EN,C0,DUMP_RAM;
reg [7:0] CHR;
wire WR,ERR;
wire [15:0] ADDR;
wire [7:0] DATA;

integer results;
reg [256*8:1] res_filename, stimulus;
integer rd_char = 0;

hex_ram sc_u (.CLK(CLK),
	.CLR(CLR),
	.EN(EN),
	.C0(C0),
	.DUMP_RAM(DUMP_RAM),
	.CHR(CHR),
	.WR(WR),
	.ERR(ERR),
	.ADDR(ADDR),
	.DATA(DATA)
	);

	task gen_clk(input integer cycle, input time period);
	begin
		repeat(cycle) begin
			#period;
			CLK = ~CLK;
			#period;
			CLK = ~CLK;
		end
	end
	endtask

	initial begin
		if(!$value$plusargs("file=%s", res_filename))
			res_filename = "results_ver.txt";

		results = $fopen(res_filename);

		if(!results) begin
			$display("Fatal ERROR: Results file could not be opened!");
			$finish;
		end

		stimulus = $fopen("$dsn//src//dcfa1.hex", "r");

		if(!stimulus) begin
			$display("Fatal ERROR: Input file not found!");
			$finish;
		end

		$fmonitor(results, $time,, "%b  %b  %b  %b  %b  %c  %b  %b  %b  %b", CLK, CLR, EN, C0, DUMP_RAM, CHR, WR, ERR, ADDR, DATA);

		DUMP_RAM = 0;
		C0 = 1'b0;
		CLK = 1'b0;
		CLR = 1'b1;
		EN = 1'b0;
		CHR = 8'h47; //'G'
		$display("Conversion started...");
		#10;
		gen_clk(5,10);
		CLR = 1'b0;
		gen_clk(20,10);

		while(rd_char != EOF) begin : continue_loop
			rd_char = $fgetc(stimulus);
			if (rd_char == lf || rd_char == cr || rd_char == EOF) 
				disable continue_loop;
			gen_clk(2,10);		
			CHR = rd_char;
			EN =  1'b1;
			gen_clk(1,10);		
			EN =  1'b0;
		end
		$display("Conversion completed");
		DUMP_RAM =1'b1;
	end
endmodule
