module Alu(input[31:0] op1,
		input[31:0] op2,
		input[3:0] f,
		output reg[31:0] result,
		output zero);

	always @(op1, op2, f)
		case (f)
			0: result = op1 + op2;
            1: result = op1 - op2;
            2: result = op1 & op2;
            3: result = op1 | op2;
            4: result = op1 ~| op2;
            5: result = op1 ^ op2;
            6: result = op1 << op2;
            7: result = op1 >> op2;
            8: result = op1 >>> op2;
            9: result = ($signed(op1) < $signed(op2)) ? 1 : 0; //SLT
            10: result = (op1 < op2) ? 1 : 0;   //SLTU
           /* 11: 
            12:
            13:
            14:
            15:*/
        endcase 
	
	assign zero = result == 0;
endmodule

module Mult_Div_Alu(input[31:0] op1,
                    input[31:0] op2,
                    input[3:0] f,
                    output reg[31:0] result_hi,
                    output reg[31:0] result_lo);

    always @(op1, op2, f)
       case (f)
    		0: begin
                result_lo = $signed(op1) / $signed(op2);
                result_hi = $signed(op1) % $signed(op2);
            end
            1: begin
                result_lo = op1 / op2;
                result_hi = op1 % op2;
            end
            2: {result_hi, result_lo} = $signed(op1) * $signed(op2);
            3: {result_hi, result_lo} = op1 * op2;
          /*  4:
            5:
            6:
            7:
            8:
            9:
            10:
            11:
            12:
            13:
            14:
            15: */
        endcase
endmodule
