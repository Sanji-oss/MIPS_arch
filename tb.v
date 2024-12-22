module TB;
    // Clock and counter declarations
    reg clk;
    integer i;

    // Instantiate the pipeline processor
    Mypip sc1(clk);

    // Clock generation
    always #3 clk = ~clk;

    initial begin
        // Setup waveform dumping
        $dumpfile("mypip_tb.vcd");
        $dumpvars(0, TB);
        
        // Initialize clock
        clk = 1'b0;
        
        // Setup monitoring format with proper alignment
        $monitor(
            "Time=%5d | PC=%8h | Instr=%8h | ALU=%8h | WB=%8h", 
            $time,
            sc1.PC,
            sc1.instrWire,
            sc1.ALUResult,
            sc1.WBData
        );
    
        // Run simulation
        for (i = 0; i < 200; i = i + 1) begin
            if (i > ) begin
                $display("\n=== Simulation Summary ===");
                $display("Total cycles executed: %d", i);
                $display("Final time: %t", $time);
                $display("=====================");
                $finish;
            end
            #6; // Wait for both clock edges
        end
    end

endmodule