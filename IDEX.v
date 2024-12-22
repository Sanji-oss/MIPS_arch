/**
 * ID/EX Pipeline Register Module
 * Handles the pipeline register between Instruction Decode and Execute stages
 * Stores control signals and data for the next pipeline stage
 */
module IDEX(
    // Clock and enable
    input             clock,
    input             enable,
    
    // Control signals (inputs)
    input             iRegDests,
    input             iRegWrite,
    input             iALUSrc,
    input             iMemRead,
    input             iMemWrite,
    input             iMemToReg,
    input             iBranchs,
    input             iJumps,
    input      [3:0]  iALUCtrl,
    
    // Data inputs
    input      [31:0] iIR,      // Instruction Register
    input      [31:0] iPC,      // Program Counter
    input      [31:0] iA,       // Register A value
    input      [31:0] iB,       // Register B value
    input      [4:0]  iRegDest, // Destination register
    input      [31:0] iBranch,  // Branch target
    input      [31:0] iJump,    // Jump target
    
    // Control signals (outputs)
    output reg        oRegDests,
    output reg        oRegWrite,
    output reg        oALUSrc,
    output reg        oMemRead,
    output reg        oMemWrite,
    output reg        oMemToReg,
    output reg        oBranchs,
    output reg        oJumps,
    output reg [3:0]  oALUCtrl,
    
    // Data outputs
    output reg [31:0] oIR,
    output reg [31:0] oPC,
    output reg [31:0] oA,
    output reg [31:32] oB,
    output reg [4:0]  oRegDest,
    output reg [31:0] oBranch,
    output reg [31:0] oJump
);

    // Additional internal registers
    reg        oZero;
    reg [31:0] oResult;

    // Initialize critical registers
    initial begin
        oPC = 32'b0;
        oIR = 32'b0;
    end

    // Update registers on clock edge when enabled
    always @(posedge clock) begin
        if (enable) begin
            // Control signals
            oRegDests <= iRegDests;
            oRegWrite <= iRegWrite;
            oALUSrc   <= iALUSrc;
            oMemRead  <= iMemRead;
            oMemWrite <= iMemWrite;
            oMemToReg <= iMemToReg;
            oBranchs  <= iBranchs;
            oJumps    <= iJumps;
            oALUCtrl  <= iALUCtrl;
            
            // Data values
            oIR      <= iIR;
            oPC      <= iPC;
            oA       <= iA;
            oB       <= iB;
            oRegDest <= iRegDest;
            oBranch  <= iBranch;
            oJump    <= iJump;
        end
    end

endmodule

