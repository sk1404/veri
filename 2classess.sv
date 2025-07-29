class A;  
virtual task disp();  
$display("This is class A");  
endtask  
task disp1();  
$display("This class A,again!!!!");  
endtask  
endclass  
class EA extends A;  
task disp();  
$display("This is extended class A");  
endtask  
task disp1();  
$display("This is extended class A, again!!");  
endtask  
endclass  
program main;  
EA my_ea;  
A my_a;  
initial begin  
my_a=new();  
my_a.disp();  
my_ea=new();  
my_a=my_ea;  
my_a.disp();  
my_a.disp1();  
end  
endprogram 
