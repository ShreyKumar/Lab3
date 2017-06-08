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

	wire[7:0] Case0;
	wire[7:0] Case1;
	wire[7:0] Case2;
	wire[7:0] Case3;
	wire[7:0] Case4;
	wire[7:0] Case5;

	reg[7:0] Out;

	ripple u0 (
		.A(SW[3:0]),
		.B(4'b0001),
		.Sum(Case0[7:0])
	);

	ripple u1 (
		.A(SW[3:0]),
		.B(SW[7:4]),
		.Sum(Case1[7:0])
	);

	verisum u2 (
		.A(SW[3:0]),
		.B(SW[7:4]),
		.Sum(Case2[7:0])
	);

	xororor u3 (
		.A(SW[3:0]),
		.B(SW[7:4]),
		.Result(Case3[7:0])
	);

	reductionor u4 (
		.A(SW[3:0]),
		.B(SW[7:4]),
		.Result(Case4[7:0])
	);

	concat u5 (
		.A(SW[3:0]),
		.B(SW[7:4]),
		.Result(Case5[7:0])
	);
	
	always @(*)
	begin
		case(KEY[2:0])
			3'b000: Temp = Case0; // case 0
			3'b001: Temp = Case1; // case 1
			3'b010: Temp = Case2; // case 2
			3'b011: Temp = Case3; // case 3
			3'b100: Temp = Case4; // case 4
			3'b101: Temp = Case5; //case 5
			default: Temp = 8'b00000000; //default case		
		endcase
	end

	assign LEDR = Out;

endmodule


module concat(A, B, Result);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Result;
	
	assign Result[7:0] = {A, B};

endmodule


module reductionor(A, B, Result);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Result;
	
	assign Result[0] = | {A, B};
	assign Result[7:1] = 7'b0000000;

endmodule

module xororor(A, B, Result);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Result;

	assign Result[3:0] = A^B;
	assign Result[7:4] = A|B;
endmodule



module verisum(A, B, Sum);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Sum;
	
	assign Sum = A + B;
endmodule


module ripple(A, B, Sum);
	input[3:0] A;
	input[3:0] B;
	output[7:0] Sum;

	wire dummy;

	wire w01;
	wire w12;
	wire w23;

	full_adder u0 (
		.sum(Sum[0]),
		.cout(w01),
		.a(A[0]),
		.b(B[0]),
		.cin(1'b0)
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
		.cout(dummy),
		.a(A[3]),
		.b(B[3]),
		.cin(w23)
	);

	assign Sum[7:4] = 4'b0000;
	
endmodule


module full_adder(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a^b^cin;
	assign cout = (a&b)|(cin&(a^b));
endmodule
