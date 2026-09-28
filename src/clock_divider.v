// ============================================================
// FPGA Digital Clock
// Module: Clock Divider
// Description: Converts the FPGA clock into a 1 Hz clock
// ============================================================

module clock_divider #(
    parameter CLK_FREQ = 50_000_000
)(
    input  wire clk,
    input  wire reset,
    output reg  one_hz_clk
);

    localparam HALF_COUNT = CLK_FREQ / 2;

    reg [31:0] count;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            count      <= 32'd0;
            one_hz_clk <= 1'b0;
        end
        else begin
            if (count == HALF_COUNT - 1) begin
                count      <= 32'd0;
                one_hz_clk <= ~one_hz_clk;
            end
            else begin
                count <= count + 1'b1;
            end
        end
    end

endmodule
