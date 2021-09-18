`timescale 1ns / 1ps

module mul_tb();

    reg [31:0] x;
    reg [31:0] y;
    wire[63:0] res;
    wire[63:0] ref_res;

    reg clk;

    assign ref_res = $signed(x) * $signed(y);

    mul_top test_mul(.src1(x), .src2(y), .res(res));

    initial begin
        clk = 1'b0;
    end

    always #10 clk = ~clk;

    always @(posedge clk) begin
        x <= $random();
        y <= $random();
    end


endmodule
