module d_ff(d_inter.design1 dut);
  always @(posedge dut.clk or posedge dut.reset) begin
    if (dut.reset)
      dut.q <= 1'b0;
    else
      dut.q <= dut.d;
     //if (0) begin logic dummy = 1; end // reduces line & branch coverage //for reducing coverage all remove command(//)
  end
endmodule
 
interface d_inter(input bit clk);
  logic d;
  logic reset, q;
  modport design1(input d, reset, clk, output q);
  modport tb1(input q, output d, reset, clk);
endinterface
 
 
module top();
  bit clk;
  d_inter i1(clk);
 
  d_ff d1(i1);
  d_tb t1(i1);
 
  always #5 clk = ~clk;
 
  initial begin
    $dumpfile("d_ff.vcd");
    $dumpvars;
  end
endmodule
