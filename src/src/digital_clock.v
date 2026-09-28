// ============================================================
// FPGA Digital Clock
// Module: Digital Clock
// Description: 24-hour digital clock using BCD counters
// ============================================================

module digital_clock #(
    parameter CLK_FREQ = 50_000_000
)(
    input  wire       clk,
    input  wire       reset,

    output wire [3:0] sec_ones,
    output wire [3:0] sec_tens,

    output wire [3:0] min_ones,
    output wire [3:0] min_tens,

    output reg  [3:0] hour_ones,
    output reg  [3:0] hour_tens
);

    wire one_hz_clk;

    wire sec_carry;
    wire min_carry;

    // --------------------------------------------------------
    // Clock Divider
    // --------------------------------------------------------

    clock_divider #(
        .CLK_FREQ(CLK_FREQ)
    ) divider (
        .clk(clk),
        .reset(reset),
        .one_hz_clk(one_hz_clk)
    );

    // --------------------------------------------------------
    // Seconds Counter
    // --------------------------------------------------------

    bcd_counter #(
        .MAX_COUNT(59)
    ) seconds_counter (
        .clk(one_hz_clk),
        .reset(reset),
        .ones(sec_ones),
        .tens(sec_tens),
        .carry(sec_carry)
    );

    // --------------------------------------------------------
    // Minutes Counter
    // --------------------------------------------------------

    bcd_counter #(
        .MAX_COUNT(59)
    ) minutes_counter (
        .clk(sec_carry),
        .reset(reset),
        .ones(min_ones),
        .tens(min_tens),
        .carry(min_carry)
    );

    // --------------------------------------------------------
    // Hours Counter - 24 Hour Format
    // --------------------------------------------------------

    always @(posedge min_carry or posedge reset) begin

        if (reset) begin
            hour_ones <= 4'd0;
            hour_tens <= 4'd0;
        end

        else begin

            if ((hour_tens == 4'd2) &&
                (hour_ones == 4'd3)) begin

                hour_tens <= 4'd0;
                hour_ones <= 4'd0;

            end

            else if (hour_ones == 4'd9) begin

                hour_ones <= 4'd0;
                hour_tens <= hour_tens + 1'b1;

            end

            else begin

                hour_ones <= hour_ones + 1'b1;

            end

        end

    end

endmodule
