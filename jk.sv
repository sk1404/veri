module jk_ff(jk_inter.design1 dut);
always @(posedge dut.clk,posedge dut.reset)
begin
if (!dut.reset)
dut.q<=1'b0;
else
begin
case(dut.jk)
2'b00:dut.q<=dut.q;
2'b01:dut.q<=1'b0;
2'b10:dut.q<=1'b1;
2'b11:dut.q<=~dut.q;
default:dut.q<=1'b0;
endcase
end
end
endmodule

interface jk_inter(input bit clk);
logic [1:0] jk;
logic reset,q;
modport design1(input jk,reset,clk,output q);
modport tb1(input q,output jk,reset,clk);
endinterface

module top();
bit clk;
jk_inter i1(clk);
jk_ff d1(i1);
jk_tb t1(i1);
always #5 clk=~clk;
initial begin
$dumpfile("jk_ff.vcd");
$dumpvars;
end
endmodule
