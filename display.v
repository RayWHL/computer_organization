`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2018/09/03 09:09:47
// Design Name: 
// Module Name: display
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


module display(clk,SEG,AN,data);
input clk;
input [31:0] data;
output reg [7:0] SEG;   //�������
output reg [7:0] AN;   //��Ҫ����������
reg [4:0] scan_counter;   //ɨ��Ƶ�ʼ����� [15��0]
reg [3:0] databuf;    //���ݻ���

initial begin
scan_counter<=0;
databuf<=0;
end
//Ϊ������ܵ���ʾ�Լ��������м���
always @(posedge clk) begin
scan_counter<=scan_counter+1;
end
//������ܵĲ���
always @(scan_counter) begin

case(scan_counter[4:2])  //ѭ������8����
3'b000:AN=8'b1111_1110;
3'b001:AN=8'b1111_1101;
3'b010:AN=8'b1111_1011;
3'b011:AN=8'b1111_0111;
3'b100:AN=8'b1110_1111;
3'b101:AN=8'b1101_1111;
3'b110:AN=8'b1011_1111;
3'b111:AN=8'b0111_1111;
default: AN=8'b1111_1111;
endcase
end


always @(AN) begin
case(AN)    //��ʾ��ֵ
8'b1111_1110: begin   //���һλ
databuf=data[3:0];  //��һλ
end  
8'b1111_1101: begin//�ڶ�λ��һ����������
databuf=data[7:4];
end
8'b1111_1011: begin
databuf=data[11:8];
end
8'b1111_0111: begin
databuf=data[15:12];
end
8'b1110_1111: begin
databuf=data[19:16];
end
8'b1101_1111: begin
databuf=data[23:20];
end
8'b1011_1111: begin
databuf=data[27:24];
end
8'b0111_1111: begin
databuf=data[31:28];
end
default: databuf=2'b0000;  //����λ����ʾ0
endcase
end

always @(databuf) begin   //������ʾ��Ӧ��ת���
case(databuf)

5'b0000: SEG=8'b11000000;  //��ʾ0
5'b0001: SEG=8'b11111001;  //��ʾ1
5'b0010: SEG=8'b10100100;  //��ʾ2
5'b0011: SEG=8'b10110000;  //��ʾ3
5'b0100: SEG=8'b10011001;  //��ʾ4
5'b0101: SEG=8'b10010010;  //��ʾ5
5'b0110: SEG=8'b10000010;  //��ʾ6
5'b0111: SEG=8'b11111000;  //��ʾ7
5'b1000: SEG=8'b10000000;  //��ʾ8
5'b1001: SEG=8'b10010000;  //��ʾ9
5'b1010: SEG=8'b10001000;  //��ʾa
5'b1011: SEG=8'b10000011;  //��ʾb
5'b1100: SEG=8'b11000110;  //��ʾc
5'b1101: SEG=8'b10100001;  //��ʾd
5'b1110: SEG=8'b10000110;  //��ʾe
5'b1111: SEG=8'b10001110;  //��ʾf

endcase
end
endmodule