module morse_code_letter_length(

	input 	  [2:0] 		SW,
	output reg [3:0] letter,
	output reg [2:0] length
	
);

	parameter A = 3'b000, B = 3'b001, C = 3'b010, D = 3'b011, E = 3'b100, F = 3'b101, G = 3'b110, H = 3'b111;
	
	always@ (*)
		case(SW)
			 A: begin
					letter = 4'b0010; //1 represents dash, 0 represents blink, A -> • — in morse code. Thus has a length of 2, and we read from bit 0 to bit 3, in this case dot -> blink -> finish as length of 2 reached.
					length = 3'b010;
			 end
			 
			 B: begin
					letter = 4'b0001;
					length = 3'b100;
		    end
			 
			 C: begin
					letter = 4'b0101;
					length = 3'b100;
			 end
			 
			 D: begin
					letter = 4'b0001;
					length = 3'b011;
				 end
				 
			 E: begin
					letter = 4'b0000;
					length = 3'b001;
				 end
				 
			 F: begin
					letter = 4'b0100;
					length = 3'b100;
				 end
				 
			 G: begin 	
					letter = 4'b0011;
					length = 3'b011;
				 end
			 
			 H: begin
					letter = 4'b0000;
					length = 3'b100;
				 end
			 
			 default: begin
							letter = 4'bxxxx;
							length = 3'bxxx;
						 end
		endcase
		
endmodule