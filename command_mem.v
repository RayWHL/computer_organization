`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/03 23:19:28
// Design Name: 
// Module Name: command_mem
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


module command_mem
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32, parameter ROM_DEPTH=1024) //可变参数
(
	input [(ADDR_WIDTH-1):0] read_addr,//输入设置为32位，取2-11位用于地址
	input clk,
	output [(DATA_WIDTH-1):0] command_out
) ;

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] command_rom[ROM_DEPTH-1:0];
	reg [9:0] addr_set;

	initial
	begin
        $readmemh("D:/ray/zuyuan/command.txt", command_rom);	
    end
    
    assign command_out = command_rom[read_addr[11:2]];   
/*
	always 
	begin
	    //addr_set=read_addr[11:2];
		assign command_out = command_rom[read_addr[11:2]];                         // 读
	end */
endmodule
