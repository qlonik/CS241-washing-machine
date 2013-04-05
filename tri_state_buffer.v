// tri-state buffer

 module tri_buf (a,b,enable);
    input a;
    output b;
    input enable;
    wire a,enable;
    wire b;
   
    assign b = (enable) ? a : 1'bz;
         	 
 endmodule
