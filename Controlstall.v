//-----------------------------------------------------------------------------
// Module: Controlstall
// Description: Controls stalling logic for pipeline based on operation codes
//-----------------------------------------------------------------------------
module Controlstall(
    input clk,                    // Clock input
    input [5:0] op1,             // Operation code from stage 1
    input [5:0] op2,             // Operation code from stage 2
    input [5:0] op3,             // Operation code from stage 3
    output reg stall             // Stall signal output
);

    // Initialize stall signal
    initial begin
        stall = 1'b1;
    end

    // Stall control logic
    always @(posedge clk) begin
        // Check for branch or jump instructions in any stage
        // op codes: beq(000100), bne(000101), j(000010)
        if (op1 == 6'b000100 || op1 == 6'b000101 || op1 == 6'b000010) begin
            stall = 1'b0;
        end
        else if (op2 == 6'b000100 || op2 == 6'b000101 || op2 == 6'b000010) begin
            stall = 1'b0;
        end
        else if (op3 == 6'b000100 || op3 == 6'b000101 || op3 == 6'b000010) begin
            stall = 1'b0;
        end
        else begin
            stall = 1'b1;
        end
    end

endmodule

//-----------------------------------------------------------------------------
// Module: nopSet
// Description: Handles NOP insertion based on stall signals
//-----------------------------------------------------------------------------
module nopSet(
    input clk,                    // Clock input
    input s1,                     // Stall signal 1
    input s2,                     // Stall signal 2
    input [31:0] oldF,           // Original Fetch stage instruction
    input [31:0] oldD,           // Original Decode stage instruction
    output reg [31:0] newF,      // Modified Fetch stage instruction
    output reg [31:0] newD       // Modified Decode stage instruction
);

    // NOP insertion logic
    always @(posedge clk) begin
        case ({s1, s2})
            2'b00: begin         // Both stages stalled
                newF = 32'b0;    // Insert NOP
                newD = 32'b0;    // Insert NOP
            end
            2'b01: begin         // Only second stage stalled
                newD = 32'b0;    // Insert NOP in Decode
            end
            2'b10: begin         // Only first stage stalled
                newF = 32'b0;    // Insert NOP in Fetch
            end
            2'b11: begin         // No stall
                newD = oldD;     // Pass through original instructions
                newF = oldF;
            end
        endcase
    end

endmodule
