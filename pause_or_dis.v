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


module pause_or_dis(clk,rst,syscall,go,R1,R2,outdata,enable);   //syscall�źţ�GO��ť��R1�Ĵ�����ֵ��outdata��ʾ���ݣ�enable����PCʹ�ܶ�
input syscall,go,clk,rst;
input [31:0]R1;
input [31:0]R2;
output  [31:0]outdata;
output enable;

reg display,pause,stop;

initial begin
    display=0;
    pause=0;
    stop=0;
end

always @(*) begin
    if((R1==34)&&(syscall==1))
        display=1;
    if((R1==10)&&(syscall==1))
        stop=1;
    if((R1!=34)&&(syscall==1))
        pause=1;
end

Register REGIS(clk,rst,R2,outdata,display);
assign enable=((~pause)|go)&(~stop);
/*

assign pause1=pause|go;

always @(posedge clk) begin
//��ʾģ��
if(rst==1)
    outdata=0;
else begin
    if(R1==34&&syscall==1)   //��ʾֵ
        outdata=R2;
    else
        outdata=outdata;
    end
//��ͣģ��
if((R1==10||R1==50)&&syscall==1)  //R1=10||50��ͣ
    pause=0;
else
    pause=1;
//ͣ��ָ��
if(R1==10&&syscall==1)
    stop=0;
else stop=1;

end

assign enable=pause1&stop;
*/
endmodule
