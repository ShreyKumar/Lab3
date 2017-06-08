

module ripple(LEDR, SW);
	input[9:0] SW;
	output[9:0] LEDR;

	wire w01;
	wire w12;
	wire w23;

	full_adder u0 (
		.sum(LEDR[0]),
		.cout(w01),
		.a(SW[4]),
		.b(SW[0]),
		.cin(SW[8])
	);

	full_adder u1 (
		.sum(LEDR[1]),
		.cout(w12),
		.a(SW[5]),
		.b(SW[1]),
		.cin(w01)
	);

	full_adder u2 (
		.sum(LEDR[2]),
		.cout(w23),
		.a(SW[6]),
		.b(SW[2]),
		.cin(w12)
	);

	full_adder u3 (
		.sum(LEDR[3]),
		.cout(LEDR[4]),
		.a(SW[7]),
		.b(SW[3]),
		.cin(w23)
	);
	
endmodule


module full_adder(sum, cout, a, b, cin);
	output sum, cout;
	input a, b, cin;
	
	assign sum = a^b^cin;
	assign cout = (a&b)|(cin&(a^b));
endmodule
