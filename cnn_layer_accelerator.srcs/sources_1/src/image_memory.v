`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 21:21:47
// Design Name: 
// Module Name: image_memory
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


// A memory module initialized directly in the code.

module image_memory #(
    parameter DATA_WIDTH = 8,
    parameter IMG_WIDTH  = 4,
    parameter IMG_HEIGHT = 4
)(
    input wire clk, // <-- ADD CLK TO THE PORT LIST
    input wire [$clog2(IMG_WIDTH*IMG_HEIGHT)-1:0] address,
    output reg [DATA_WIDTH-1:0] data_out 
);

    reg [DATA_WIDTH-1:0] mem [0:(IMG_WIDTH*IMG_HEIGHT)-1];

    initial begin
       
        mem[0]=8'hFF; mem[1]=8'hFF; mem[2]=8'hFF; mem[3]=8'hFF;
        mem[4]=8'hFF; mem[5]=8'h80; mem[6]=8'h80; mem[7]=8'hFF;
        mem[8]=8'hFF; mem[9]=8'h80; mem[10]=8'h80; mem[11]=8'hFF;
        mem[12]=8'hFF; mem[13]=8'hFF; mem[14]=8'hFF; mem[15]=8'hFF;
    end

    // SYNCHRONOUS BLOCK:
    always @(posedge clk) begin
        data_out <= mem[address];
    end

endmodule
//module image_memory #(
//    parameter DATA_WIDTH = 8,
//    parameter IMG_WIDTH  = 4,
//    parameter IMG_HEIGHT = 4
//)(
//    input wire clk,
//    input wire [$clog2(IMG_WIDTH*IMG_HEIGHT)-1:0] address,
//    output reg [DATA_WIDTH-1:0] data_out  
//);

//    // This memory definition is the same
//    reg [DATA_WIDTH-1:0] mem [0:(IMG_WIDTH*IMG_HEIGHT)-1];

//    // UPDATED initial block:
//    initial begin
//        // This one line replaces all 16 of your assignments
//        $readmemh("image_data.hex", mem);
//    end

//    // This synchronous logic is the same
//    always @(posedge clk) begin
//        data_out <= mem[address];
//    end

//endmodule