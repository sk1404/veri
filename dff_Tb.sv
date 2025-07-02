module testbench;

    logic clk;
    logic reset_n;
    logic d;
    logic q;

    // Instantiate the D flip-flop
    d_ff dut (
        .clk(clk),
        .reset_n(reset_n),
        .d(d),
        .q(q)
    );

    // Clock generation: 10ns period
    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize signals
        reset_n = 0; d = 0;

        #15;    // After 15 ns, release reset
        reset_n = 1;

        // Test sequence
        #10 d = 1;  // d=1 at 25 ns
        #10 d = 0;  // d=0 at 35 ns
        #10 d = 1;  // d=1 at 45 ns
        #20 d = 0;  // d=0 at 65 ns

        #20 $finish;
    end

    // Monitor signals
    initial begin
        $display("Time\tclk reset_n d q");
        $monitor("%0t\t%b   %b      %b %b", $time, clk, reset_n, d, q);
    end

endmodule
