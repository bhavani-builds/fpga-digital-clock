`timescale 1ns/1ps

// ============================================================
// FPGA Digital Clock
// Testbench: Digital Clock
//
// Purpose:
// Verify:
// 1. Reset operation
// 2. Seconds counting
// 3. Minutes rollover
// 4. Hours rollover
//
// A small CLK_FREQ is used for simulation so that we don't
// have to simulate 50 million clock cycles for one second.
// ============================================================

module tb_digital_clock;

    // --------------------------------------------------------
    // Testbench signals
    // --------------------------------------------------------

    reg clk;
    reg reset;

    wire [3:0] sec_ones;
    wire [3:0] sec_tens;

    wire [3:0] min_ones;
    wire [3:0] min_tens;

    wire [3:0] hour_ones;
    wire [3:0] hour_tens;


    // --------------------------------------------------------
    // Instantiate Digital Clock
    //
    // CLK_FREQ = 10 is intentionally small for simulation.
    // --------------------------------------------------------

    digital_clock #(
        .CLK_FREQ(10)
    ) uut (

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
    // Generate clock
    // --------------------------------------------------------

    initial begin
        clk = 1'b0;

        forever #5 clk = ~clk;
    end


    // --------------------------------------------------------
    // Test sequence
    // --------------------------------------------------------

    initial begin

        // Start with reset
        reset = 1'b1;

        #20;

        reset = 1'b0;

        // Run simulation
        #5000;

        $display("======================================");
        $display(" Digital Clock Simulation Completed");
        $display("======================================");

        $finish;

    end


    // --------------------------------------------------------
    // Monitor clock values
    // --------------------------------------------------------

    initial begin

        $monitor(
            "Time=%0t | Clock=%b | Reset=%b | "
            //" HH:MM:SS = "
            "%d%d:%d%d:%d%d",

            $time,
            clk,
            reset,

            hour_tens,
            hour_ones,

            min_tens,
            min_ones,

            sec_tens,
            sec_ones
        );

    end

endmodule
