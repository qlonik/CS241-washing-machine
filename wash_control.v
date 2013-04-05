module wash_control(bus_in,bus_out,timer_bus,stage_bus);

	input[8:0] bus_in;
	output[3:0] timer_bus, stage_bus;
	output[5:0] bus_out; 
	wire[3:0] current_state;
	wire[12:0] current_state_cmd;
	wire[1:0] valves,valve_signal;
	wire cold_override,next,timer_done,output_control1,wash_st,rinse_st,spin_st,garbage,valve_enable;
/*	
bus_in=9bit,signal forwarding from wash machine
bus_out=6bit,agitator,spin,pump,alert,cold_valve,hot_valve (IN THAT ORDER)
timer_bus=4bit, timer display
stage_bus=4bit,current stage, stage display  
cold_override = wire to signal cold water over ride (for rinse)
valves = open and close signals for the hot and cold valves
next=next signal from cycle_control used to increment cycles
timer_done=single bit line carrying the done signal of the active timer.
output_control1=signal for agitator,spin,pump,alert
wash_st=select line for wash timer
rinse_st=select line for rinse timer
spin_st=select line for spin timer
timer_select=select lines for the timers
garbage = used to capture the active signal from the timers, doesn't lead to anything since the active signal isn't used.
valve_enable=enables the valves
valve_signal=signal for vales taking into account the enable
*/
	//valves have to be linked to bus_out[5:6]
	//bus_in forwards cold,warm,hot to valve control
	valve_control(bus_in[3:5],cold_override,valves);
	cycle_counter(next,bus_in[5],bus_in[1],stage_bus);
	cycle_control({bus_in[0],bus_in[1],bus_in[5],bus_in[7],bus_in[8]},timer_done,stage_bus,output_control1,next,timer_select,valve_enable);
	MUX2to3(timer_select,wash_st,rinse_st,spin_st);
	wash_timer(bus_in[6],bus_in[1],wash_st,timer_bus,1'b0,garbage,timer_done);
	rinse_timer(bus_in[6],bus_in[1],rinse_st,timer_bus,1'b0,garbage,timer_done);
	spin_timer(bus_in[6],bus_in[1],rinse_st,timer_bus,1'b0,garbage,timer_done);
	tri_state_buffer(valves[0],valve_signal[0],valve_enable);
	tri_state_buffer(valves[1],valve_signal[1],valve_enable);
	assign
		bus_out={output_control1,valve_signal;
