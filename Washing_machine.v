module Washing-machine(start,clock,reset,cold,warm,hot,extra_rinse,full,empty,agitate,spin,pump,alert,cold_valve,hot_valve,timer_bus,stage_bus);

	input start,clock,reset,cold,warm,hot,extra_rinse,full,empty;
	output agitate,spin,pump,alert,cold_valve,hot_valve,timer_bus,stage_bus;
	wire cold_override,wash_done,rinse-done,spin_done;
endmodule
