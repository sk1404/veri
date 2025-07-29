class A;  
int a,b,c;  
function new(int a,b);  
this.a=a;  
this.b=b;  
endfunction  
virtual task op();  
c=a^b;  
$display("Class A: with %d and %d, c is %d",a,b,c);  
endtask  
endclass  
class EA extends A;  
function new(int a,b);  
super.new(a,b);  
endfunction  
task op();  

c=a+b;  
$display("Extended class A: with %d and %d, c is %d",a,b,c);  
endtask  
endclass  
program main;  
A my_a;  
EA my_ea;  
initial begin  
my_a=new(2,3);  
my_a.op();  
my_ea=new(8,9);  
my_ea.op();  
my_a=my_ea;  
my_a.op();  
end  
endprogram 
