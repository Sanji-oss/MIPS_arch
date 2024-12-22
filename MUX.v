//-----------------------------------------------------------------------------
// Module: mux2
// Description: 32-bit 2-to-1 multiplexer
//-----------------------------------------------------------------------------
module mux2(
    input  wire        select,     // Selection control signal
    input  wire [31:0] a,         // Input A (selected when select = 0)
    input  wire [31:0] b,         // Input B (selected when select = 1)
    output reg  [31:0] y          // Output
);

    // Combinational logic for multiplexing
    always @(select, a, b) begin
        case(select)
            1'b0: y = a;          // Select input a
            1'b1: y = b;          // Select input b
        endcase
    end

endmodule

//-----------------------------------------------------------------------------
// Module: mux2A
// Description: 5-bit 2-to-1 multiplexer (typically used for register addresses)
//-----------------------------------------------------------------------------
module mux2A(
    input  wire       select,      // Selection control signal
    input  wire [4:0] a,          // Input A (selected when select = 0)
    input  wire [4:0] b,          // Input B (selected when select = 1)
    output reg  [4:0] y           // Output
);

    // Combinational logic for multiplexing
    always @(select, a, b) begin
        case(select)
            1'b0: y = a;          // Select input a
            1'b1: y = b;          // Select input b
        endcase
    end

endmodule