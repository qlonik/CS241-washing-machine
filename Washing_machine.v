module Washing_machine(start,clock,reset,cold,warm,hot,extra_rinse,full,empty,
	agitate,spin,pump,alert,cold_valve,hot_valve,timer_digit1,timer_digit2,stage_digit1,stage_digit2);
	
	input start,clock,reset,cold,warm,hot,extra_rinse,full,empty;
	output agitate,spin,pump,alert,cold_valve,hot_valve,timer_digit1,timer_digit2,stage_digit1,stage_digit2;
	
	wire cold_override,wash_done,rinse_done,spin_done,timer_bus,stage_bus;
/*
 * start = start button
 * reset = reset button
 * cold, warm, hot = temp select buttons
 * extra_rinse = extra rinse button
 * full, empty = water level sensors
 * agitate,spin,pump = signals for motors, and pump
 * alert = signal for completion alert 
 * cold_valve, hot_valve = signals for cold and hot water valves
 * timer_digit[1,2] = 14 wires for the timer display
 * stage_digit[1,2] = 14 wires for the stage display
 * cold_override = wire to signal cold water over ride (for rinse)
 * wash_done = signal when wash is complete (sent by wash_timer)
 * rinse_done = signal when rinse is done (sent by rinse_timer)
 * spin_done = signal when spin is done (sent by spin_timer)
 * timer_bus =4 bit signal sent by the active timer containing the 7seg display
 * stage_bus =see timer_bus
 */

endmodule
