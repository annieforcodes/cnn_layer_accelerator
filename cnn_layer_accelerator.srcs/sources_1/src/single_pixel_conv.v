`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 20:13:33
// Design Name: 
// Module Name: single_pixel_conv
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


module single_pixel_conv(p0,p1,p2,p3,p4,p5,p6,p7,p8,k0,k1,k2,k3,k4,k5,k6,k7,k8, output_pixel);
input [7:0] p0,p1,p2,p3,p4,p5,p6,p7,p8,k0,k1,k2,k3,k4,k5,k6,k7,k8;
output [23:0] output_pixel;
assign output_pixel = (p0*k0)+(p1*k1)+(p2*k2)+(p3*k3)+(p4*k4)+(p5*k5)+(p6*k6)+(p7*k7)+(p8*k8);
endmodule
