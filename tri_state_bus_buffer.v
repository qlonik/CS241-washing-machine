 module tri_state_bus_buffer (a,b,enable);
    input[3:0] a;
    output[3:0] b;
    input enable;
   
    assign b[3] = (enable) ? a[3] : 1'bz,
			 b[2] = (enable) ? a[2] : 1'bz,
			 b[1] = (enable) ? a[1] : 1'bz,
			 b[0] = (enable) ? a[0] : 1'bz;
         	 
 endmodule
