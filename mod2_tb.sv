module testb1(); 
logic clk,T,reset,set,q;
t_ff dut(clk,T,reset,set,q);
initial 
begin 
clk=0;reset=0;set=0;T=0;
#10 reset=1;set=0;T=0; 
#10 reset=1;set=0;T=1; 
#10 reset=0;set=1;T=0; 
#10 reset=0;set=0;T=1; 
#100 $finish; 
end 
always #5 clk=~clk;
endmodule
