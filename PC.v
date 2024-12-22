/**
 * Program Counter Register Module
 * Stores and updates the current program counter value
 * Controls instruction fetch address based on enable signal
 */
module PCRegWrite(
    input             clock,    // Clock signal
    input      [31:0] in,      // Next PC value
    input             enable,   // Enable signal for PC update
    output reg [31:0] out      // Current PC value
);

    // Initialize PC to 0
    initial begin
        out = 32'b0;
    end

    // Update PC on clock edge if enabled
    always @(posedge clock) begin
        if (enable == 1'b1) begin
            out = in;
        end
    end
endmodule
