module counter(input clk,reset,dir,output reg[3:0]q);
always@(posedge clk)
begin
if(reset==1'b1)
q<=4'b0000;
else
begin
if(dir)
begin
if(q==4'd9)
q<=4'b0000;
else
q<=q+1;
end
else
begin
if(q==4'd0)
q<=4'd9;
else
q<=q-1;
end
end
end
endmodule

interface c_inter(input bit clk);
logic reset,dir;
logic [3:0]q;
/*default input #1ns output #3ns;
input q;
output dir,reset;
modport test(clocking cb);*/
modport test1(input q ,output clk,reset,dir);
endinterface

module top();
bit clk;
always #5 clk=~clk;
c_inter i1(clk);
test tb2(i1);
counter dut(.clk(clk),.reset(i1.reset),.dir(i1.dir),.q(i1.q));
initial begin
$dumpfile("counter1.vcd");
$dumpvars;
end
endmodule
