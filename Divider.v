`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 14:53:19
// Design Name: 
// Module Name: Divider
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


module Divider(clk,clk_n
    );
    input clk;
    output reg clk_n;
    parameter N=50000000;
    reg [31:0]num;
    
    initial begin
    num<=0;
    clk_n<=0;
    end
    
    always @(posedge clk)
        begin
            if(num<(N/2-1))
                begin
                num<=num+1;
                end
            else
                begin
                num<=0;
                clk_n<=~clk_n;
                end
        end
endmodule