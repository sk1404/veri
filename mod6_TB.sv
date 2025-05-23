module test(c_inter.test1 t1);
initial begin
t1.dir<=0;
#10 t1.reset<=0;
#10 t1.reset<=1;
#10 t1.reset<=0;
#150 t1.dir<=1;
#10 t1.reset<=0;
#10 t1.reset<=1;
#10 t1.reset<=0;
#150 t1.dir<=0;
#30 t1.reset<=0;
#10 t1.reset<=1;
#10 t1.reset<=0;
#100 $finish;
end 
endmodule
