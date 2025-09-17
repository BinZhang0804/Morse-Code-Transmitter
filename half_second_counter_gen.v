module half_second_counter_gen (
	
	input  	  refclk,
	input       rst_n,
	
	output reg half_second_cnt
	
);
	reg [24:0] cnt;
	always@ (posedge refclk or negedge rst_n) begin
		
		if(rst_n == 0) begin
			cnt <= 25'b0;
			half_second_cnt <= 0;
		end
		
		else begin
			if(cnt == 25000000 - 1) begin
				cnt <= 25'b0;
				half_second_cnt <= 1;
				
			end 
			
			else begin
				cnt <= cnt + 1;
				half_second_cnt <= 0;
			end
		end
	end
	
	
endmodule