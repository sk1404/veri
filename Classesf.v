class A;
  int a, b, c, d;
  covergroup cov; // Functional coverage
    coverpoint d {
      bins low  = {[0:10]};
      bins mid  = {[11:30]};
      bins high = {[31:$]};
    }
  endgroup

  function new(int a_in, int b_in, int c_in);
    a = a_in;
    b = b_in;
    c = c_in;

    // Assertion to check valid inputs
    assert(a >= 0 && b >= 0 && c >= 0)
      else $fatal("ERROR: a, b, c must be >= 0");

    cov = new();
  endfunction

  virtual task oper1();
    $display("This is class A");
    d = a + b + c;
    cov.sample();
    $display("Class A - oper1: A=%0d, B=%0d, C=%0d, D=%0d", a, b, c, d);
  endtask

  virtual task oper2();
    $display("This is class A");
    d = a * (b | c);
    cov.sample();
    $display("Class A - oper2: A=%0d, B=%0d, C=%0d, D=%0d", a, b, c, d);
  endtask
endclass

class EA extends A;
  function new(int a_in, int b_in, int c_in);
    super.new(a_in, b_in, c_in);
  endfunction

  task oper1();
    $display("This is extended class EA");
    d = (a * b) + c;
    cov.sample();
    $display("EA - oper1: A=%0d, B=%0d, C=%0d, D=%0d", a, b, c, d);
  endtask

  task oper2();
    $display("This is extended class EA");
    d = (a | b) * c;
    cov.sample();
    $display("EA - oper2: A=%0d, B=%0d, C=%0d, D=%0d", a, b, c, d);
  endtask
endclass

program main;
  A my_a;
  EA my_ea;

  initial begin
    $display("------ PHASE 1: Using Base Class A ------");
    my_a = new(3, 5, 7);

    // fork-join: parallel oper1 and oper2
    fork
      my_a.oper1();
      my_a.oper2();
    join

    $display("------ PHASE 2: Using Extended Class EA via Base Handle ------");
    my_ea = new(4, 6, 8);
    my_a = my_ea;

    // fork-join_none: async start, wait manually
    fork
      my_a.oper1();
      my_a.oper2();
    join_none

    #10; // Wait for async operations
  end
endprogram
