/**
 * EX/MEM Pipeline Register Module
 * Handles the pipeline register between Execute and Memory stages
 * Stores control signals and computation results for the memory stage
 */
module EXMEM(
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
    input      [31:32] iB,       // Register B value
    input      [31:0] iResult,  // ALU Result
    input      [4:0]  iRegDest, // Destination register
    input      [31:0] iBranch,  // Branch target
    input      [31:0] iJump,    // Jump target
    input             iZero,    // Zero flag from ALU
    
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
    output reg [31:0] oB,
    output reg [31:0] oResult,
    output reg [4:0]  oRegDest,
    output reg [31:0] oBranch,
    output reg [31:0] oJump,
    output reg        oZero
);

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
            oB       <= iB;
            oResult  <= iResult;
            oRegDest <= iRegDest;
            oBranch  <= iBranch;
            oJump    <= iJump;
            oZero    <= iZero;
        end
    end

endmodule


