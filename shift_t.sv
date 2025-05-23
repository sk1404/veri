module test(shift_inter.TB t1);
driver d;
initial begin
#15 t1.reset<=1;
#10 t1.reset<=0;
#50 t1.reset<=1;
#100 t1.reset<=0;
end
initial begin
d=new(t1);
repeat(100)@(t1.cb)
d.drive_data();
end
endmodule
