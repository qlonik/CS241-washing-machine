module MUX2to3(bus_in, d0, d1, d2);

// Accepts 2bit bus with binary number of timer
// and sets true to line that connected with that timer

	input [1:0] bus_in;
	output d0, d1, d2;
	
	assign
		d0 = ~bus_in[1] &  bus_in[0],
		d1 =  bus_in[1] & ~bus_in[0],
		d2 =  bus_in[1] &  bus_in[0];
endmodule

