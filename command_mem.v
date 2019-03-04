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
#(parameter DATA_WIDTH=32, parameter ADDR_WIDTH=32, parameter ROM_DEPTH=1024) //�ɱ����
(
	input [(ADDR_WIDTH-1):0] read_addr,//��������Ϊ32λ��ȡ2-11λ���ڵ�ַ
	input clk,
	output reg [(DATA_WIDTH-1):0] command_out
) ;

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] command_rom[ROM_DEPTH-1:0];
	reg [9:0] addr_set;

	initial
	begin
        $readmemh("E:/workuse/Component/test.txt", command_rom);	
    end

	always @ (posedge clk) 
	begin
	    addr_set=read_addr[11:2];
		command_out = command_rom[addr_set];                         // ��
	end
endmodule
