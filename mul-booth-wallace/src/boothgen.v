module boothgen(
        input [ 2:0] y,
        input [63:0] x,
        output       c,
        output[63:0] p
    );

    wire [3:0] sel; // 0 -> +X; 1 -> +2X; 2 -> -2X; 3 -> -X

    assign sel[0] = ~y[2] & (y[1] ^ y[0]);
    assign sel[1] = ~y[2] &  y[1] &  y[0];
    assign sel[2] =  y[2] & ~y[1] & ~y[0];
    assign sel[3] =  y[2] & (y[1] ^ y[0]);

    assign c = sel[2] | sel[3];

    assign p[0] = sel[0] & x[0] | sel[2] | sel[3] & ~x[0];

    genvar i;
    generate
        for (i = 1; i < 64; i = i + 1) begin
            assign p[i] = sel[0] &  x[i    ] |
                          sel[1] &  x[i - 1] |
                          sel[2] & ~x[i - 1] |
                          sel[3] & ~x[i    ];
        end
    endgenerate


endmodule
