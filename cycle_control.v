module cycle_control(bus_in,timer_done,stage_bus,output_control1,next,timer_select,valve_enablei,cold_override);
	input[4:0] bus_in;
	input[3:0] stage_bus;
	input timer_done;
	output[3:0] output_control1;
	output next,timer_select,valve_enable,cold_override;
	
always@(posedge bus_in or posedge timer_done or posedge stage_bus)
	case(stage_bus)
		4b'0000: next=bus_in[4];
		4b'0001: valve_enable=1b'1; 
			 if(bus_in[1]/*full*/) begin //if full
				valve_enable=1b'0; // disable valves
			 	next=1b'1;
				end
		4b'0010: timer_select=2b'01;//wash timer
			 output_control1[3]=1b'1;//turn on agitator
			 if(timer_done==1b'1)begin // if timer expires
				output_control1[3]=1b'0; //turn of agitator
				next=1b'1;
				end 
		4b'0011: output_control1[1]=1b'1; //turn on pump
			 if(bus_in[0]/*empty*/)begin // if empty
				output_control1[1]=1b'0; // turn off pump
				next=1b'1;
				end
		4b'0100: cold_override=1b'1;
			valve_enable=1b'1;
			if(bus_in[1])begin //if full
				valve_enable=1b'0; //disable valves
				next=1b'1;
				end
		4b'0101:timer_select=2b'10;//rinse timer
			output_control1[3]=1b'1; //turn on agitator
			if(timer_done==1b'1)begin //if timer expires
				output_control1[3]=1b'0;
				next=1b'1;
				end
		4b'0110:output_control1[1]=1b'1;
			if(bus_in[0])begin
				output_control1[1]=1b'0;
				next=1b'1;
				end
		4b'0111:
		4b'1000:
		4b'1001:
		4b'1010:
		4b'1011:
		4b'1100:
	endcase
		


endmodule

		


endmodule

