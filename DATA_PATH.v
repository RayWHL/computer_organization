`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/03/04 20:12:13
// Design Name: 
// Module Name: DATA_PATH
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


module DATA_PATH(clk,rst,go,seg,an);
    input clk,rst,go;
    output reg [7:0] seg,an;
    
    wire jal,jr,jmp,bne_q,bgez, memToReg, memWrite, alu_src, regWrite, syscall, signedExt, regDst, beq, bn,lhu;
    wire [31:0] pc_in,pc_out,command_out,pc1,pc2,pc3,pc4,command_k,pc1_2,pc1_2_3;
    wire [31:0] r1,r2;
    wire [4:0] r1_in,r2_in,w_in,w_in1;
    wire [31:0] din_in,din11;
    wire [31:0] sm0,sm1,sm2;
    wire [31:0] a_in,b_in;
    wire [3:0] alu_op;
    wire [4:0] shamt;
    wire [31:0] result,result2;
    wire equal;
    
    wire pc_enable;
    
    Register pc(clk,rst,pc_in,pc_out,pc_enable);
    command_mem cm(pc_out,clk,command_out);
    
    //控制器
    CONTROLLER(command_out[31:26],command_out[5:0],alu_op, memToReg, memWrite, alu_src, regWrite, syscall, signedExt, regDst, beq, bne, jr, jmp, jal,lhu,bgez);
    
    //pc跳转模块
    assign bne_q=(equal&beq) | (~equal &bne);
    assign pc1=pc_out+4;
    MUX M1({pc_out[31:28],command_out[25:0],2'b0},{pc1[31:28],command_out[25:0],2'b0},jal,pc4);
    MUX M2(pc4,r1,jr,pc3);
    sign_or_extend #(18) SOE1({command_out[15:0],2'b0},command_k,1);
    assign pc2=command_k+pc1;
    MUX M3(pc1,pc2,bne_q,pc1_2);
    MUX M4(pc1_2,pc3,jmp,pc1_2_3);
    MUX M5(pc1_2_3,pc2,bgez&r1[31],pc_in);
    
    assign r1_in=syscall? 5'b10 : command_out[25:21];
    assign r2_in=syscall? 5'b100 : command_out[20:16];
    assign w_in1=regDst? command_out[15:11] : command_out[20:16];
    assign w_in=jal? 5'b11111 : w_in1;
    MUX M6(din11,pc1,jal,din_in);
    //寄存器文件
    RegFile RF1(r1_in,r2_in,w_in,din_in,regWrite,clk,r1,r2);
    //数据扩展
    sign_or_extend #(16) SOR2(command_out[15:0],sm0,0);
    sign_or_extend #(16) SOR3(command_out[15:0],sm1,1);
    MUX M7(sm0,sm1,signedExt,sm2);
    
    //alu模块
    assign a_in=r1;
    assign shamt=commant_out[10:6];
    MUX M8(r2,sm2,alu_src,b_in);
    ALU A1(a_in,b_in,alu_op,shamt,result,result2,equal);
    
    //数据存储器模块
    wire [3:0] sel1,sel2;
    wire [31:0] data_out,data_out3;
    wire [15:0] data_out1;
    assign sel1= result[1]? 4'b1100 : 4'b0011;
    assign sel2= lhu? sel1: 4'b1111;
    storage_mem ST_M(result,r2,clk,rst,memWrite,data_out);
    
    //LHU模块
    assign data_out1=result[1]? data_out[31:16] : data_out[15:0];
    MUX M9(data_out,{16'b0,data_out1},lhu,data_out3);
    
    MUX M10(result,data_out3,memToReg,din11);
    
    wire outdata[31:0];
    //暂停
     pause_or_dis POD (clk,rst,syscall,go,r1,r2,outdata,pc_enable);
    //显示
    display DIS(clk,seg,an,outdata);
    
endmodule
