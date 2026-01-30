`timescale 1ns / 1ps

module conv_top_axi_wrapper #
(
    parameter integer C_S_AXI_DATA_WIDTH = 32,
    parameter integer C_S_AXI_ADDR_WIDTH = 4
)
(
    /* ================= Physical pins (XDC) ================= */
    input  wire clk,
    input  wire reset_in,
    input  wire start_in,
    output wire done_out,

    /* ================= AXI4-Lite Slave ===================== */
    input  wire                          s_axi_aclk,
    input  wire                          s_axi_aresetn,

    input  wire [C_S_AXI_ADDR_WIDTH-1:0] s_axi_awaddr,
    input  wire                          s_axi_awvalid,
    output wire                          s_axi_awready,

    input  wire [C_S_AXI_DATA_WIDTH-1:0] s_axi_wdata,
    input  wire [(C_S_AXI_DATA_WIDTH/8)-1:0] s_axi_wstrb,
    input  wire                          s_axi_wvalid,
    output wire                          s_axi_wready,

    output wire [1:0]                    s_axi_bresp,
    output wire                          s_axi_bvalid,
    input  wire                          s_axi_bready,

    input  wire [C_S_AXI_ADDR_WIDTH-1:0] s_axi_araddr,
    input  wire                          s_axi_arvalid,
    output wire                          s_axi_arready,

    output reg  [C_S_AXI_DATA_WIDTH-1:0] s_axi_rdata,
    output wire [1:0]                    s_axi_rresp,
    output wire                          s_axi_rvalid,
    input  wire                          s_axi_rready
);

    /* ========================================================
       Internal signals
    ======================================================== */
    wire        done_wire;
    wire [23:0] pixel_reg_internal;   // REGISTERED pixel value

    /* ========================================================
       Instantiate your existing conv_top
       (pixel is stored internally there)
    ======================================================== */
    conv_top u_conv_top (
        .clk      (clk),
        .reset_in (reset_in),
        .start_in (start_in),
        .done_out (done_wire)
    );

    assign done_out = done_wire;

    /* ========================================================
       AXI-Lite simple READ-ONLY register interface
       Offset 0x00 : PIXEL_REG
    ======================================================== */

    assign s_axi_awready = 1'b1;
    assign s_axi_wready  = 1'b1;
    assign s_axi_bresp   = 2'b00;
    assign s_axi_bvalid  = s_axi_awvalid & s_axi_wvalid;

    assign s_axi_arready = 1'b1;
    assign s_axi_rresp   = 2'b00;
    assign s_axi_rvalid  = s_axi_arvalid;

    /* Read logic */
    always @(*) begin
        case (s_axi_araddr)
            4'h0: s_axi_rdata = {8'd0, pixel_reg_internal}; // PIXEL_REG
            default: s_axi_rdata = 32'd0;
        endcase
    end

    /* ========================================================
       Capture pixel result into AXI-visible register
       (register semantics guaranteed)
    ======================================================== */
    reg [23:0] pixel_reg_axi;

    always @(posedge s_axi_aclk) begin
        if (!s_axi_aresetn)
            pixel_reg_axi <= 24'd0;
        else if (done_wire)
            pixel_reg_axi <= pixel_reg_internal;
    end

    assign pixel_reg_internal = pixel_reg_axi;

endmodule
