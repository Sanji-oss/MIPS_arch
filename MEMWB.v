//-----------------------------------------------------------------------------
// Module: MEMWB (Memory/WriteBack Pipeline Register)
// Description: Pipeline register between Memory and WriteBack stages
//-----------------------------------------------------------------------------
module MEMWB(
    // Clock and control
    input  wire        clock,
    input  wire        enable,
    
    // Control signals - inputs
    input  wire        iRegDests,      // Register destination select
    input  wire        iRegWrite,      // Register write enable
    input  wire        iALUSrc,        // ALU source select
    input  wire        iMemRead,       // Memory read enable
    input  wire        iMemWrite,      // Memory write enable
    input  wire        iMemToReg,      // Memory to register select
    input  wire        iBranchs,       // Branch control
    input  wire        iJumps,         // Jump control
    input  wire [3:0]  iALUCtrl,       // ALU control signals
    
    // Data inputs
    input  wire [31:0] iIR,            // Instruction register
    input  wire [31:0] iB,             // B operand
    input  wire [31:0] iResult,        // ALU result
    input  wire [4:0]  iRegDest,       // Destination register
    
    // Control signals - outputs
    output reg         oRegDests,
    output reg         oRegWrite,
    output reg         oALUSrc,
    output reg         oMemRead,
    output reg         oMemWrite,
    output reg         oMemToReg,
    output reg         oBranchs,
    output reg         oJumps,
    output reg  [3:0]  oALUCtrl,
    
    // Data outputs
    output reg  [31:0] oIR,
    output reg  [31:0] oB,
    output reg  [31:0] oResult,
    output reg  [4:0]  oRegDest
);

    // Initialize registers
    initial begin
        oIR = 32'b0;            // Clear instruction register on reset
    end

    // Register transfer on clock edge
    always @(posedge clock) begin
        if (enable) begin       // Transfer only when enabled
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
            
            // Data signals
            oIR      <= iIR;
            oB       <= iB;
            oResult  <= iResult;
            oRegDest <= iRegDest;
        end
    end

endmodule

