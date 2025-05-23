module fsm1011 (intf_fsm1011 Ir);
  logic [2:0] ns, ps;
  parameter [2:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;

  // State update on positive clock edge
  always @(posedge Ir.clk) begin
    if (Ir.rst)
      ps <= s0;  // Reset to s0
    else
      ps <= ns;  // Otherwise, transition to the next state
  end

  // Next state logic
  always @(ps, Ir.x) begin
    case(ps)
      s0: begin
        if (Ir.x) ns = s1; else ns = s0;
      end
      s1: begin
        if (Ir.x) ns = s1; else ns = s2;
      end
      s2: begin
        if (Ir.x) ns = s3; else ns = s0;
      end
      s3: begin
        if (Ir.x) ns = s4; else ns = s2;
      end
      s4: begin
        if (Ir.x) ns = s1; else ns = s2;
      end
      default: begin
        ns = s0;  // Default state on invalid state
      end
    endcase
  end

  // Output logic (Moore FSM output depends on the state)
  always @(ps) begin
    Ir.y = (ps == s4) ? 1 : 0;  // Output is 1 only at state s4
  end

endmodule

// Interface for FSM inputs and outputs
interface intf_fsm1011(input clk);
  bit x;   // Input bit
  bit y;   // Output bit
  bit rst; // Reset signal
endinterface

// Top-level testbench module
module top_fsm1011();
  bit clk;
  intf_fsm1011 I(clk); // Connect interface instance
  fsm1011 dut(I);      // FSM instance
  tb_fsm1011 tb(I);     // Testbench instance
  
  always #20 clk = ~clk;  // Clock generation
  
  initial begin
    clk = 0;
  end

  initial begin
    $dumpfile("fsm1011.svd");
    $dumpvars;
  end
endmodule
