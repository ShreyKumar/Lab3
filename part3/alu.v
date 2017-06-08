module alu(LEDR, SW, KEY, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
	input[7:0] SW;
	input[2:0] KEY;
	output[7:0] LEDR;
	output HEX0;
	output HEX1;
	output HEX2;
	output HEX3;
	output HEX4;
	output HEX5;

	reg[7:0] Out;
	reg[7:0] Temp;

	ripple u0 (
		.A(SW[3:0]),
		.B(SW[7:4]),
		.Sum(Out)
	);

	always @(*)
	begin
		case(KEY[2:0])
			3'b000: Temp = Out; // case 0
			3'b001: Out = 0; // case 1
			3'b010: Out = 0; // case 2
			3'b011: Out = 0; // case 3
			3'b100: Out = 0; // case 4
			3'b101: Out = 0; //case 5
			default: Out = 0; //default case		
		endcase
	end

	assign LEDR = Temp;


endmodule



module ripple(A, B, Sum);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Sum;

	wire w01;
	wire w12;
	wire w23;

	full_adder u0 (
		.sum(Sum[0]),
		.cout(w01),
		.a(A[0]),
		.b(B[0]),
		.cin(0)
	);

	full_adder u1 (
		.sum(Sum[1]),
		.cout(w12),
		.a(A[1]),
		.b(B[1]),
		.cin(w01)
	);

	full_adder u2 (
		.sum(Sum[2]),
		.cout(w23),
		.a(A[2]),
		.b(B[2]),
		.cin(w12)
	);

	full_adder u3 (
		.sum(Sum[3]),
		.cout(0),
		.a(A[3]),
		.b(B[3]),
		.cin(w23)
	);

	assign Sum[4:7] = 4'b0000;
	
endmodule


module full_adder(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a^b^cin;
	assign cout = (a&b)|(cin&(a^b));
endmodule
