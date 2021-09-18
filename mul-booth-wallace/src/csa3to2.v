module csa3to2 #(
        parameter DATA_WIDTH = 1
    )(
        input [DATA_WIDTH - 1:0] a,
        input [DATA_WIDTH - 1:0] b,
        input cin,

        output cout,
        output [DATA_WIDTH - 1:0] sum
    );

    assign {cout, sum} = a + b + cin;

endmodule
