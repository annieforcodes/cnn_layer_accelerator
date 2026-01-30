`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 21:35:40
// Design Name: 
// Module Name: memory_tb
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



module memory_tb;

    // Parameters
    parameter DATA_WIDTH = 8;
    parameter IMG_WIDTH  = 4;
    parameter IMG_HEIGHT = 4;
    localparam ADDR_WIDTH = $clog2(IMG_WIDTH*IMG_HEIGHT);

    // Internal signals
    reg  clk; 
    reg  [ADDR_WIDTH-1:0] address;
    wire [DATA_WIDTH-1:0] data_out;
    
    // Clock Generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    image_memory dut (
        .clk(clk), 
        .address(address),
        .data_out(data_out)
    );

    // The stimulus block
    initial begin
        address = 0; // Initialize address
        #20; 
        // Test Case 1: Read the pixel at address 5
        address = 5;
        @(posedge clk); // Wait for the next clock edge for the address to be registered
        @(posedge clk); // Wait one more clock edge for the data to appear on the output
        #1; // Wait a tiny bit for the value to settle before displaying
        $display("Time=%0t | Testing address 5...  Data read: %h, Expected: 80", $time, data_out);

        // Test Case 2: Read the pixel at address 0
        address = 0;
        @(posedge clk); // Wait for address to be registered
        @(posedge clk); // Wait for data to appear
        #1;
        $display("Time=%0t | Testing address 0...  Data read: %h, Expected: FF", $time, data_out);
        
        // End the simulation
        $finish;
    end

endmodule