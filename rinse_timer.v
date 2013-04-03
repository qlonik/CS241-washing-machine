module rinse_timer(CLOCK, reset, start, value, pause, active, done);

input CLOCK, reset, start, pause;
output active, done;
output [3:0]value;	// provides the value (max 4 bits) of the
							// current time on the timer – you’ll pass this on to a BCD decoder,
							// and then to a 7-segment display if you want to see the timer count
reg active, done;
reg [3:0]value;
reg enabled;
integer clockedValue;
parameter defaultValue = 5;	// number of time units (seconds) this timer
										// will run
parameter clockHZ = 50000000;	// we assume you’ll use the 50MHz clock feed
										// if not, you’ll adjust this accordingly
initial
	begin
		value = defaultValue;
		enabled = 0;
		clockedValue = 0;
		done = 0;
		active = 0;
	end
	
always @(negedge CLOCK)
	begin
		active = enabled & ~pause;
		if (reset)
		begin
			value = defaultValue;
			enabled = 0;
			clockedValue = 0;
			done = 0;
			active = 0;
		end
		if (enabled & ~pause)
			clockedValue = clockedValue + 1;
		if (clockedValue > clockHZ)
		begin
			value = value - 1;
			clockedValue = 0;
		end
		if (value == 0)
		begin
			enabled = 0;
			done = 1;
		end
		if (start & ~enabled & ~done)
		begin
			done = 0;
			enabled = 1;
			value = defaultValue;
		end
	end
endmodule
