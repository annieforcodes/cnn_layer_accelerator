`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 20:43:39
// Design Name: 
// Module Name: single_pixel_conv_tb
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


module single_pixel_conv_tb;
reg [7:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,k0,k1,k2,k3,k4,k5,k6,k7,k8;
wire  [23:0] output_pixel;
single_pixel_conv dut(p0,p1,p2,p3,p4,p5,p6,p7,p8,k0,k1,k2,k3,k4,k5,k6,k7,k8,output_pixel);
initial begin
p0=1;p1=1;p2=1;
p3=1;p4=1;p5=1;
p6=1;p7=1;p8=1;

k0=3;k1=3;k2=3;
k3=3;k4=3;k5=3;
k6=3;k7=3;k8=3;

#10;


$display("output %d",output_pixel);
$finish;
end
endmodule
