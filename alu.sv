module ALU(input clk, reset, input [3:0] a,b , input [2:0] opcode, output reg [7:0] c); 
always@(posedge clk, posedge reset) 
begin 
if(reset) 
c<=8'd0; 
else 
case(opcode) 
3'd0: c<=a+b; 
3'd1: c<=a-b; 
3'd2: c<=a*b; 
3'd3: begin if (b!=0) c<=a/b; else c<=8'dx; end 
3'd4: c<=a&b; 
3'd5: c<=a|b; 
3'd6: c<=a^b; 
3'd7: c<=~a; 
default: c<=8'dx; 
endcase 
end 
endmodule 

interface ALU_inter(input bit clk); 
logic reset; 
logic [3:0] a,b; 
logic [2:0] opcode; 
logic [7:0] c; 
clocking cb@(posedge clk); 
default input #2ns output #3ns; 
output a, b, opcode; 
endclocking 
modport TB(clocking cb, output reset); 
property p1; 
@(posedge clk) (reset == 1) |-> (c == 0); 
endproperty:p1 
a1:assert property (p1)$display("c= 0 ,P1 passed"); 
else $display("P1 failed"); 
property p2; 
@(posedge clk) (opcode == 0) |-> (c == a+b); 
endproperty:p2 
a2:assert property (p2)$display("c = a+b ,P2 passed"); 
else $display("P2 failed"); 
endinterface 


class transactor; 
rand bit [3:0] a,b; 
rand bit [2:0] opcode; 
constraint C1 {opcode inside {[0:5],7};} 
constraint C2 {a inside {[1:10],15};} 
constraint C3 {b>0;b<14;} 
endclass 

class driver; 
transactor tx; 
virtual ALU_inter.TB i1; 
function new(virtual ALU_inter.TB i1_new); 
this.i1=i1_new; 
this.tx=new(); 
$display ("%d : Driver: new method created", $time); 
endfunction 
task drive_data(); 
begin 
repeat(20) @( i1.cb) 
begin 
if((tx.randomize())) 
begin 
i1.cb.a<=tx.a; 
i1.cb.b<=tx.b; 
i1.cb.opcode<=tx.opcode; 
$display("%d : driver: sent A=%b, B=%b and opcode=%b", 
$time, i1.cb.a,i1.cb.b,i1.cb.opcode); 
end 
else 
$display("%d : Randomization error", $time); 
end 
end 
endtask 
endclass 

module top; 
bit clk; 
ALU_inter i1(clk); 
ALU Dut(.clk(clk), .reset(i1.reset), .a(i1.a), .b(i1.b), .c(i1.c), .opcode(i1.opcode)); 
test T1(i1); 
always #5 clk=~clk; 
initial 
begin 
$dumpfile("top.vcd"); 
$dumpvars; 
$monitor("time=%d, clk=%b, reset=%b, a=%b,b=%b,opcode=%b, c=%b", $time, 
clk,i1.reset,i1.a,i1.b,i1.opcode, i1.c); 
#500;
$finish; 
end 
endmodule

