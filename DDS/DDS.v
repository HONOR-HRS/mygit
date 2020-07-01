module DDS
         (
         clk,
         rst,
         addr_out
         );
input clk,rst;
output [8:0] addr_out;
reg  [31:0] fct;
parameter K = 85899345;
// Fout = (clk*K)/2^N
always@(posedge clk or negedge rst)
begin
   if(!rst)
      fct <= 32'd0;
    else fct <= fct + K;
end 

assign addr_out = fct[31:23];
endmodule