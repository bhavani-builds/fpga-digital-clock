// ============================================================
// FPGA Digital Clock
// Module: BCD Counter
// Description: Generic BCD counter with configurable limit
// ============================================================

module bcd_counter #(
    parameter MAX_COUNT = 59
)(
    input  wire       clk,
    input  wire       reset,
    output reg [3:0]  ones,
    output reg [3:0]  tens,
    output reg        carry
);

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            ones  <= 4'd0;
            tens  <= 4'd0;
            carry <= 1'b0;
        end
        else begin
            carry <= 1'b0;

            if ({tens, ones} == MAX_COUNT) begin
                ones  <= 4'd0;
                tens  <= 4'd0;
                carry <= 1'b1;
            end
            else if (ones == 4'd9) begin
                ones <= 4'd0;
                tens <= tens + 1'b1;
            end
            else begin
                ones <= ones + 1'b1;
            end
        end
    end

endmodule
