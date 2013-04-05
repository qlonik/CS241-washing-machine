module wash_timer(CLOCK, reset, start, value, pause, active, done);

input CLOCK, reset, start, pause;
output active, done;
output [3:0]value;	// provides the value1 (max 4 bits) of the
							// current time on the timer – you’ll pass this on to a BCD decoder,
							// and then to a 7-segment display if you want to see the timer count
reg active, done1;
reg [3:0]value1;
reg enabled;
integer clockedvalue1;
parameter defaultvalue1 = 3;	// number of time units (seconds) this timer
										// will run
parameter clockHZ = 50000000;	// we assume you’ll use the 50MHz clock feed
										// if not, you’ll adjust this accordingly
										
tri_state_buffer(done1,done,active);
tri_state_bus_buffer(value1,value,active);


initial
	begin
		value1 = defaultvalue1;
		enabled = 0;
		clockedvalue1 = 0;
		done1 = 0;
		active = 0;
	end
	
always @(negedge CLOCK)
	begin
		active = enabled & ~pause;
		if (reset)
		begin
			value1 = defaultvalue1;
			enabled = 0;
			clockedvalue1 = 0;
			done1 = 0;
			active = 0;
		end
		if (enabled & ~pause)
			clockedvalue1 = clockedvalue1 + 1;
		if (clockedvalue1 > clockHZ)
		begin
			value1 = value1 - 1;
			clockedvalue1 = 0;
		end
		if (value1 == 0)
		begin
			enabled = 0;
			done1 = 1;
		end
		if (start & ~enabled & ~done1)
		begin
			done1 = 0;
			enabled = 1;
			value1 = defaultvalue1;
		end
	end
endmodule
