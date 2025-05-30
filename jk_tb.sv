module jk_tb(jk_inter.tb1 testbench);
initial begin
testbench.reset=0;
#10 testbench.reset=1'b1; testbench.jk=2'b10; 
#10 testbench.jk=2'b01; 
#10 testbench.jk=2'b11; 
#50 testbench.reset=0;
#10 testbench.reset=1'b1; testbench.jk=2'b10; 
#10 testbench.jk=2'b00;
#10 testbench.jk=2'b11;
#40 testbench.jk=2'b1x;
#10 testbench.jk=2'b10;
#20 $finish;
end
endmodule
