/**
 * Sign Extension module
 * Extends a 16-bit input to 32-bit by replicating the sign bit (MSB)
 * Used for immediate values in MIPS instructions
 */
module signExt(
    input  [15:0] inData,     // 16-bit input data
    output reg [31:0] outData // 32-bit sign-extended output
);

    always @(inData) begin
        // Copy lower 16 bits directly
        outData[15:0] = inData[15:0];
        // Replicate the sign bit (MSB) to upper 16 bits
        outData[31:16] = {16{inData[15]}};
    end

endmodule
