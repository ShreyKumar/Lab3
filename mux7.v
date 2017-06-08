




module mux7(LEDR, SW);
	input SW[9:0];
	output LEDR[9:0];
	reg Out; // declare the output signal for the always block
	always @(*) // declare always block
	begin
		case (SW[2:0]) // start case statement
			3’b000: Out = SW[3]; // case 0
			3’b001: Out = SW[4]; // case 1
			3’b010: Out = SW[5]; // case 2
			3’b011: Out = SW[6]; // case 3
			3’b100: Out = SW[7]; // case 4
			3’b101: Out = SW[8]; //case 5
			3’b110: Out = SW[9]; //case 6
			default: //default case
		endcase
	end
	assign LEDR[0] = Out;
endmodule
