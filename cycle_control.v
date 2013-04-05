module cycle_control(bus_in,timer_done,stage_bus,output_control1,next,timer_select,valve_enable);
	input[4:0] bus_in;
	input[3:0] stage_bus;
	input timer_done;
	output[3:0] output_control1;
	output next,timer_select,valve_enable;
	
always@(posedge bus_in or posedge timer_done or posedge stage_bus)
	case(stage_bus)
		4b'0000: next=bus_in[4];
		4b'0001:
		4b'0010:
		4b'0011:
		4b'0100:
		4b'0101:
		4b'0110:
		4b'0111:
		4b'1000:
		4b'1001:
		4b'1010:
		4b'1011:
		4b'1100:

		


endmodule

		


endmodule

