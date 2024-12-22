module IFID(clock, iIR, iPC, oIR, oPC, enable);
    input clock;
    input [31:0] iIR, iPC;
    input enable;
    output reg [31:0] oIR, oPC;

    initial begin
        oPC = 32'b0;
        oIR = 32'b0;
    end

    always @(posedge clock) begin
        if (enable) begin
            oIR <= iIR;
            oPC <= iPC;
        end
    end
endmodule