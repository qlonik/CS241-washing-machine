module wash_control(bus_in,bus_out,timer_bus,stage_bus);

	input[0:8] bus_in;
	output[3:0] timer_bus, stage_bus;
	output[0:5] bus_out; 
	wire cold_override,wash_done,rinse_done,spin_done;
/*	
  cold_override = wire to signal cold water over ride (for rinse)
  wash_done = signal when wash is complete (sent by wash_timer)
  rinse_done = signal when rinse is done (sent by rinse_timer)
  spin_done = signal when spin is done (sent by spin_timer)
*/
