module d_ff (
    input  logic clk,
    input  logic reset_n,  // Active low reset
    input  logic d,
    output logic q
);

    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            q <= 1'b0;
        else
            q <= d;
    end

endmodule
