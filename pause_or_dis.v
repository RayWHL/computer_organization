`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 17:02:44
// Design Name: 
// Module Name: pause_or_dis
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module pause_or_dis(clk,rst,syscall,go,R1,R2,outdata,enable);   //syscall信号，GO按钮，R1寄存器的值，outdata显示数据，enable控制PC使能端
input syscall,go,clk,rst;
input [31:0]R1;
input [31:0]R2;
output reg [31:0]outdata;
output enable;
reg pause,stop;

initial begin
pause=1;
stop=1;
outdata=0;
end

always @(posedge clk) begin
//显示模块
if(rst==1)
outdata=0;
else begin
if(R1==34&&syscall==1)   //显示值
outdata=R2;
else
outdata=outdata;
end
//暂停模块
if((R1==10||R1==50)&&syscall==1)  //R1=10||50暂停
pause=0;
else
pause=1;
//停机指令
if(R1==10&&syscall==1)
stop=0;
else stop=1;

end

always @(posedge go) begin
//PC使能端控制信号
pause=1;
end
assign enable=pause&&stop;
endmodule
