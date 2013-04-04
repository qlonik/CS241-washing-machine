module wash_control(bus_in,bus_out,timer_bus,stage_bus);

	input[0:8] bus_in;
	output[3:0] timer_bus, stage_bus;
	output[0:5] bus_out; 
	wire[3:0] current_state;
	wire[12:0] current_state_cmd;
	wire[0:1] valves;
	wire cold_override,wash_done,rinse_done,spin_done;
/*	
bus_in=9bit,signal forwarding from wash machine
bus_out=6bit,agitator,spin,pump,alert,cold_valve,hot_valve (IN THAT ORDER)
timer_bus=4bit, timer display
stage_bus=4bit, stage display  
cold_override = wire to signal cold water over ride (for rinse)
wash_done = signal when wash is complete (sent by wash_timer)
valves = open and close signals for the hot and cold valves
rinse_done = signal when rinse is done (sent by rinse_timer)
spin_done = signal when spin is done (sent by spin_timer)
*/
	//valves have to be linked to bus_out[5:6]
	//bus_in forwards cold,warm,hot to valve control
	valve_control(bus_in[3:5],cold_override,valves);
