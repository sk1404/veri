class A;
  int a, b, c, d;

  function new(int a, int b, int c);
    this.a = a;
    this.b = b;
    this.c = c;
  endfunction

  virtual task oper1();
    $display("This is classA");
    d = a + b + c;
    $display("This is classA, oper1:A=%b,B=%b,C=%b,D=%b", a, b, c, d);
  endtask: oper1

  virtual task oper2();
    $display("This is classA");
    d = a * (b | c);
    $display("This is classA, oper2:A=%b,B=%b,C=%b,D=%b", a, b, c, d);
  endtask: oper2
endclass: A

class EA extends A;
  function new(int a, int b, int c);
    super.new(a, b, c);
  endfunction

  task oper1();
    $display("This is extended class EA");
    d = (a * b) + c;
    $display("This is extended class EA, oper1:A=%b,B=%b,C=%b,D=%b", a, b, c, d);
  endtask: oper1

  task oper2();
    $display("This is extended class EA");
    d = (a | b) * c;
    $display("This is extended class EA, oper2:A=%b,B=%b,C=%b,D=%b", a, b, c, d);
  endtask: oper2
endclass: EA

// ✅ Required top module
module top;
  initial begin
    EA my_ea;
    A my_a;

    my_a = new(3, 5, 7);
    my_a.oper1();
    my_a.oper2();

    my_ea = new(4, 6, 8);
    my_a = my_ea;
    my_a.oper1();
    my_a.oper2();
  end
endmodule 
