module shift_register_design(
input clk,serial_input,load,direction,reset,
input[3:0]parallel_load, 
output reg[3:0] parallel_out);

always@(posedge clk,reset)
begin
	if(reset==1)
		begin
		parallel_out<=4'b0;
		end
	else
		begin
		case(direction)
		1'b0:begin
			if(load)
			begin
				parallel_out<={1'b0,parallel_load[3:1]};
			end
			else
			begin
				parallel_out<={serial_input,parallel_load[3:1]};
			end
		     end
		1'b1:begin
			if(load)
			begin
				parallel_out<={parallel_load[2:0],1'b0};
			end
			else
			begin
				parallel_out<={parallel_load[2:0],serial_input};
			end
		     end
		default:begin
			parallel_out<=4'b0;
			end
		endcase
		end
end
endmodule

interface shift_inter(input bit clk);
logic reset;
logic [3:0] parallel_load;
logic direction,load,serial_input;
logic [3:0]parallel_out;
clocking cb@(posedge clk);
default input #1ns output #2ns;
output parallel_load,direction,load,serial_input;
input parallel_out;
endclocking
modport TB(clocking cb,output reset);
endinterface

class transactor;
rand bit[3:0]parallel_load;
rand bit direction,load,serial_input;
constraint c1{parallel_load inside {[0:5],[8:13]};}
endclass

class driver;
transactor trans;
virtual shift_inter.TB i1;
function new(virtual shift_inter.TB i1_new);
this.i1=i1_new;
this.trans=new();
$display("%d: driver:new method created",$time);
endfunction
task drive_data();
repeat(10) @(i1.cb)
begin
if((trans.randomize()))
begin
i1.cb.parallel_load<=trans.parallel_load;
i1.cb.direction<=trans.direction;
i1.cb.load<=trans.load;
i1.cb.serial_input<=trans.serial_input;
end
else
$display("%d:rand error",$time);
end
endtask
endclass

module shift_register_top;
bit clk;
always #5 clk=~clk;
shift_inter i1(clk);
test tbench(i1);
shift_register_design
dut(.clk(clk),.serial_input(i1.serial_input),.load(i1.load),.direction(i1.direction),.reset(i1.reset)
,.parallel_load(i1.parallel_load),.parallel_out(i1.parallel_out));
initial begin
$dumpfile("shift_register.vcd");
$dumpvars;
end
endmodule
