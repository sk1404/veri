module tb_fsm1011(intf_fsm1011 Itb);
    initial begin
        Itb.rst = 1;
        #20 Itb.rst = 0; Itb.x = 0;
        #50 Itb.x = 1;
        #50 Itb.x = 1;
        #50 Itb.x = 0;
        #50 Itb.x = 1;
        #50 Itb.x = 1;
        #50 Itb.x = 0;
        #50 Itb.x = 0;
        #50 Itb.x = 0;
        #50 Itb.x = 1;
        #50 Itb.x = 0;
        #50 Itb.x = 1;
        #50 Itb.x = 1;
        #50 Itb.x = 0;
        #50 Itb.x = 1;
        #50 Itb.x = 1;
        #50 Itb.x = 0;
        #50 Itb.x = 1;
        #50 Itb.x = 0;
        #50 Itb.x = 0;
        #50 Itb.x = 1;
        #10 $stop;
    end
endmodule
