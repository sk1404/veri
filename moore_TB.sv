module tb_fsm1011(intf_fsm1011 Itb);

  // Initialize the input signals
  initial begin
    // Initialize rst and x to known values
    Itb.rst = 1;  // Reset initially
    Itb.x = 0;     // Initialize x to 0

    // Apply reset and deassert it after some time
    #20 Itb.rst = 0;  // Deassert reset after 20 time units

    // Start applying the test vector for x (input to the FSM)
    #50 Itb.x = 1;
    #50 Itb.x = 1;
    #50 Itb.x = 0;
    #50 Itb.x = 1;
    #50 Itb.x = 1;
    #50 Itb.x = 0;
    #50 Itb.x = 0;
    #50 Itb.x = 0;
    #50 Itb.x = 1;
    #50 Itb.x = 0;
    #50 Itb.x = 1;
    #50 Itb.x = 1;
    #50 Itb.x = 0;
    #50 Itb.x = 1;
    #50 Itb.x = 1;
    #50 Itb.x = 0;
    #50 Itb.x = 1;
    #50 Itb.x = 0;
    #50 Itb.x = 0;
    #50 Itb.x = 1;

    // End the simulation after the last change to `x`
    #10 $stop;
  end

endmodule
