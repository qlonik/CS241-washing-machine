module cycle_control(bus_in,timer_done,stage_bus,output_control1,next,timer_select,valve_enable,cold_override);
	input[4:0] bus_in;
	input[3:0] stage_bus;
	input timer_done;
	output[3:0] output_control1;
	output next,timer_select,valve_enable,cold_override;
	
always@(posedge bus_in or posedge timer_done or posedge stage_bus)
	case(stage_bus)
		//IDLE
		4b'0000:valve_enable=1b'0;
			cold_override=1b'0;
			timer_select=2b'00;
			output_control=4b'0000;
			next=bus_in[8];
		//PREWASH	
		4b'0001:next=1b'0;
			valve_enable=1b'1; 
			if(bus_in[1]/*full*/) begin //if full
				valve_enable=1b'0; // disable valves
			 	next=1b'1;
				end
		//WASH
		4b'0010:next=1b'0;
			timer_select=2b'01;//wash timer
			output_control1[3]=1b'1;//turn on agitator
			if(timer_done==1b'1)begin // if timer expires
				output_control1[3]=1b'0; //turn of agitator
				next=1b'1;
				end
		//POST WASH 
		4b'0011:next=1b'0;
			output_control1[1]=1b'1; //turn on pump
			if(bus_in[0]/*empty*/)begin // if empty
				output_control1[1]=1b'0; // turn off pump
				next=1b'1;
				end
		//PRE RINSE
		4b'0100:next=1b'0;
			cold_override=1b'1;//turn on cold over ride
			valve_enable=1b'1; //turn on valves
			if(bus_in[1])begin //if full
				valve_enable=1b'0; //disable valves
				next=1b'1;
				end
		//RINSE 1
		4b'0101:next=1b'0;
			timer_select=2b'10;//rinse timer
			output_control1[3]=1b'1; //turn on agitator
			if(timer_done==1b'1)begin //if timer expires
				output_control1[3]=1b'0;
				next=1b'1;
				end
		//POST RINSE
		4b'0110:next=1b'0;
			output_control1[1]=1b'1;//turn on the pump
			if(bus_in[0])begin // if empty
				output_control1[1]=1b'0;//turn pump off
				next=1b'1;
				end
		//PRE RINSE 
		4b'0111:next=1b'0;
			valve_enable=1b'1;//fill with water, cold_override is still active
			if(bus_in[1])begin//if full
				valve_enable=1b'0;
				next=1b'1;
				end
		//RINSE 2
		4b'1000:next=1b'0;
			timer_select=2b'10;//rinse timer
			output_control1[3]=1b'1;//turn on agitator
			if(timer_done==1b'1)begin//if timer expires
				output_control1[3]=1b'0;
				next=1b'1;
				end
		//POST RINSE
		4b'1001:next=1b'0;
			output_control1[1]=1b'1;//turn on the pump
			if(bus_in[0])begin//if empty
				output_control1[1]=1b'0;//turn off pump
				next=1b'1;
				end
		//PRE SPIN
		4b'1010:next=1b'0;
			output_control1[1]=1b'1;//turn on the pump
			if(bus_in[0])begin//if empty
				output_control1[1]=1b'0;//turn off pump
				next=1b'1;
				end
		//SPIN
		4b'1011:next=1b'0;
			timer_select=2b'11;//spin timer start
			output_control1[2]=1b'1;//turn spin on
			if(timer_done==1b'1)begin//if timer expires
				output_control1[2]=1b'0;
				next=1b'1;
				end
		//POST SPIN
		4b'1100:next=1b'0;
			output_control1[1]=1b'1;//turn on the pump
			if(bus_in[0])begin//if empty
				output_control1[1]=1b'0;//turn off pump
				next=1b'1;
				end
		//UNUSED
		4b'1101:
		4b'1110:
		4b'1111:
	endcase
		


endmodule
