module SignExtend(input[15:0] in,
		output[31:0] out);

	assign out = {{16{in[15]}}, in};

endmodule

module ZeroExtend(input[15:0] in,
                  output[31:0] out);

    assign out = {{16{1'b0}}, in};

endmodule

module ZeroExtendShamt(input[4:0] in,
                       output[31:0] out);

    assign out = {{27{1'b0}}, in};

endmodule
