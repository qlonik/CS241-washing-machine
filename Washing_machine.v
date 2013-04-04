module Washing_machine(start,clock,reset,cold,warm,hot,extra_rinse,full,empty,
	agitate,spin,pump,alert,cold_valve,hot_valve,timer_display,stage_display);
	
	input start,clock,reset,cold,warm,hot,extra_rinse,full,empty;
	output agitate,spin,pump,alert,cold_valve,hot_valve,timer_display,stage_display;
	
	wire stage_bus,timer_bus,cold_override,wash_done,rinse_done,spin_done,cntrl_unit_bus_out;
/* MOST OF THE WIRES ACTUALLY BELONG IN THE WASH_CONTROL
 * start = start button
 * reset = reset button
 * cold, warm, hot = temp select buttons
 * extra_rinse = extra rinse button
 * full, empty = water level sensors
 * agitate,spin,pump = signals for motors, and pump
 * alert = signal for completion alert 
 * cold_valve, hot_valve = signals for cold and hot water valves
 * cold_override = wire to signal cold water over ride (for rinse)
 * wash_done = signal when wash is complete (sent by wash_timer)
 * rinse_done = signal when rinse is done (sent by rinse_timer)
 * spin_done = signal when spin is done (sent by spin_timer)
 * timer_bus =4 bit signal sent to BINtoDual7Seg decoder 
 * stage_bus =see timer_bus
 * timer_display = signals sent to 7 seg displays from seg decoder
 * stage_display = signals sent to 7 seg displays from seg decoder
 * cntrl_unit_bus_out = 6 bit bus from the wash_control that is split into outputs.
 */

	//pass the inputs to the wash control in the form of a 9 bit vector
	//accept the two display buses that drive the displays, 
	// all remaining values are in a 6 bit vector.
	//	that is all the engines, alarm, pump, valves.
	wash_control({start,clock,reset,cold,warm,hot,extra_rinse,full,empty},timer_bus,stage_bus,cntrl_unit_bus_out);
	BINtoDual7Seg(timer_bus,timer_display);
	BINtoDual7Seg(stage_bus,stage_display);	
	
	assign
		agitate = cntrl_unit_bus_out[0],
		spin 	= cntrl_unit_bus_out[1],
		pump 	= cntrl_unit_bus_out[2],
		alert	= cntrl_unit_bus_out[3],
		cold_valve=cntrl_unit_bus_out[4],
		hot_valve=cntrl_unit_bus_out[5];

endmodule
