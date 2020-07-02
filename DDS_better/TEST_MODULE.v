module TEST_MODULE
                (
                clk,
                rst,
                sin_out,
                sin_out_one,                
                 );
input clk,rst;
output  [8:0] sin_out,sin_out_one;
wire     [8:0] reg_sin_out_one;
wire    [8:0] addr;
wire    [8:0] addr_short;
wire          sign_out;

DDS  U_DDS
         (
         .clk(clk),
         .rst(rst),
         .addr_out(addr),
         .addr_short(addr_short),
         .sign_out(sign_out)
         );

//512个正弦波采样点         
my_rom u_my_rom(
            .address(addr),
            .clock(clk),
            .q(sin_out)
            );
            
//128个正弦波采样点 
my_rom_one u_my_rom_one
                    (
                     .address(addr_short),
	                 .clock(clk),
	                 .q(reg_sin_out_one)
                    );
assign sin_out_one = sign_out? ~reg_sin_out_one+1:reg_sin_out_one;//根据符号调整正负，正数不变，负数取补码


         
endmodule