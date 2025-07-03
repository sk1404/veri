module d_tb(d_inter.tb1 testbench);
  initial begin
    testbench.reset = 0;
    #10 testbench.reset = 1; testbench.d = 1'b1;
    #10 testbench.d = 1'b0;
    #10 testbench.d = 1'b1;
    #50 testbench.reset = 0;
    #10 testbench.reset = 1; testbench.d = 1'b0;
    #10 testbench.d = 1'b1;
    #10 testbench.d = 1'b0;
    #40 testbench.d = 1'b1;
    #10 testbench.d = 1'b0;
    #20 $finish;
  end
endmodule
