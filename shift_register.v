module shift_register(
	input 			CLOCK_50,
	input 				 load,
	input   		 	  enable,
	input      [3:0] letter,
	
	output reg [3:0] dash_or_dot
);
	
	always@ (posedge CLOCK_50) begin
		
		if(load == 1)
			dash_or_dot <= letter;
		
		else if(enable == 1) begin
		
			dash_or_dot[3] <= 1'b0;
			dash_or_dot[2] <= dash_or_dot[3];
			dash_or_dot[1] <= dash_or_dot[2];
			dash_or_dot[0] <= dash_or_dot[1]; //We would really care only about dash_or_dot[0] value, as it tells us if the current transmission should be a dash or dot.

		end
	end
	
endmodule