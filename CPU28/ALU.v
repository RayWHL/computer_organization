`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 16:48:38
// Design Name: 
// Module Name: ALU
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


module ALU(X,Y,S,shamt,result,result2,equal);
    input [31:0] X,Y;
    input [3:0] S;
    input [4:0] shamt;
    output reg equal;
    output reg [31:0] result,result2;
        
    wire signed [31:0] a = X, b = Y;
    always @(*) begin
          equal = (a==b)?1:0;
          result2 = 32'b0;
          case(S) 
                   4'b0000: result = Y << shamt;
                   4'b0001: result = b >>> shamt;
                   4'b0010:  result = Y >> shamt;
                   4'b0011: {result2, result} = a * b;
                   4'b0100: begin result = a / b; result2 = a % b; end
                   4'b0101: result = X + Y;
                   4'b0110: result = X - Y;
                   4'b0111: result = X & Y;
                   4'b1000: result = X | Y;
                   4'b1001: result = X ^ Y;
                   4'b1010: result = ~(X | Y);
                   4'b1011: result = a<b?1:0;
                   4'b1100: result = X<Y?1:0;
                   default: result = 0;
           endcase
           end
  
endmodule
