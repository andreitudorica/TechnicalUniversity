`timescale 1ps / 1ps

module V_BJACK_tb;
initial
	$dumpvars (0,V_BJACK_tb);

// Additional signals
reg  SYS_CLK;
reg  START;
reg  NEW_CARD;
wire [6:0]L_L;
wire [6:0]L_H;
wire [7:0]LEDS;
reg  GEN_RES;
reg  GEN_CLK;
wire [3:0]D_L;
wire [1:0]D_H;
wire BUST;
wire HOLD;

reg  END_SIM;
integer res_file;

initial
begin
	res_file = $fopen ("Results.txt");
	$fdisplay (res_file,"Inputs: NEW_CARD GEN_RES START GEN_CLK SYS_CLK\n");
	$fdisplay (res_file,"Outputs: D_L D_H BUST HOLD L_L L_H LEDS\n");
end

always @ (BUST or HOLD or NEW_CARD or GEN_RES or GEN_CLK or START or
		  SYS_CLK or L_L or L_H or LEDS or D_L or D_H)
begin
	$fdisplay (res_file, " %d ps %b %b %b %b %b %b %b %b %b %b %b %b", $time,
						 NEW_CARD, GEN_RES, START, GEN_CLK, SYS_CLK, D_L,
						 D_H, BUST,HOLD, L_L, L_H, LEDS);
end

V_BJACK UUT (.SYS_CLK(SYS_CLK), .START(START), .NEW_CARD(NEW_CARD),
			 .L_L(L_L), .L_H(L_H), .D_L(D_L), .D_H(D_H), .BUST(BUST),
			 .HOLD(HOLD), .LEDS(LEDS), .GEN_RES(GEN_RES), .GEN_CLK(GEN_CLK));

initial
begin
	
	END_SIM = 1'b0;
	SYS_CLK = 1'b0;
	GEN_CLK = 1'b0;	
	$dumpflush;

end

//-- generate SYS_CLK, period 80 ps
always
begin : SYS_CLK_G
	
	if (!END_SIM)
	begin
		#40 SYS_CLK = 1'b1;
	$dumpflush;
		#40 SYS_CLK = 1'b0;
	$dumpflush;
	end
	else
		#1;
end

// generate GEN_CLK, period 320 ps
always
begin : GEN_CLK_G
	
	if (!END_SIM)
	begin
		#160 GEN_CLK = 1'b1; 
	$dumpflush;
		#160 GEN_CLK = 1'b0;
	$dumpflush;
	end
	else		
		#1;
end

// generate waveforms for NEW_CARD, GEN_RES, START signals

initial
begin : STIMUL	  
	#0
	NEW_CARD = 1'b1;
	GEN_RES = 1'b1;
	START = 1'b1;
	#50 GEN_RES = 1'b0;
	$dumpflush;
	#1200;
	START = 1'b0;
	$display ("The new game starts");
	$dumpflush;
	#100 START = 1'b1;      // 1350 ps
	$dumpflush;
	#540 NEW_CARD = 1'b0;   // 1890 ps
	$dumpflush;
	#90  NEW_CARD = 1'b1;   // 1980 ps
	$dumpflush;
	#170 NEW_CARD = 1'b0;   // 2150 ps
	$dumpflush;
	#70  NEW_CARD = 1'b1;   // 2220 ps
	$dumpflush;
	#150 NEW_CARD = 1'b0;   // 2370 ps
	$dumpflush;
	#80  NEW_CARD = 1'b1;   // 2450 ps
	$dumpflush;
	#500;
	START = 1'b0;           // 2950 ps
	$display ("The new game starts");
	$dumpflush;
	#150 START = 1'b1;      // 3100 ps
	$dumpflush;
	#70  NEW_CARD = 1'b0;   // 3170 ps
	$dumpflush;
	#430 NEW_CARD = 1'b1;   // 3600 ps
	$dumpflush;
	#610 NEW_CARD = 1'b0;   // 4210 ps
	$dumpflush;
	#160 NEW_CARD = 1'b1;   // 4370 ps
	$dumpflush;
	#330 NEW_CARD = 1'b0;   // 4700 ps
	$dumpflush;
	#100 NEW_CARD = 1'b1;   // 4800 ps
	$dumpflush;
	#800;
	START = 1'b0;           // 5600 ps
	$display ("The new game starts");
	$dumpflush;
	#300 START = 1'b0;      // 5900 ps
	$dumpflush;
	#150 NEW_CARD = 1'b0;   // 6050 ps
	$dumpflush;
	#240 NEW_CARD = 1'b1;   // 6290 ps
	$dumpflush;
	#1040 NEW_CARD = 1'b0;  // 7330 ps
	$dumpflush;
	#120 NEW_CARD = 1'b1;   // 7450 ps
	$dumpflush;
	#280 NEW_CARD = 1'b0;   // 7730 ps
	$dumpflush;
	#240 NEW_CARD = 1'b1;   // 7970 ps
	$dumpflush;
	#330 NEW_CARD = 1'b0;   // 8300 ps
	$dumpflush;
	#250 NEW_CARD = 1'b1;   // 8550 ps
	$dumpflush;
	#1850;					// 10400 ps
	START = 1'b0;
	$display ("The new game starts");
	$dumpflush;
	#500 START = 1'b1;      // 10900 ps
	$dumpflush;
	#650 NEW_CARD = 1'b0;   // 11550 ps
	$dumpflush;
	#100 NEW_CARD = 1'b1;   // 11650 ps
	$dumpflush;
	#500 NEW_CARD = 1'b0;   // 12150 ps
	$dumpflush;
	#100 NEW_CARD = 1'b1;   // 12250 ps
	$dumpflush;
	#500 NEW_CARD = 1'b0;   // 12750 ps
	$dumpflush;
	#100 NEW_CARD = 1'b1;   // 12850 ps
	$dumpflush;
	#1360 NEW_CARD = 1'b0;  // 14210 ps
	$dumpflush;
	#100 NEW_CARD = 1'b1;   // 14310 ps
	$dumpflush;
	#500 NEW_CARD = 1'b0;   // 14810 ps
	$dumpflush;
	#100 NEW_CARD = 1'b1;   // 14910 ps
	$dumpflush;
	#500;					 // 15410 ps
	END_SIM = 1'b1 ;
	$display ("V_BJACK testing completed");
	$finish;
	//disable STIMUL;	// not necessary !!
end


endmodule
