`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 16:33:09
// Design Name: 
// Module Name: RegFile
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


module RegFile(
R1_ADDR,R2_ADDR,W_ADDR,Din,WE,clk,R1,R2
    );
    input [4:0]R1_ADDR;
    input [4:0]R2_ADDR;
    input [4:0]W_ADDR;
    input [31:0]Din;
    input WE,clk;
    output [31:0]R1;
    output [31:0]R2;
    reg [31:0]register[31:0];
    
    integer i;
    initial begin
        for(i=0;i<32;i=i+1) begin
            register[i]<=0;
        end
    end
    always @(posedge clk)
    begin
        if(WE)
        begin
            register[W_ADDR]<=Din;
        end
    end
    
    assign R1=register[R1_ADDR];
    assign R2=register[R2_ADDR];
   
endmodule
