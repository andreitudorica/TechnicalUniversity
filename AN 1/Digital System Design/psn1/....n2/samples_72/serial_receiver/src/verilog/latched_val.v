`timescale 1 ns/100 ps

module latched_val (load, clr, di, do);

parameter dw = 9;

input load;
input clr;
input [dw+1:0] di;

output [dw-1:0] do;
reg  [dw-1:0] do;

  always @(posedge load or posedge clr)
  begin
    if (clr)
      do = {dw{1'b0}};
    else
    begin
      do = di[dw:1];
      //synopsys translate_off
      $display("%c", do);
      //synopsys translate_on
    end
  end

endmodule