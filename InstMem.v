module IMemBank(input memread, input [31:0] address, output reg [31:0] readdata);

  reg [31:0] mem_array [255:0];
  reg [31:0] temp;
  integer i;

  initial begin
    for (i = 11; i < 255; i = i + 1) begin
      mem_array[i] = 32'b0;
    end
  end

  always @(memread, address, mem_array[address]) begin
    if (memread) begin
      temp = address >> 2;
      readdata = mem_array[temp];
    end

    // Test bench instructions
    mem_array[0] = {6'b001000, 5'b10, 5'b1000, 16'b1010}; // addi r8, r2, 10 = 30
    mem_array[1] = {6'b001010, 5'b10, 5'b1001, 16'b1010}; // slti r9, r2, 10 = 0
    mem_array[2] = {6'b001101, 5'b10, 5'b1010, 16'b1010}; // ori r10, r2, 10 = 30
    mem_array[3] = {6'b001100, 5'b10, 5'b1011, 16'b1010}; // andi r11, r2, 10 = 0
  end

endmodule