`timescale 1ps / 1ps

// OR2 gate
module OR2 (I0, I1, O);
input  I0;
input  I1;
output O;
assign O = I0 | I1;
endmodule

// AND2 gate
module AND2 (I0, I1, O);
input  I0;
input  I1;
output O;
assign O = I0 & I1;
endmodule

// INV gate
module INV (I, O);
input  I;
output O;
assign O = ~I;
endmodule
