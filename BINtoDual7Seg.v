module BINtoDual7Seg(i, O);

// Decode 4 bit binary number from range 0..15
// to a dual 7 segment display signal.
//
// Input is a binary number with most significant
// number on the left position.
//
// Output is a vector with first 7 bits to higher
// order display, and second 7 to a second display.

input [3:0] i;
output [13:0] O;

wire w0;

assign
	w0    = ~i[3] | (i[3] & ~i[2] & ~i[1]),
	O[13] = w0,
	O[12] = 1,
	O[11] = 1,
	O[10] = w0,
	O[9]  = w0,
	O[8]  = w0,
	O[7]  = 0,
	
	O[6]  = (~i[2] & ~i[0]) | (i[2] & i[0]) | (i[3] & ~i[1]) | (~i[3] & i[1]),
	O[5]  = (i[3] & ~i[1]) | (~i[1] & ~i[0]) | ~i[2] |
		(~i[3] & i[1] & i[0]) | (i[3] & ~i[0]),
	O[4]  = (~i[3] & ~i[1]) | i[0] | (~i[3] & i[2]) | (i[3] & i[1]) | (i[3] & ~i[2]),
	O[3]  = (~i[2] & ~i[0]) | (i[3] & ~i[1]) | (i[2] & ~i[1] & i[0]) |
		(i[3] & i[2] & i[0]) | (~i[3] & ~i[2] & i[1]) | (~i[3] & i[1] & ~i[0]),
	O[2]  = (~i[2] & ~i[0]) | (i[3] & ~i[1] & ~i[0]) | (~i[3] & i[1] & ~i[0]),
	O[1]  = (~i[3] & i[2] & ~i[1]) | (~i[2] & ~i[1] & ~i[0]) |
		(i[3] & ~i[2] & ~i[1]) | (i[3] & i[2] & i[1]) | (i[2] & i[1] & ~i[0]) |
		(i[3] & i[1] & ~i[0]),
	O[0]  = (i[2] & ~i[1]) | (i[3] & ~i[1]) | (i[3] & i[2]) |
		(i[2] & i[1] & ~i[0]) | (~i[3] & ~i[2] & i[1]);
	
endmodule
