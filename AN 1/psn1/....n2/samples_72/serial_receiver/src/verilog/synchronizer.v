`timescale 1 ns/100 ps

module synchronizer (clk, rst, di, sync);

parameter dw = 9;

input clk;
input rst;
input [dw+1:0] di;

output sync;
reg sync;

  always @(negedge clk)
  begin
    if (rst)
      sync = 1'b1;
    else
      sync = di[dw+1] && (~di[0]);
  end

endmodule