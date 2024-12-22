/**
 * Register File Module
 * Contains 32 general-purpose registers for MIPS processor
 * Supports two simultaneous reads and one write operation
 * Register 0 is hardwired to value 0
 */
module RegFile(
    input            clk,
    input      [4:0] readreg1,  // First register to read
    input      [4:0] readreg2,  // Second register to read
    input      [4:0] writereg,  // Register to write
    input     [31:0] writedata, // Data to write
    input            RegWrite,  // Write enable signal
    output    [31:0] readdata1, // First read data
    output    [31:0] readdata2  // Second read data
);

    // Register file storage
    reg [31:0] regfile [31:0];
    integer i;

    // Initialize registers with test values
    initial begin
        for (i = 1; i < 32; i = i + 1) begin
            regfile[i] = i * 10;
        end
    end

    // Write operation on positive clock edge
    always @(posedge clk) begin
        if (RegWrite) begin
            regfile[writereg] <= writedata;
        end
        // Ensure register 0 always contains 0
        regfile[0] = 32'b0;
    end

    // Asynchronous read operations
    assign readdata1 = regfile[readreg1];
    assign readdata2 = regfile[readreg2];

endmodule

