`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 02:40:05
// Design Name: 
// Module Name: storage_mem
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


module storage_mem
(	
    input [31:0] num_addr,//输入设置为32位，取2-11位用于地址
    input [31:0] number,
    input clk,
    input rst,
    input memwrite,
    output reg [31:0] storage_out
);
	reg [31:0] mem_rom[1023:0];
	reg [10:0] site;
	
    initial
    begin
    end
		
    always @ (posedge clk or posedge rst) 
    begin 
        site= num_addr[11:2]; 
        if(memwrite==1 )//当memwrite为1时，将输入写入对应存储地址
            mem_rom[ site ]=number;
        else 
             mem_rom[ site ]=mem_rom[ site ];
        storage_out=mem_rom[ site ];//改变输出值   
        if(rst==1)
        begin
             //for(site=0;site<1024;site=site+1)
             begin
                // mem_rom[site]=0;
             end    
        end                
    end
	
endmodule
