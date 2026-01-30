`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 22:37:28
// Design Name: 
// Module Name: tb_final_accelerator
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



// Final testbench for the complete accelerator
module tb_final_accelerator;
    reg clk;
    reg rst;
    reg start;
    wire done;
    wire [23:0] pixel_result;

    convolution_accelerator dut (
        .clk(clk), .rst(rst), .start(start),
        .done(done), .pixel_result(pixel_result)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        $display("Starting final system test...");
        
        rst = 1; start = 0; #20;
        rst = 0; #10;
        
        start = 1; @(posedge clk); start = 0;

        wait (done == 1);
        #10;
        
        $display("Success! Accelerator raised the 'done' flag.");
        
        // The expected value is 1787 (sum of pixels) * 3 (kernel weight) = 5361
        if (pixel_result == 5361) begin
            $display("VERIFICATION PASSED: Result matches the expected value of 5361.");
        end else begin
            $display("VERIFICATION FAILED: Result is %d, but expected 5361.", pixel_result);
        end

        $finish;
    end
endmodule