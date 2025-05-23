module fsm1011 (intf_fsm1011 Ir);
    logic [2:0] ns, ps;
    parameter [2:0] s0 = 3'b000, s1 = 3'b001, s2 = 3'b010, s3 = 3'b011, s4 = 3'b100;

    always @(posedge Ir.clk) begin
        if (Ir.rst) 
            ps <= s0;
        else 
            ps <= ns;
    end

    always @(ps, Ir.x) begin
        case(ps)
            s0: begin 
                if (Ir.x) 
		begin
			ns = s1;
			Ir.y = 0;
		end
                else 
		begin
			ns = s0;
			Ir.y = 0;
		end
            end
            s1: begin 
                if (Ir.x) 
		begin
			ns = s1;
			Ir.y = 0;
		end
               else 
		begin
			ns = s2;
			Ir.y = 0;
		end
            end
            s2: begin 
                if (Ir.x) 
		begin
			ns = s3;
			Ir.y = 0;
		end
                else 
		begin
			ns = s3;
			Ir.y = 0;
		end
            end
            s3: begin 
                if (Ir.x) 
		begin
			ns = s4;
			Ir.y = 0;
		end
                else 
		begin
			ns = s2;
			Ir.y = 0;
		end
            end
            s4: begin 
                if (Ir.x) 
		begin
			ns = s1;
			Ir.y = 1;
		end
                else 
		begin
			ns = s2;
			Ir.y = 0;
		end
            end
            default: begin 
                Ir.y = 0;
                ns = s0;
            end
        endcase
    end
endmodule

interface intf_fsm1011(input clk);
    bit x;
    bit y;
    bit rst;

    modport DUT(input clk, x, rst, output y);
    modport TB(output rst, x);
endinterface

module top_fsm1011();
    bit clk;
    intf_fsm1011 I(clk);
    fsm1011 dut(I);
    tb_fsm1011 tb(I);

    always #20 clk = ~clk;

    initial begin
        clk = 0;
    end

    initial begin
        $dumpfile("fsm1011.vcd");
        $dumpvars;
    end
endmodule
