module ControlUnit(input[5:0] opcode,
		input[5:0] funct,
		output reg reg_dst,
		output reg reg_write,
		output reg[1:0] alu_src,
		output reg[3:0] alu_op,
		output reg branch,
		output reg mem_write,
		output reg mem_to_reg,
        	output reg zero_sign_ext,
		output reg mult_op,
		output reg mfhi,
		output reg mflo);

	always @(opcode, funct) begin
		
		// Make sure that all output have an initial value assigned in
		// order to prevent synthesis of sequential logic.
		reg_dst = 1'bx;
		reg_write = 1'bx;
		alu_src = 2'bxx;
		alu_op = 4'bxxxx;
		branch = 1'bx;
		mem_write = 1'bx;
		mem_to_reg = 1'bx;
		zero_sign_ext = 1'bx;

		mult_op = 1'b0; // use the multiply/div alu
		mfhi = 1'b0; // move from hi
		mflo = 1'b0; // move from lo

		// Check opcode
		case (opcode)

			// If opcode is 0, check funct
			6'h00: begin

				// Common signals
				reg_dst = 1;
				reg_write = 1;
				alu_src = 0;
				branch = 0;
				mem_write = 0;
				mem_to_reg = 0;
			
				// ALU operation depends on funct
				case (funct)

					// add
					6'h20: begin
						alu_op = 4'b0000;
						$display("\tInstruction 'add'");
					end

                   			 //addu
                   			 6'h21: begin
                   			     alu_op = 4'b0000;
                   			     $display("\tInstruction 'addu'");
                   			 end

					// sub
					6'h22: begin
						alu_op = 4'b0001;
						$display("\tInstruction 'sub'");
					end

					// subu
					6'h23: begin
						alu_op = 4'b0001;
						$display("\tInstruction 'subu'");
					end

					// and
					6'h24: begin
						alu_op = 4'b0010;
						$display("\tInstruction 'and'");
					end

                   			 // nor
                   			 6'h27: begin
                   			     alu_op = 4'b0100;
                   			     $display("\tInstruction 'nor'");
                   			 end

					// or
					6'h25: begin
						alu_op = 4'b0011;
						$display("\tInstruction 'or'");
					end

                   			 // xor
                   			 6'h26: begin
                   			     alu_op = 4'b0101;
                   			     $display("\tInstruction 'xor'");
                   			 end
                   			 
                   			 // sll
                   			 6'h0: begin
                   			     alu_op = 6;
                   			     alu_src = 2;
                   			     $display("\tInstruction 'sll'");
                   			 end

                   			 // srl
                   			 6'h2: begin
                   			     alu_op = 7;
                   			     alu_src = 2;
                   			     $display("\tInstruction 'srl'");
                   			 end

                   			 // sra
                   			 6'h3: begin
                   			     alu_op = 8;
                   			     alu_src = 2;
                   			     $display("\tInstruction 'sra'");
                   			 end

                   			 // sllv
                   			 6'h4: begin
                   			     alu_op = 6;
                   			     $display("\tInstruction 'sllv'");
                   			 end

                   			 // srlv
                   			 6'h6: begin
                   			     alu_op = 7;
                   			     $display("\tInstruction 'srlv'");
                   			 end

                   			 // srav
                   			 6'h7: begin
                   			     alu_op = 8;
                   			     $display("\tInstruction 'srav'");
                   			 end

					// slt
					6'h2a: begin
						alu_op = 4'b1001;
						$display("\tInstruction 'slt'");
					end

					// sltu
					6'h2b: begin
						alu_op = 4'b1010;
						$display("\tInstruction 'sltu'");
					end

					// mult
					6'h18: begin
						mult_op = 1;
						reg_write = 0;
						alu_op = 4'b0010;
						$display("\tInstruction 'mult'");
					end

					// multu
					6'h19: begin
						mult_op = 1;
						reg_write = 0;
						alu_op = 4'b0011;
						$display("\tInstruction 'multu'");
					end

					// div
					6'h1A: begin
						mult_op = 1;
						reg_write = 0;
						alu_op = 4'b0000;
						$display("\tInstruction 'div'");
					end

					// divu
					6'h1B: begin
						mult_op = 1;
						reg_write = 0;
						alu_op = 4'b0001;
						$display("\tInstruction 'divu'");
					end

					// mfhi
					6'h10: begin
						alu_op = 4'b1111;
						mfhi = 1;
						$display("\tInstruction 'mfhi'");
					end

					// mflo
					6'h12: begin
						alu_op = 4'b1111;
						mflo = 1;
						$display("\tInstruction 'mflo'");
					end
				endcase
			end

			// lw
			6'h23: begin
				reg_dst = 0;
				reg_write = 1;
				alu_src = 1;
				alu_op = 4'b0000;
				branch = 0;
				mem_write = 0;
				mem_to_reg = 1;
				zero_sign_ext = 0;
				$display("\tInstruction 'lw'");
			end

			// sw
			6'h2b: begin
				reg_write = 0;
				alu_src = 1;
				alu_op = 4'b0000;
				branch = 0;
				mem_write = 1;
				zero_sign_ext = 0;
				$display("\tInstruction 'sw'");
			end

			// beq
			6'h04: begin
				reg_write = 0;
				alu_src = 0;
				alu_op = 4'b0001;
				branch = 1;
				mem_write = 0;
				$display("\tInstruction 'beq'");
			end
		endcase
	end
endmodule

