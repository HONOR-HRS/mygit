module TEST_MODULE
                (
                clk,
                rst,
                sin_out
                 );
input clk,rst;
output  [8:0] sin_out;
wire [8:0] addr;
DDS  U_DDS
         (
         .clk(clk),
         .rst(rst),
         .addr_out(addr)
         );
         
my_rom u_my_rom(
            .address(addr),
            .clock(clk),
            .q(sin_out)
            );
         
endmodule