// ============================================================
// FPGA Digital Clock
// Module: Seven Segment Display Driver
// Description: Converts a 4-bit BCD value to 7-segment signals
//
// Segment order:
//        a
//       ---
//    f |   | b
//       -g-
//    e |   | c
//       ---
//        d
//
// seg[6:0] = {a,b,c,d,e,f,g}
// Active LOW outputs are used.
// ============================================================

module seven_segment (
    input  wire [3:0] bcd,
    output reg  [6:0] seg
);

    always @(*) begin

        case (bcd)

            4'd0: seg = 7'b0000001;
            4'd1: seg = 7'b1001111;
            4'd2: seg = 7'b0010010;
            4'd3: seg = 7'b0000110;
            4'd4: seg = 7'b1001100;
            4'd5: seg = 7'b0100100;
            4'd6: seg = 7'b0100000;
            4'd7: seg = 7'b0001111;
            4'd8: seg = 7'b0000000;
            4'd9: seg = 7'b0000100;

            default: seg = 7'b1111111;

        endcase

    end

endmodule
