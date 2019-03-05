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
    input [31:0] num_addr,//��������Ϊ32λ��ȡ2-11λ���ڵ�ַ
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
        if(memwrite==1 )//��memwriteΪ1ʱ��������д���Ӧ�洢��ַ
            mem_rom[ site ]=number;
        else 
             mem_rom[ site ]=mem_rom[ site ];
        storage_out=mem_rom[ site ];//�ı����ֵ   
        if(rst==1)
        begin
             //for(site=0;site<1024;site=site+1)
             begin
                // mem_rom[site]=0;
             end    
        end                
    end
	
endmodule
