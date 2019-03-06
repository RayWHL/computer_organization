`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2019/02/18 22:06:02
// Design Name: 
// Module Name: Controller
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

// 指令译码、控制信号产生
// 输入：指令的op字段和func字段，都是5bits
// 输出包括下面所述：
// alu_op：ALU的运算方法选择
// memToReg：从内存读出的数据写入到寄存器中
// memWrite：写入内存信号
// syscall：系统调用信号
// signedExt：符号扩展信号
// regDst：寄存器编号来源，为1来自于rd，为0来自于rt
// beq，bne，jr，jmp，jal均为分支信号
module Controller(op, func, alu_op, memToReg, memWrite, alu_src, regWrite, syscall, signedExt, regDst, beq, bne, jr, jmp, jal,lhu,bgez);
    input [5:0] op;
    input [5:0] func;
    output reg [3:0] alu_op;
    output reg memToReg, memWrite, alu_src, regWrite, syscall, signedExt, regDst, beq, bne, jr, jmp, jal,lhu,bgez;
    
    
    always @(*) begin
        memToReg = 0; memWrite= 0; alu_src= 0; regWrite= 0; syscall= 0; signedExt= 0; regDst= 0; beq= 0; bne= 0; jr= 0; jmp= 0; jal = 0; lhu=0 ; bgez=0; // init to 0
        case(op) 
            0: begin // R type instruction
                case(func) 
                    0: begin alu_op = 0; regWrite = 1; regDst = 1; end // SLL
                    3: begin alu_op = 1; regWrite = 1; regDst = 1; end // SRA
                    2: begin alu_op = 2; regWrite = 1; regDst = 1; end // SRL
                    32: begin alu_op = 5; regWrite = 1; regDst = 1; end // ADD
                    33: begin alu_op = 5; regWrite = 1; regDst = 1; end // ADDU
                    34: begin alu_op = 6; regWrite = 1; regDst = 1; end // SUB
                    36: begin alu_op = 7; regWrite = 1; regDst = 1; end // AND
                    37: begin alu_op = 8; regWrite = 1; regDst = 1; end // OR
                    39: begin alu_op = 10; regWrite = 1; regDst = 1; end // NOR
                    42: begin alu_op = 11; regWrite = 1; regDst = 1; end // SLT
                    43: begin alu_op = 12; regWrite = 1; regDst = 1; end // SLTU
                    8: begin alu_op = 5; jr = 1; jmp = 1; end // JR
                    12: begin syscall = 1; end // SYSCALL
                    38: begin alu_op=9; regWrite=1; regDst=1; end   //XOR
                   // 7: begin alu_op = 1; regWrite = 1; regDst = 1; srav = 1; end //SRAV
                    // add your own R type instructions here
                endcase
            end
            1: begin alu_op = 11; bgez = 1; end //BGEZ
            2: begin jmp = 1; end // J
            3: begin regWrite = 1; jal = 1; jmp = 1;end // JAL 
            4: begin signedExt = 1; beq = 1; end // BEQ
            5: begin signedExt = 1; bne = 1; end // BNE
            8: begin alu_op = 5; alu_src = 1; regWrite = 1; signedExt = 1; end // ADDI
            12: begin  alu_op = 7; alu_src = 1; regWrite = 1; end // ANDI
            9: begin  alu_op = 5; alu_src = 1; regWrite = 1; signedExt = 1; end // ADDIU
            10: begin  alu_op = 11; alu_src = 1; regWrite = 1; signedExt = 1; end // SLTI
           // 11:begin    alu_op = 12; alu_src = 1; regWrite = 1; signedExt = 1;sltiu = 1; end //SLTIU
            13: begin  alu_op = 8; alu_src = 1; regWrite = 1; end // ORI
            14: begin  alu_op=9;  alu_src=1;  regWrite=1;  end //XORI
            37: begin   alu_op = 5; memToReg = 1; alu_src = 1; regWrite = 1; signedExt = 1; lhu = 1; end //LHU
            35: begin  alu_op = 5; memToReg = 1; alu_src = 1; regWrite = 1; signedExt = 1;end // LW
            43: begin  alu_op = 5; memWrite = 1; alu_src = 1; signedExt = 1; end // SW
            // add your own M and J type instructions here
        endcase
    end
endmodule
