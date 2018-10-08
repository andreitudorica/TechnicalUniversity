`timescale 1 ns/100 ps

module clk_gen (clk);
  
output clk;  
reg clk;

parameter ckl_period = 10;
parameter half_period = ckl_period/2;

  initial
  begin
    clk = 1'b0;
    forever #half_period clk = ~clk;
  end

endmodule