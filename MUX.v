`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 14:56:38
// Design Name: 
// Module Name: MUX
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

//模块说明：
//输入 sel为0输出data1，为1输出data2

module MUX(data1,data2,sel, an );
    input [31:0]  data1;
    input [31:0]  data2;
    input sel;
    output reg [31:0] an;
  
   always @(sel, data1, data2)
       begin
           if(sel==0)
                  an=data1;
           else
                  an=data2;
        end
endmodule
