module wallace (
        input [15:0] in,
        input [13:0] cin,

        output [13:0] cout,
        output        carry,
        output        sum
    );

    wire [13:0] C_out;

    wire sum00, sum01, sum02, sum03, sum04, sum05, sum06;
    wire sum07, sum08, sum09, sum10, sum11, sum12, sum13, sum14;

    // level 1
    csa3to2 csa1_1(.a( in[ 3]), .b( in[ 2]), .cin( in[ 1]), .sum(sum00), .cout(C_out[ 4]));
    csa3to2 csa1_2(.a( in[ 6]), .b( in[ 5]), .cin( in[ 4]), .sum(sum01), .cout(C_out[ 3]));
    csa3to2 csa1_3(.a( in[ 9]), .b( in[ 8]), .cin( in[ 7]), .sum(sum02), .cout(C_out[ 2]));
    csa3to2 csa1_4(.a( in[12]), .b( in[11]), .cin( in[10]), .sum(sum03), .cout(C_out[ 1]));
    csa3to2 csa1_5(.a( in[15]), .b( in[14]), .cin( in[13]), .sum(sum04), .cout(C_out[ 0]));

    // level 2
    csa3to2 csa2_1(.a(cin[ 3]), .b(cin[ 4]), .cin(   1'b0), .sum(sum05), .cout(C_out[ 8]));
    csa3to2 csa2_2(.a(cin[ 0]), .b(cin[ 1]), .cin(cin[ 2]), .sum(sum06), .cout(C_out[ 7]));
    csa3to2 csa2_3(.a(sum01  ), .b(sum00  ), .cin( in[ 0]), .sum(sum07), .cout(C_out[ 6]));
    csa3to2 csa2_4(.a(sum04  ), .b(sum03  ), .cin(sum02  ), .sum(sum08), .cout(C_out[ 5]));

    // level 3
    csa3to2 csa3_1(.a(sum05  ), .b(cin[ 5]), .cin(cin[ 6]), .sum(sum09), .cout(C_out[10]));
    csa3to2 csa3_2(.a(sum08  ), .b(sum07  ), .cin(sum06  ), .sum(sum10), .cout(C_out[ 9]));

    // level 4
    csa3to2 csa4_1(.a(cin[ 8]), .b(cin[ 9]), .cin(cin[10]), .sum(sum11), .cout(C_out[12]));
    csa3to2 csa4_2(.a(sum10  ), .b(sum09  ), .cin(cin[ 7]), .sum(sum12), .cout(C_out[11]));

    // level 5
    csa3to2 csa5_1(.a(sum12  ), .b(sum11  ), .cin(cin[11]), .sum(sum13), .cout(C_out[13]));

    // level 6
    csa3to2 csa6_1(.a(sum13  ), .b(cin[12]), .cin(cin[13]), .sum(sum),   .cout(carry));

    assign cout = C_out;

endmodule
