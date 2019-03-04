`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 15:13:07
// Design Name: 
// Module Name: COMPARE
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

//data1 data2Ϊ�Ƚ�����
//1����2 big��1
//1С��2 little��1

module COMPARE(data1,data2,big,equal,little);
   input [31:0]  data1;
   input [31:0]  data2;
   output big,equal,little;
   
   assign equal=(data1==data2)? 1'b1: 1'b0;
   assign big=(data1>data2)? 1'b1: 1'b0;
   assign little=(data1<data2)? 1'b1: 1'b0;
endmodule
