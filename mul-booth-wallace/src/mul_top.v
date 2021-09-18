`timescale 1ns / 1ps

module mul_top(
        input [31:0] src1,
        input [31:0] src2,

        output [63:0] res
    );

    wire [63:0] p [15:0];
    wire [15:0] c;
    wire [15:0] trans_p [63:0];

    wire [63:0] add_src1;
    wire [63:0] add_src2;
    wire [13:0] wallace_c [63:0];
    wire [63:0] Carry;
    wire [63:0] Sum;

    assign res = add_src1 + add_src2 + {63'b0, c[15]};

    assign add_src1 = Sum;
    assign add_src2 = {Carry[62:0], c[14]};
    
    boothgen booth00(.y({src2[1], src2[0], 1'b0}), .p(p[ 0]), .c(c[ 0]), .x({{32{src1[31]}}, src1[31:0]}));
    boothgen booth01(.y( src2[ 3: 1]            ), .p(p[ 1]), .c(c[ 1]), .x({{30{src1[31]}}, src1[31:0],  2'b0}));
    boothgen booth02(.y( src2[ 5: 3]            ), .p(p[ 2]), .c(c[ 2]), .x({{28{src1[31]}}, src1[31:0],  4'b0}));
    boothgen booth03(.y( src2[ 7: 5]            ), .p(p[ 3]), .c(c[ 3]), .x({{26{src1[31]}}, src1[31:0],  6'b0}));
    boothgen booth04(.y( src2[ 9: 7]            ), .p(p[ 4]), .c(c[ 4]), .x({{24{src1[31]}}, src1[31:0],  8'b0}));
    boothgen booth05(.y( src2[11: 9]            ), .p(p[ 5]), .c(c[ 5]), .x({{22{src1[31]}}, src1[31:0], 10'b0}));
    boothgen booth06(.y( src2[13:11]            ), .p(p[ 6]), .c(c[ 6]), .x({{20{src1[31]}}, src1[31:0], 12'b0}));
    boothgen booth07(.y( src2[15:13]            ), .p(p[ 7]), .c(c[ 7]), .x({{18{src1[31]}}, src1[31:0], 14'b0}));
    boothgen booth08(.y( src2[17:15]            ), .p(p[ 8]), .c(c[ 8]), .x({{16{src1[31]}}, src1[31:0], 16'b0}));
    boothgen booth09(.y( src2[19:17]            ), .p(p[ 9]), .c(c[ 9]), .x({{14{src1[31]}}, src1[31:0], 18'b0}));
    boothgen booth10(.y( src2[21:19]            ), .p(p[10]), .c(c[10]), .x({{12{src1[31]}}, src1[31:0], 20'b0}));
    boothgen booth11(.y( src2[23:21]            ), .p(p[11]), .c(c[11]), .x({{10{src1[31]}}, src1[31:0], 22'b0}));
    boothgen booth12(.y( src2[25:23]            ), .p(p[12]), .c(c[12]), .x({{ 8{src1[31]}}, src1[31:0], 24'b0}));
    boothgen booth13(.y( src2[27:25]            ), .p(p[13]), .c(c[13]), .x({{ 6{src1[31]}}, src1[31:0], 26'b0}));
    boothgen booth14(.y( src2[29:27]            ), .p(p[14]), .c(c[14]), .x({{ 4{src1[31]}}, src1[31:0], 28'b0}));
    boothgen booth15(.y( src2[31:29]            ), .p(p[15]), .c(c[15]), .x({{ 2{src1[31]}}, src1[31:0], 30'b0}));

    genvar i;
    generate
        for (i = 0; i < 64; i = i + 1) begin
            assign trans_p[i] = {p[15][i], p[14][i], p[13][i], p[12][i],
                                 p[11][i], p[10][i], p[ 9][i], p[ 8][i],
                                 p[ 7][i], p[ 6][i], p[ 5][i], p[ 4][i],
                                 p[ 3][i], p[ 2][i], p[ 1][i], p[ 0][i]};
        end
    endgenerate

    wallace w00(.in(trans_p[ 0]), .cin(c[13:0]), .cout(wallace_c[0]), .carry(Carry[0]), .sum(Sum[0]));

    generate
        for (i = 1; i < 64; i = i + 1) begin
            wallace wi(.in(trans_p[i]), .cin(wallace_c[i - 1]), .cout(wallace_c[i]), .carry(Carry[i]), .sum(Sum[i]));
        end
    endgenerate

endmodule
