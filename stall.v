/**
 * Stall Unit Module
 * Handles pipeline stalls for data hazard detection and prevention
 * Monitors instruction dependencies across pipeline stages
 */
module stallUnit(
    input            clk,
    input      [4:0] rs, rt,    // Source registers
    input      [5:0] opcode,    // Operation code
    input     [31:0] IRD,       // Instruction Register Decode
    input     [31:0] IREX,      // Instruction Register Execute
    input     [31:0] IRMEM,     // Instruction Register Memory
    input      [4:0] regWB,     // Write-back register
    input            WWBs,       // Write-back signal
    input     [31:0] IRWB,      // Instruction Register Write-back
    output reg       stall      // Stall signal output
);

    // Internal registers for tracking write enables and destination registers
    reg we1, we2, we3;          // Write enable signals for different stages
    reg [4:0] ws1, ws2, ws3;    // Write select registers
    reg res, ret;               // Resource and return flags

    // Initialize control signals
    initial begin
        stall = 1'b1;
        we1 = 1'b0;
        we2 = 1'b0;
        we3 = 1'b0;
        res = 1'b0;
        ret = 1'b0;
    end

    always @(posedge clk) begin
        // Decode stage analysis
        if (IRD != 32'b0) begin
            case (opcode)
                6'b000000: begin  // R-type instructions
                    res = 1'b1;
                    ret = 1'b1;
                end
                6'b100011: begin  // Load word
                    res = 1'b1;
                    ret = 1'b0;
                end
                6'b101011: begin  // Store word
                    res = 1'b1;
                    ret = 1'b1;
                end
                6'b000010: begin  // Jump
                    res = 1'b0;
                    ret = 1'b0;
                end
                6'b000100: begin  // Branch equal
                    res = 1'b1;
                    ret = 1'b1;
                end
                6'b000101: begin  // Branch not equal
                    res = 1'b1;
                    ret = 1'b1;
                end
                default: begin    // I-type instructions
                    res = 1'b1;
                    ret = 1'b0;
                end
            endcase
        end
        else begin
            res = 1'b0;
            ret = 1'b0;
        end

        // Execute stage dependency checking
        if (IREX != 32'b0) begin
            case (IREX[31:26])
                6'b000000: begin  // R-type
                    we1 = 1'b1;
                    ws1 = IREX[15:11];
                end
                6'b100011: begin  // Load word
                    we1 = 1'b1;
                    ws1 = IREX[20:16];
                end
                6'b101011: begin  // Store word
                    we1 = 1'b0;
                    ws1 = 5'b0;
                end
                6'b000010: begin  // Jump
                    we1 = 1'b0;
                    ws1 = 5'b0;
                end
                6'b000100: begin  // Branch equal
                    we1 = 1'b0;
                    ws1 = 5'b0;
                end
                6'b000101: begin  // Branch not equal
                    we1 = 1'b0;
                    ws1 = 5'b0;
                end
                default: begin    // I-type instructions
                    we1 = 1'b1;
                    ws1 = IREX[20:16];
                end
            endcase
        end
        else begin
            we1 = 1'b0;
        end

        // Memory stage dependency checking
        if (IRMEM != 32'b0) begin
            case (IRMEM[31:26])
                6'b000000: begin  // R-type
                    we2 = 1'b1;
                    ws2 = IREX[15:11];
                end
                6'b100011: begin  // Load word
                    we2 = 1'b1;
                    ws2 = IREX[20:16];
                end
                6'b101011: begin  // Store word
                    we2 = 1'b0;
                    ws2 = 5'b0;
                end
                6'b000010: begin  // Jump
                    we2 = 1'b0;
                    ws2 = 5'b0;
                end
                6'b000100: begin  // Branch equal
                    we2 = 1'b0;
                    ws2 = 5'b0;
                end
                6'b000101: begin  // Branch not equal
                    we2 = 1'b0;
                    ws2 = 5'b0;
                end
                default: begin    // I-type instructions
                    we2 = 1'b1;
                    ws2 = IREX[20:16];
                end
            endcase
        end
        else begin
            we2 = 1'b0;
        end

        // Write-back stage dependency checking
        if (IRWB != 32'b0) begin
            we3 = WWBs;
            ws3 = regWB;
        end
        else begin
            we3 = 1'b0;
        end

        // Generate stall signal based on dependencies
        stall = ~((((rs == ws1) & we1) + ((rs == ws2) & we2) + ((rs == ws3) & we3)) & res + 
                 (((rt == ws1) & we1) + ((rt == ws2) & we2) + ((rt == ws3) & we3)) & ret);
    end

endmodule
