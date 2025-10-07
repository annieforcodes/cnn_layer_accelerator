`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.10.2025 21:55:23
// Design Name: 
// Module Name: control_unit
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


// Control Unit to fetch one 3x3 patch from memory

// CORRECTED Control Unit for Synchronous Memory

module control_unit #(
    parameter IMG_WIDTH = 4
)(
    input wire clk,
    input wire rst,
    input wire start,
    output reg [3:0] mem_address,
    output reg done,
    // New output to tell the top-level when to save a pixel
    output reg latch_pixel_enable 
);

    // 1. Define the FSM states (with a new WAIT state)
    localparam S_IDLE      = 2'b00;
    localparam S_FETCH_ADDR = 2'b01;
    localparam S_WAIT_DATA = 2'b10;
    localparam S_DONE      = 2'b11;

    // 2. State registers
    reg [1:0] current_state, next_state;

    // 3. A counter to keep track of which pixel we are fetching
    reg [3:0] pixel_counter;

    // 4. Sequential logic for state transitions
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            current_state <= S_IDLE;
            pixel_counter <= 0;
        end else begin
            current_state <= next_state;
            // Only increment the counter AFTER we have waited for the data
            if (current_state == S_WAIT_DATA) begin
                pixel_counter <= pixel_counter + 1;
            end else if (current_state == S_IDLE && start == 1) begin
                pixel_counter <= 0; // Reset counter when starting
            end
        end
    end

    // 5. Combinational logic to determine next_state and outputs
    always @(*) begin
        // Default values
        next_state  = current_state;
        mem_address = 0;
        done        = 0;
        latch_pixel_enable = 0; // Default to off

        case (current_state)
            S_IDLE: begin
                if (start) begin
                    next_state = S_FETCH_ADDR;
                end
            end
            S_FETCH_ADDR: begin
                // Send out the address based on the current counter
                mem_address = 5 + (pixel_counter/3)*IMG_WIDTH + (pixel_counter%3);
                // Immediately go to the WAIT state on the next cycle
                next_state = S_WAIT_DATA;
            end
            S_WAIT_DATA: begin
                // The data from memory is now valid, so enable the latch
                latch_pixel_enable = 1;
                if (pixel_counter == 8) begin
                    next_state = S_DONE; // We have fetched the last pixel
                end else begin
                    next_state = S_FETCH_ADDR; // Go back to fetch the next pixel
                end
            end
            S_DONE: begin
                done = 1; // Signal that we are finished
                next_state = S_IDLE;
            end
        endcase
    end

endmodule

