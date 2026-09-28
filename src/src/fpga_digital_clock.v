// ============================================================
// FPGA Digital Clock
// Module: FPGA Top Module
// Description: Top-level module for 24-hour digital clock
//
// Display:
//   HEX5 HEX4 : Hours
//   HEX3 HEX2 : Minutes
//   HEX1 HEX0 : Seconds
//
// Example:
//   12:34:56
//
// ============================================================

module fpga_digital_clock #(
    parameter CLK_FREQ = 50_000_000
)(
    input  wire       clk,
    input  wire       reset,

    output wire [6:0] HEX0,
    output wire [6:0] HEX1,
    output wire [6:0] HEX2,
    output wire [6:0] HEX3,
    output wire [6:0] HEX4,
    output wire [6:0] HEX5
);

    // --------------------------------------------------------
    // Clock signals
    // --------------------------------------------------------

    wire [3:0] sec_ones;
    wire [3:0] sec_tens;

    wire [3:0] min_ones;
    wire [3:0] min_tens;

    wire [3:0] hour_ones;
    wire [3:0] hour_tens;


    // --------------------------------------------------------
    // Digital Clock
    // --------------------------------------------------------

    digital_clock #(
        .CLK_FREQ(CLK_FREQ)
    ) clock_unit (

        .clk(clk),
        .reset(reset),

        .sec_ones(sec_ones),
        .sec_tens(sec_tens),

        .min_ones(min_ones),
        .min_tens(min_tens),

        .hour_ones(hour_ones),
        .hour_tens(hour_tens)
    );


    // --------------------------------------------------------
    // Seconds - HEX0 and HEX1
    // --------------------------------------------------------

    seven_segment display_sec_ones (
        .bcd(sec_ones),
        .seg(HEX0)
    );

    seven_segment display_sec_tens (
        .bcd(sec_tens),
        .seg(HEX1)
    );


    // --------------------------------------------------------
    // Minutes - HEX2 and HEX3
    // --------------------------------------------------------

    seven_segment display_min_ones (
        .bcd(min_ones),
        .seg(HEX2)
    );

    seven_segment display_min_tens (
        .bcd(min_tens),
        .seg(HEX3)
    );


    // --------------------------------------------------------
    // Hours - HEX4 and HEX5
    // --------------------------------------------------------

    seven_segment display_hour_ones (
        .bcd(hour_ones),
        .seg(HEX4)
    );

    seven_segment display_hour_tens (
        .bcd(hour_tens),
        .seg(HEX5)
    );

endmodule
