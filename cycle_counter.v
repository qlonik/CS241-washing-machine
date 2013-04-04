module cycle_counter(next, extra, reset, stage_num);

input next, extra, reset;
output [3:0] stage_num;
reg [3:0] stage_num;

initial
begin
	stage_num = 4'b0000;
end

always @(posedge next or posedge reset)
begin
if (reset)
		stage_num = 4'b0000;
else 
	begin
	if (next)
		stage_num = stage_num + 4'b0001;
	if (~extra && (stage_num == 4'b0111))
		stage_num = 4'b1010;
	if (stage_num == 4'b1101)
		stage_num = 4'b0000;
	end
end


endmodule
