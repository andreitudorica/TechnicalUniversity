`timescale 1 ns/100 ps

module rcv_reg (clk, set, sin, do);

parameter dw = 9;

input clk;
input set;
input sin;

output do;
reg [dw+1:0] do;

reg [dw+1:0] di;

  always @(posedge clk)
  begin
    if (set)
      di = {sin, {(dw+1){1'b1}}};
    else
      di = {sin, do[dw+1:1]};
    do = di;
  end

endmodule