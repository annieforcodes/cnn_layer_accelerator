`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 22:25:49
// Design Name: 
// Module Name: convolution_accelerator
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





module convolution_accelerator(
    input wire clk,
    input wire rst,
    input wire start,
    output wire done,
    output wire [23:0] pixel_result
);
    // Internal wires
    wire [3:0] mem_addr;
    wire [7:0] mem_data_out;
    wire latch_pixel_enable;
    
    // NEW: A local counter for loading the pixel patch
    reg [3:0] patch_load_counter;

    // The pixel patch register file
    reg [7:0] pixel_patch [0:8];

    // Instantiate the simpler Control Unit (without pixel_counter_out)
    control_unit cu (
        .clk(clk), .rst(rst), .start(start),
        .mem_address(mem_addr), .done(done),
        .latch_pixel_enable(latch_pixel_enable)
    );

    // Instantiate the Memory (no change)
    image_memory mem (
        .clk(clk),
        .address(mem_addr),
        .data_out(mem_data_out)
    );

    // Instantiate the Processing Element (no change)
    single_pixel_conv pe (
        .p0(pixel_patch[0]), .p1(pixel_patch[1]), .p2(pixel_patch[2]),
        .p3(pixel_patch[3]), .p4(pixel_patch[4]), .p5(pixel_patch[5]),
        .p6(pixel_patch[6]), .p7(pixel_patch[7]), .p8(pixel_patch[8]),
        .k0(8'd3), .k1(8'd3), .k2(8'd3), .k3(8'd3), .k4(8'd3),
        .k5(8'd3), .k6(8'd3), .k7(8'd3), .k8(8'd3),
        .output_pixel(pixel_result)
    );
    
    // MODIFIED: Logic for the new local counter and patch loading
    always @(posedge clk) begin
        if (rst || done) begin
            // Reset the counter when the system resets or is done
            patch_load_counter <= 0;
        end else if (latch_pixel_enable) begin
            // When the control unit says data is valid,
            // load the data and increment our local counter.
            pixel_patch[patch_load_counter] <= mem_data_out;
            patch_load_counter <= patch_load_counter + 1;
        end
    end
endmodule