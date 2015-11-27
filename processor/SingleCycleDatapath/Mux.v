module Mux32Bit2To1(input[31:0] in0,
		input[31:0] in1,
		input sel,
		output[31:0] out);

	assign out = sel ? in1 : in0;

endmodule

module Mux5Bit2To1(input[4:0] in0,
		input[4:0] in1,
		input sel,
		output[4:0] out);

	assign out = sel ? in1 : in0;

endmodule

module Mux32Bit4To1(input[31:0] in0,
                    input[31:0] in1,
                    input[31:0] in2,
                    input[31:0] in3,
                    input[1:0] sel,
                    output reg[31:0] out);

    always @(sel, in0, in1, in2, in3)
        case (sel)
            0: out = in0;
            1: out = in1;
            2: out = in2;
            3: out = in3;
        endcase

endmodule
