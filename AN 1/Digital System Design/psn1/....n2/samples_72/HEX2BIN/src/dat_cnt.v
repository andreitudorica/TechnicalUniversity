`timescale 1ns / 1ps
module DAT_CNT (CLK, CLR, CLE, D, CE, ZD) ;

input CLK,CLR;
input [1:0] CLE ;
input [3:0] D ;
input CE ;
output ZD ;  //Zero detected
reg [5:0] Q;

always @(posedge CLK or posedge CLR) begin
  if(CLR)
    Q = 6'd0;
  else begin  
    casex({CLE,CE})
      //3'b000: Q=Q;
      3'b001: Q=Q-1;
      3'b01?: begin
                Q[3:0]=D[3:0];
                //Q[5:4]=Q[5:4];
	      end
      3'b10?: begin
               //Q[3:0]=Q[3:0];
               Q[5:4]=D[1:0];
              end
      //3'b11?: Q=Q;          
    endcase
  end  
end

assign ZD=(Q==0);

endmodule 
