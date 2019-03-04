`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 15:10:34
// Design Name: 
// Module Name: Register
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


module Register(
clk,clear,in,out,enable
    );
    input clk,clear,enable;
    input [31:0]in;
    output reg [31:0]out;
    
    initial begin
    out<=32'b0;
    end
    
    always @(posedge clk)
    begin
        if(enable==1)
        begin
            if(clear)
            begin
                out<=32'b0;
            end
            else
            begin
                out<=in;
            end
        end
        else
        begin
            if(clear)
            begin
                out<=32'b0;
            end
            else
            begin
                out<=out;
            end
        end
    end
endmodule
