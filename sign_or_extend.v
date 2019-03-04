`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 04:21:02
// Design Name: 
// Module Name: sign_or_extend
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


module sign_or_extend
#(parameter IN_SIZE=16) //可变参数,输入位数
(
    input [31:0] data_in,//输入
    output reg[31:0]data_out,//输出
    input sign//有无符号扩展，0无符号，1有符号
);
    reg [31:0]zero_ex;
    wire [31:0]control;
      
    initial begin
        zero_ex<=32'b00000000000000000000000000000000;
    end
assign control=zero_ex - data_in[IN_SIZE-1];//0减去输入数据符号位，符号位为0即为0，否则全置1
    
    always @(data_in or sign)
    begin
        if(sign==0)
        begin
            data_out[IN_SIZE-1:0]=data_in[IN_SIZE-1:0];
            data_out[31:IN_SIZE]=zero_ex[31:IN_SIZE];
        end
        else
        begin
            data_out[IN_SIZE-1:0]=data_in[IN_SIZE-1:0];
            data_out[31:IN_SIZE]=control[31:IN_SIZE];
        end
    end
endmodule
