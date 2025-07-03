module tb_async_counter;
   // Clock generation
   bit clk;
   always #5 clk = ~clk;  // 100 MHz clock (10ns period)
   // Instantiate interface
   counter_if intf(clk);
   // DUT instance
   async_counter_dff dut (
       .clk(intf.clk),
       .rst_n(intf.rst_n),
       .Q(intf.Q)
   );
   // Test sequence
   initial begin
       clk = 0;
       intf.rst_n = 0;
       #20;
       intf.rst_n = 1;
       // Let it run for some cycles
       repeat (10) @(negedge clk);
       $finish;
   end
   // Monitor
   initial begin
       $monitor("Time=%0t | rst_n=%0b | Q=%03b", $time, intf.rst_n, intf.Q);
   end
endmodule
