/**
 * ALU Control Module
 * Generates control signals for the ALU based on function code and ALU operation
 * Decodes R-type instructions and implements immediate operations
 */
module ALUcontrol(
    input            clk,      // Clock signal
    input      [5:0] funct,    // Function code for R-type instructions
    input      [2:0] ALUOp,    // Operation code from main control
    output reg [3:0] ALUsignal // Control signal for ALU
);

    // ALU Control Signal Encoding
    localparam ALU_ADD  = 4'b0000;  // Addition
    localparam ALU_SUB  = 4'b0001;  // Subtraction
    localparam ALU_AND  = 4'b0010;  // Logical AND
    localparam ALU_OR   = 4'b0011;  // Logical OR
    localparam ALU_SLT  = 4'b0101;  // Set Less Than
    localparam ALU_SRL  = 4'b1010;  // Shift Right Logical

    always @(funct, ALUOp, posedge clk) begin 
        case (ALUOp)
            3'b010: begin  // R-type instructions
                case (funct)
                    6'b100000: ALUsignal = ALU_ADD;  // add
                    6'b100010: ALUsignal = ALU_SUB;  // sub
                    6'b100100: ALUsignal = ALU_AND;  // and
                    6'b100101: ALUsignal = ALU_OR;   // or
                    6'b101010: ALUsignal = ALU_SLT;  // slt
                    6'b000010: ALUsignal = ALU_SRL;  // srl
                    default:   ALUsignal = ALU_ADD;  // default to add
                endcase
            end
            
            // Immediate and memory operations
            3'b001: ALUsignal = ALU_SUB;  // branch: subtract for comparison
            3'b000: ALUsignal = ALU_ADD;  // lw/sw: address calculation
            3'b011: ALUsignal = ALU_AND;  // andi
            3'b100: ALUsignal = ALU_OR;   // ori
            3'b111: ALUsignal = ALU_SLT;  // slti
            
            default: ALUsignal = ALU_ADD;  // default operation
        endcase
    end

endmodule
