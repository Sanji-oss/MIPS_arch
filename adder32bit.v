//-----------------------------------------------------------------------------
// Module: adder32bit
// Description: 32-bit binary adder for MIPS pipeline
//-----------------------------------------------------------------------------
module adder32bit(
    input  wire [31:0] in1,      // First input operand
    input  wire [31:0] in2,      // Second input operand
    output reg  [31:0] out       // Sum output
);

    // Combinational logic for addition
    always @(in1, in2) begin
        out = in1 + in2;         // Perform binary addition
    end

endmodule
