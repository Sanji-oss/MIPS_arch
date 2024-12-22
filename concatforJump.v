//-----------------------------------------------------------------------------
// Module: concatForJump
// Description: Concatenates PC upper bits with jump address for MIPS jump instruction
//-----------------------------------------------------------------------------
module concatForJump(
    input  wire [3:0]  part1,    // Upper 4 bits from PC [31:28]
    input  wire [27:0] part2,    // Lower 28 bits (shifted jump target)
    output reg  [31:0] result    // Final 32-bit jump target address
);

    // Concatenate PC upper bits with jump target address
    always @(part1, part2) begin
        result = {part1, part2}; // Combine to form complete jump address
    end

endmodule
