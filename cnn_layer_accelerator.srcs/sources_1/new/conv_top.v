`timescale 1ns / 1ps

module conv_top (
    input  wire clk,
    input  wire reset_in,
    input  wire start_in,
    output wire done_out,

    output wire [23:0] pixel_reg_out   // goes to AXI (NOT pins)
);

    reg  [23:0] pixel_reg;
    wire [23:0] pixel_wire;
    wire done_wire;

    convolution_accelerator dut (
        .clk          (clk),
        .rst          (reset_in),
        .start        (start_in),
        .done         (done_wire),
        .pixel_result (pixel_wire)
    );

    always @(posedge clk) begin
        if (reset_in)
            pixel_reg <= 24'd0;
        else if (done_wire)
            pixel_reg <= pixel_wire;
    end

    assign done_out      = done_wire;
    assign pixel_reg_out = pixel_reg;

endmodule
