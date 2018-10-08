`timescale 1ps / 1ps
module UUT_STD;

reg  [7:0]  DI,Byte;
reg  CLK,EN,CLR,CE;
wire [15:0] AB;
wire [7:0]  DB;
wire WR,ERR;
reg [8*30:0] s;
reg [10:0] stc,stch;


integer f,f1;


DAC_SC1 CNV (.CLK(CLK),.EN(EN),.CLR(CLR),.DI(DI),.DB(DB),.AB(AB),.WE(WR),.ERR(ERR));

initial
//  ":0200FF003C00C3 :00000001FF";
  s = "FF10000000: 3C00C300FF0020:";
initial begin
  CLK = 1'b0;
  DI  = 8'h25;
  EN  = 0;
end

initial begin 
  #0;
  stc = 11'd0;
  CLR = 1'b1;
  #40 CLR = 1'b0;       
end

always
  #10 CLK = ~CLK;      

always begin
  if(!CLR) begin
	#5 EN = 1'b1;
    if(stc<240)
      DI = {s[stc+7],s[stc+6],s[stc+5],s[stc+4],s[stc+3],s[stc+2],s[stc+1],s[stc]};
    #15 EN = 1'b0;  
    #20 stc  = stc + 11'd8;
  end
  else
    #1;  
end
  
initial
  #1120 $finish;

initial begin
   f=$fopen("results_std.txt");
   f1=$fopen("mem_wr.dat");
   $fdisplay(f1," Address -> Data (Time)");
   f=f+1;
  $fmonitor(f,"%d %d %d | %h | %h | %h | %b | %b",$time,CLK,EN,DI,AB,DB,WR,ERR );  
end

always @(WR)
  if(WR==1'b0)
    $fdisplay(f1," %h -> %h (%d)",AB,DB,$time);

endmodule