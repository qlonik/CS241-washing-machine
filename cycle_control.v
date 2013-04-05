module cycle_control(bus_in,timer_done,stage_bus,output_control1,next,timer_select,valve_enable,cold_override);
	input[4:0] bus_in;
	input[3:0] stage_bus;
	input timer_done;
	output[3:0] output_control1;
	output next,timer_select,valve_enable,cold_override;
	reg[3:0] output_control1;
	reg next,timer_select,valve_enable,cold_override;
	
always@(posedge bus_in or posedge timer_done or posedge stage_bus)
	case(stage_bus)
		//IDLE
		4'b0000:begin 
			valve_enable=1'b0;
			cold_override=1'b0;
			timer_select=2'b00;
			output_control1=4'b0000;
			next=bus_in[8];
			end
		//PREWASH	
		4'b0001:begin
			next=1'b0;
			valve_enable=1'b1;
			if(bus_in[1]/*full*/) begin //if full
				valve_enable=1'b0; // disable valves
			 	next=1'b1;
				end
			end
		//WASH
		4'b0010:begin
			next=1'b0;
			timer_select=2'b01;//wash timer
			output_control1[3]=1'b1;//turn on agitator
			if(timer_done==1'b1)begin // if timer expires
				output_control1[3]=1'b0; //turn of agitator
				next=1'b1;
				end
			end
		//POST WASH 
		4'b0011:begin	
			next=1'b0;
			output_control1[1]=1'b1; //turn on pump
			if(bus_in[0]/*empty*/)begin // if empty
				output_control1[1]=1'b0; // turn off pump
				next=1'b1;
				end
			end
		//PRE RINSE
		4'b0100:begin
			next=1'b0;
			cold_override=1'b1;//turn on cold over ride
			valve_enable=1'b1;//turn on valves
			if(bus_in[1])begin //if full
				valve_enable=1'b0; //disable valves
				next=1'b1;
				end
			end
		//RINSE 1
		4'b0101:begin
			next=1'b0;
			timer_select=2'b10;//rinse timer
			output_control1[3]=1'b1; //turn on agitator
			if(timer_done==1'b1)begin //if timer expires
				output_control1[3]=1'b0;
				next=1'b1;
				end
			end
		//POST RINSE
		4'b0110:begin
			next=1'b0;
			output_control1[1]=1'b1;//turn on the pump
			if(bus_in[0])begin // if empty
				output_control1[1]=1'b0;//turn pump off
				next=1'b1;
				end
			end
		//PRE RINSE 
		4'b0111:begin
			next=1'b0;
			valve_enable=1'b1;//fill with water, cold_override is still active
			if(bus_in[1])begin//if full
				valve_enable=1'b0;
				next=1'b1;
				end
			end
		//RINSE 2
		4'b1000:begin
			next=1'b0;
			timer_select=2'b10;//rinse timer
			output_control1[3]=1'b1;//turn on agitator
			if(timer_done==1'b1)begin//if timer expires
				output_control1[3]=1'b0;
				next=1'b1;
				end
			end
		//POST RINSE
		4'b1001:begin
			next=1'b0;
			output_control1[1]=1'b1;//turn on the pump
			if(bus_in[0])begin//if empty
				output_control1[1]=1'b0;//turn off pump
				next=1'b1;
				end
			end
		//PRE SPIN
		4'b1010:begin
			next=1'b0;
			output_control1[1]=1'b1;//turn on the pump
			if(bus_in[0])begin//if empty
				output_control1[1]=1'b0;//turn off pump
				next=1'b1;
				end
			end
		//SPIN
		4'b1011:begin
			next=1'b0;
			timer_select=2'b11;//spin timer start
			output_control1[2]=1'b1;//turn spin on
			if(timer_done==1'b1)begin//if timer expires
				output_control1[2]=1'b0;
				next=1'b1;
				end
			end
		//POST SPIN
		4'b1100:begin
			next=1'b0;
			output_control1[1]=1'b1;//turn on the pump
			if(bus_in[0])begin//if empty
				output_control1[1]=1'b0;//turn off pump
				output_control1[0]=1'b1;//turn alarm on
				next=1'b1;
				end
			end
//		//UNUSED
//		4'b1101:
//		4'b1110:
//		4'b1111:
	endcase
endmodule
