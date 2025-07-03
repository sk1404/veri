module async_counter_dff (
   input wire clk,
   input wire rst_n,
   output reg [2:0] Q
);
   reg [2:0] next_Q;
   // Next state logic (combinational)
   always @(*) begin
       case (Q)
           3'b010: next_Q = 3'b011;  // 2 -> 3
           3'b011: next_Q = 3'b100;  // 3 -> 4
           3'b100: next_Q = 3'b101;  // 4 -> 5
           3'b101: next_Q = 3'b110;  // 5 -> 6
           3'b110: next_Q = 3'b010;  // 6 -> 2
           default: next_Q = 3'b010; // default or invalid -> reset to 2
       endcase
   end
   // D-FF for asynchronous counter
   always @(negedge clk or negedge rst_n) begin
       if (!rst_n)
           Q <= 3'b010;  // Start from 2 (010)
       else
           Q <= next_Q;
   end
endmodule
interface counter_if(input bit clk);
   logic rst_n;
   logic [2:0] Q;
   modport DUT_PORT (
       input clk, rst_n,
       output Q
   );
   modport TB_PORT (

       input Q,
       output rst_n
   );
endinterface
