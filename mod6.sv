module counter(input clk, reset,dir,output reg[2:0]q); 
always@(posedge clk) 
begin 
if(reset==1'b1) 
q<=3'b000; 
else 
begin 
if(dir) 
begin 
if(q==3'd5) 
q<=3'd0; 
else 
q<=q+1; 
end 
else 
begin 
if(q==3'd0) 
q<=3'd5; 
else 
q<=q-1; 
end 
end 
end 
endmodule

interface c_inter(input bit clk); 
logic reset,dir; 
logic[2:0]q; 
/*clocking cb@(posedge clk); 
default input #1ns output #3ns; 
input q; 
output dir,reset; 
endclocking 
modport test1(clocking cb);*/ 
modport test1(input q,output clk,reset,dir); 
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
