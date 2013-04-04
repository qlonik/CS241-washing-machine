module wash_decoder(in, OUT);

input [3:0] in;
output [12:0] OUT;

assign
	OUT[12] =  in[3] &  in[2] & ~in[1] & ~in[0],
	OUT[11] =  in[3] & ~in[2] &  in[1] &  in[0],
	OUT[10] =  in[3] & ~in[2] &  in[1] & ~in[0],
	OUT[9]  =  in[3] & ~in[2] & ~in[1] &  in[0],
	OUT[8]  =  in[3] & ~in[2] & ~in[1] & ~in[0],
	OUT[7]  = ~in[3] &  in[2] &  in[1] &  in[0],
	OUT[6]  = ~in[3] &  in[2] &  in[1] & ~in[0],
	OUT[5]  = ~in[3] &  in[2] & ~in[1] &  in[0],
	OUT[4]  = ~in[3] &  in[2] & ~in[1] & ~in[0],
	OUT[3]  = ~in[3] & ~in[2] &  in[1] &  in[0],
	OUT[2]  = ~in[3] & ~in[2] &  in[1] & ~in[0],
	OUT[1]  = ~in[3] & ~in[2] & ~in[1] &  in[0],
	OUT[0]  = ~in[3] & ~in[2] & ~in[1] & ~in[0];

endmodule
