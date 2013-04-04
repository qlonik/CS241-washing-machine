module valve_control(bus_in,cold_override,bus_out);
  input cold_override;
	input[0:2] bus_in;
	output[0:1] bus_out;

/* bus_out[0] is cold valve
   bus_out[1] is hot valve
   bus_in[0] is cold select
   bus_in[1] is warm select
   bus_in[3] is hot select

   CR is cold override
   C is cold
   W is warm
   H is hot
*/

	assign 
	bus_out[0] = cold_override + bus_out[0] + (bus_out[0] & bus_out[1]); 
	bus_out[0] = ~cold_override & bus_in[3] & ~(bus_out[0] & bus_out[1]) + 						
               ~cold_override & ~bus_in[0] & bus_out[0] & bus_out[1];

endmodule
