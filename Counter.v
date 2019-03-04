`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 15:09:39
// Design Name: 
// Module Name: Counter
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


module Counter(
    input reset,
    input clk,
    input enable,
    input [31:0]data,
    output reg [31:0]out_data
    );
    initial begin
    out_data<=0;   //初始化输出为0
    end
    always @(posedge clk) begin
    if(reset==1)   //reset==1，清零
    out_data<=0;
    else begin
    if(enable==1)
        out_data=out_data+1;
        else out_data=out_data;
    end
    end
    
endmodule
