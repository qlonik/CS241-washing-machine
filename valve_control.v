module valve_control(bus_in,cold_override,bus_out);

	input cold_override;
	input [2:0] bus_in;
	output [1:0] bus_out;

/* 
* bus_out[0] is cold valve
* bus_out[1] is hot valve
*
* bus_in[0] is cold select
* bus_in[1] is warm select
* bus_in[2] is hot select
*/

/*
	assign 
		bus_out[0] = cold_override + bus_out[0] + (bus_out[0] & bus_out[1]); 
		bus_out[0] = ~cold_override & bus_in[3] & ~(bus_out[0] & bus_out[1]) + 
			~cold_override & ~bus_in[0] & bus_out[0] & bus_out[1];
*/

assign
	bus_out[0] = cold_override | bus_in[0] | bus_in[1],
	bus_out[1] = ~cold_override & (bus_in[1] | bus_in[2]);

endmodule
