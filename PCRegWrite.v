//-----------------------------------------------------------------------------
// Module: PCRegWrite
// Description: Program Counter Register with write enable control
//-----------------------------------------------------------------------------
module PCRegWrite(
    input  wire        clk,      // Clock input
    input  wire [31:0] nextPC,   // Next program counter value
    output reg  [31:0] PC,       // Current program counter value
    input  wire        enable    // Write enable signal (active high)
);

    // Initialize program counter
    initial begin
        PC = 32'b0;             // Reset PC to address zero
    end

    // Update PC on clock edge when enabled
    always @(posedge clk) begin
        if (enable) begin       // Only update when enable is high
            PC <= nextPC;       // Load next instruction address
        end
        // When enable is low, PC maintains its current value
    end

endmodule
