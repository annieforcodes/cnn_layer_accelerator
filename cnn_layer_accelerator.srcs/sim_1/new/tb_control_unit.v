`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 22:09:57
// Design Name: 
// Module Name: tb_control_unit
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



module tb_control_unit;

    parameter IMG_WIDTH = 4;

    // Testbench signals
    reg clk;
    reg rst;
    reg start;
    wire [3:0] mem_address;
    wire done;
    wire latch_pixel_enable; // <-- ADDED: Wire for the new output

    // Instantiate the Design Under Test (DUT)
    control_unit dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .mem_address(mem_address),
        .done(done),
        .latch_pixel_enable(latch_pixel_enable) // <-- ADDED: Connect the new port
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Stimulus and Monitoring
    initial begin
        $monitor("Time=%0t | State=%d, Counter=%d, Address=%d, LatchEnable=%b, Done=%b",
                 $time, dut.current_state, dut.pixel_counter, mem_address, latch_pixel_enable, done);

        // Reset the system
        rst = 1;
        start = 0;
        #20;
        rst = 0;
        #10;

        // Start the FSM
        start = 1;
        @(posedge clk);
        start = 0;

        // Wait for the 'done' signal to go high
        wait (done == 1);
        
        #20; // Wait a little longer
        
        $display("Test complete.");
        $finish;
    end

endmodule