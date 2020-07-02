module DDS
         (
         clk,
         rst,
         addr_out,
         addr_short,
         sign_out
         );
/* 端口说明
    时间       ------  2020.7.2   
    clk        ------  50M时钟输入
    rst        ------  复位信号输入，低电平有效
    addr_out   ------  512采样点的ROM的地址线，宽度9位
    addr_short ------  128采样点的ROM的地址线，宽度7位
    sign_out   ------  对称性的符号位，1：表示负数  0：表示正数
 */
 /* 功能说明
     相位累加器
     利用正弦波的对称性选择1/4周期的采样点并根据象限设置正负符号
 */
input clk,rst;
output reg sign_out;//符号位
output [8:0] addr_out;
output reg [6:0] addr_short;
reg  [31:0] fct;
parameter K = 85899345; //1M正弦波
// Fout = (clk*K)/2^N
always@(posedge clk or negedge rst)
begin
   if(!rst)
        begin
        fct <= 32'd0;
        addr_short <= 7'd0;
        sign_out <=1'b0;
        end      
    else 
        begin
        fct <= fct + K;
        if(fct[31:23]<=8'd127)//第一象限
            begin
                addr_short <= fct[29:23];
                sign_out <=1'b0;
            end
        else if(fct[31:23]>9'd127&&fct[31:23]<9'd256)//第二象限
                begin
                    addr_short = 8'd255-fct[31:23];
                    sign_out <=1'b0;
                end           
        else if(fct[31:23]>=9'd256&&fct[31:23]<9'd384)//第三象限
                begin
                    addr_short = fct[31:23] - 8'd255;
                    sign_out <=1'b1;
                end            
        else if(fct[31:23]>=9'd384)//第四象限
                begin
                    addr_short = 9'd511 - fct[31:23];
                    sign_out <=1'b1;
                end
            
        end 
end 

assign addr_out = fct[31:23];
endmodule