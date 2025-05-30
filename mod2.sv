module t_ff(
input clk,T,reset,set,
output reg q);
always @(posedge clk)
begin
if (reset)
q<=0;
if(set)
q<=1;
else if(T==1)
q<=~q;
end
endmodule
