/**
 * Control Unit Module
 * Generates control signals for the MIPS processor pipeline
 * Decodes instructions and sets appropriate control lines
 */
module controlUnit(
    input             clk,
    input      [5:0]  opcode,
    input      [5:0]  funct,
    input      [31:0] IR,
    output reg [2:0]  ALUOp,
    output reg        RegDest,
    output reg        RegWrite,
    output reg        ALUSrc,
    output reg        MemRead,
    output reg        MemWrite,
    output reg        MemToReg,
    output reg        Branch,
    output reg        Jump
);

    // Instruction opcodes
    parameter RTYPE = 6'b000000;  // R-type instructions
    parameter BEQ   = 6'b000100;  // Branch if equal
    parameter BNE   = 6'b000101;  // Branch if not equal
    parameter SW    = 6'b101011;  // Store word
    parameter LW    = 6'b100011;  // Load word
    parameter ADDI  = 6'b001000;  // Add immediate
    parameter ANDI  = 6'b001100;  // AND immediate
    parameter ORI   = 6'b001101;  // OR immediate
    parameter SLTI  = 6'b001010;  // Set less than immediate
    parameter J     = 6'b000010;  // Jump

    always @(opcode, funct, posedge clk) begin
        if (IR == 32'b0) begin
            // NOP instruction or reset condition
            ALUOp    <= 3'b0;
            RegDest  <= 1'b0;
            RegWrite <= 1'b0;
            ALUSrc   <= 1'b0;
            MemRead  <= 1'b0;
            MemWrite <= 1'b0;
            MemToReg <= 1'b0;
            Branch   <= 1'b0;
            Jump     <= 1'b0;
        end
        else begin
            case (opcode)
                RTYPE: begin  // R-type instructions
                    ALUOp    = 3'b10;    // R-type ALU operation
                    RegDest  = 1'b1;     // Write to rd
                    RegWrite = 1'b1;     // Enable register write
                    ALUSrc   = 1'b0;     // Use register operand
                    MemRead  = 1'b0;     // No memory read
                    MemWrite = 1'b0;     // No memory write
                    MemToReg = 1'b0;     // ALU result to register
                    Branch   = 1'b0;     // No branch
                    Jump     = 1'b0;     // No jump
                end

                LW: begin    // Load word
                    ALUOp    <= 3'b00;   // Addition for address
                    RegDest  <= 1'b0;    // Write to rt
                    RegWrite <= 1'b1;    // Enable register write
                    ALUSrc   <= 1'b1;    // Use immediate
                    MemRead  <= 1'b1;    // Enable memory read
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'b1;    // Memory to register
                    Branch   <= 1'b0;    // No branch
                    Jump     <= 1'b0;    // No jump
                end

                SW: begin    // Store word
                    ALUOp    <= 3'b00;   // Addition for address
                    RegDest  <= 1'bx;    // Don't care
                    RegWrite <= 1'b0;    // Disable register write
                    ALUSrc   <= 1'b1;    // Use immediate
                    MemRead  <= 1'b0;    // No memory read
                    MemWrite <= 1'b1;    // Enable memory write
                    MemToReg <= 1'bx;    // Don't care
                    Branch   <= 1'b0;    // No branch
                    Jump     <= 1'b0;    // No jump
                end

                J: begin    // Jump
                    ALUOp    <= 3'bxxx;  // Don't care
                    RegDest  <= 1'bx;    // Don't care
                    RegWrite <= 1'b0;    // Disable register write
                    ALUSrc   <= 1'bx;    // Don't care
                    MemRead  <= 1'bx;    // Don't care
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'bx;    // Don't care
                    Branch   <= 1'bx;    // Don't care
                    Jump     <= 1'b1;    // Enable jump
                end

                BEQ: begin  // Branch if equal
                    ALUOp    <= 3'b01;   // Subtraction for comparison
                    RegDest  <= 1'bx;    // Don't care
                    RegWrite <= 1'b0;    // Disable register write
                    ALUSrc   <= 1'b0;    // Use register operand
                    MemRead  <= 1'b0;    // No memory read
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'bx;    // Don't care
                    Branch   <= 1'b1;    // Enable branch
                    Jump     <= 1'b0;    // No jump
                end

                BNE: begin  // Branch if not equal
                    ALUOp    <= 3'b01;   // Subtraction for comparison
                    RegDest  <= 1'bx;    // Don't care
                    RegWrite <= 1'b0;    // Disable register write
                    ALUSrc   <= 1'b0;    // Use register operand
                    MemRead  <= 1'b0;    // No memory read
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'bx;    // Don't care
                    Branch   <= 1'b1;    // Enable branch
                    Jump     <= 1'b0;    // No jump
                end

                ADDI: begin  // Add immediate
                    ALUOp    <= 3'b000;  // Addition
                    RegDest  <= 1'b0;    // Write to rt
                    RegWrite <= 1'b1;    // Enable register write
                    ALUSrc   <= 1'b1;    // Use immediate
                    MemRead  <= 1'b0;    // No memory read
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'b0;    // ALU result to register
                    Branch   <= 1'b0;    // No branch
                    Jump     <= 1'b0;    // No jump
                end

                SLTI: begin  // Set less than immediate
                    ALUOp    <= 3'b111;  // Set less than
                    RegDest  <= 1'b0;    // Write to rt
                    RegWrite <= 1'b1;    // Enable register write
                    ALUSrc   <= 1'b1;    // Use immediate
                    MemRead  <= 1'b0;    // No memory read
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'b0;    // ALU result to register
                    Branch   <= 1'b0;    // No branch
                    Jump     <= 1'b0;    // No jump
                end

                ANDI: begin  // AND immediate
                    ALUOp    <= 3'b011;  // AND operation
                    RegDest  <= 1'b0;    // Write to rt
                    RegWrite <= 1'b1;    // Enable register write
                    ALUSrc   <= 1'b1;    // Use immediate
                    MemRead  <= 1'b0;    // No memory read
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'b0;    // ALU result to register
                    Branch   <= 1'b0;    // No branch
                    Jump     <= 1'b0;    // No jump
                end

                ORI: begin  // OR immediate
                    ALUOp    <= 3'b100;  // OR operation
                    RegDest  <= 1'b0;    // Write to rt
                    RegWrite <= 1'b1;    // Enable register write
                    ALUSrc   <= 1'b1;    // Use immediate
                    MemRead  <= 1'b0;    // No memory read
                    MemWrite <= 1'b0;    // No memory write
                    MemToReg <= 1'b0;    // ALU result to register
                    Branch   <= 1'b0;    // No branch
                    Jump     <= 1'b0;    // No jump
                end

                // if you want to add new instructions add here
            endcase
        end
    end

endmodule






