
/*=======================================================
 Morse Code Transmitter for the letters A-H
 A • —
 B — • • •
 C — • — •
 D — • •
 E •
 F • • — •
 G — — •
 H • • • •
 By: Bin (Peter) Zhang
 Date: 2025-09-16
 Board: DE10-Nano
=======================================================*/

module morse_top(

	//////////// CLOCK //////////
	input CLOCK_50,

	//////////// KEY //////////
	input 		     [1:0]		KEY, //Use KEY[0] to start transmission, and KEY[1] as reset_n.

	//////////// LED //////////
	output		     [7:0]		LED, //LED[0] represents the morse code, LED[3:2] is used for debugging FSM, LED[7:5] is used to show the switch state.

	//////////// SW //////////
	input 		     [3:0]		SW
);
	assign LED[7:5] = SW[2:0];

 	//Determining the letter and its length.
	wire [3:0] letter;
	wire [2:0] length;
	morse_code_letter_length u0 (

		.SW	 			(SW	  ),
		.letter			(letter ),
		.length			(length )
	
	);
	
	//Generating a 0.5 counter so we know how long to pulse the LED.
	wire half_second_cnt;
	half_second_counter_gen u1 (
	
		.refclk 			  (CLOCK_50 	   ),
		.half_second_cnt (half_second_cnt),
		.rst_n  	        (KEY[1]         ),
	
	);
	
	//Tells us if the current transmission should be a dash or a dot.
	wire [3:0] dash_or_dot;
	reg shift_register_en;
	shift_register u2(
		
		.CLOCK_50		(CLOCK_50	 ),
		.letter  		(letter  	 ),
		.load    		(~KEY[0] 	 ),
		.enable  		(shift_register_en),
		
		.dash_or_dot (dash_or_dot	 )
		
	);
	
	//-----------------------------------------
	//FSM
	//-----------------------------------------
	parameter START = 2'b00, DOT = 2'b01, DASH = 2'b10, DONE = 2'b11;
	reg [1:0] curr, next;

	reg [2:0] remaining;   // local symbol counter
	reg [2:0] dotdash_timer;
	reg LED_on;
	
	always @(*) begin
		case(curr)
			START: next = (dash_or_dot[0] ? DASH : DOT);
         
			DOT:   next = (remaining == 0) ? DONE :
                       (dash_or_dot[0] ? DASH : DOT);
         
			DASH:  next = (remaining == 0) ? DONE :
                       (dash_or_dot[0] ? DASH : DOT);
         
			DONE:  next = DONE;
			
			default: next = START;
      endcase
	end
	
	always @(posedge CLOCK_50 or negedge KEY[1]) begin
		if(KEY[1] == 0) begin
			curr <= DONE;
         remaining <= 0;
         dotdash_timer <= 0;
         LED_on <= 0;
      end else begin
         curr <= next;

         if(~KEY[0]) begin
				curr <= START;
            remaining <= length;   //Copying length value, so it can be altered.
         end

         if((curr == DOT || curr == DASH) && half_second_cnt) begin
            dotdash_timer <= dotdash_timer + 1;
            LED_on <= 1;

            if((curr == DOT  && dotdash_timer == 1) || (curr == DASH && dotdash_timer == 3)) begin
				   shift_register_en <= 1;
               dotdash_timer <= 0;
               LED_on <= 0;
               remaining <= remaining - 1;
            end 
				
				else begin
					shift_register_en <= 0;
			   end
         end
			else begin
				shift_register_en <= 0;
			end
      end
	end

	assign LED[0] = LED_on;
   assign LED[3:2] = curr; //Used for debugging FSM, shows the current state of the FSM.
	
endmodule


