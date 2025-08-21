/////////////CLOCK COUNTERs///////////////////
module counter#(parameter N=26)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic sec,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
   	 if (reset)
   		 q <= 0;
   	 else if (!sec)
   		 q<= q + 1;
   	 else if (add && sec && !alarm)
   	  q<= q + 1;
    
endmodule

module counter_min#(parameter N=8)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic min,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
   	 if (reset)
   		 q <= 0;
   	 else if (!min)
   		 q<= q + 1;
   	 else if (add && min && !alarm)
   	  q<= q + 60;
    
endmodule

module counter_hour#(parameter N=8)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic hour,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
   	 if (reset)
   		 q <= 0;
   	 else if (!hour)
   		 q<= q + 1;
   	 else if (add && hour && !alarm)
   	  q<= q + 60;
    
endmodule

module counter_hour2#(parameter N=8)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic hour,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
   	 if (reset)
   		 q <= 0;
   	 else if (!hour )
   		 q<= q + 1;
   	 else if (add && hour && !alarm)
   	  q<= q + 1;
    
endmodule


/////////////////////ALARM COUNTERS//////////////////////////////////
module alarm_counter#(parameter N=26)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic sec,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
   	 if (reset)
   		 q <= 0;
   	 else if (add && sec && alarm)
   	  q<= q + 10;
endmodule

module alarm_counter_min#(parameter N=8)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic min,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
    if (reset)
   		 q <= 0;
   	 else if (add && min && alarm)
   	  q<= q + 120;
    
endmodule

module alarm_counter_hour#(parameter N=8)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic hour,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
   	 if (reset)
   		 q <= 0;
   	 else if (add && hour && alarm)
   	  q<= q + 1;
    
endmodule

module alarm_counter_hour2#(parameter N=8)
   				 (input logic clk,
   				  input logic reset,
   				  input logic add,
   				  input logic hour,
   				  input logic alarm,
   				  output logic [N-1:0] q);
   				 
    always_ff @(posedge clk or posedge reset)
    if (reset)
   		 q <= 0;
    else if (add && hour && alarm)
   	  q<= q + 1;
endmodule


///////////////COMPARATOR//////////////////////
module comparator#(parameter N=8, parameter b=60)
(input logic [N-1:0]a,output logic gte);

    assign gte = (a >= b);
endmodule

/////////////////SYNC////////////////////////
module sync(input logic clk,
   			 input logic d,
   			 output logic q);
    logic nl;
    
    always_ff@(posedge clk)
   	 begin
   		 nl<= d ;
   		 q <= nl;
   	 end
endmodule

////////////////SEVENSEG/////////////////////////////
module sevenseg(
	input logic [3:0] data,
	input logic [3:0] alarm_data,
	input logic alarm_set,
	output logic [0:6] segments,
	output logic equal
);

	logic [3:0] selected_data;

	// Select between data and data1 based on alarm_set
	always_comb begin
    	if (alarm_set)
        	selected_data = alarm_data;
    	else
        	selected_data = data;
	end

	// Decode selected_data to 7-segment display
	always_comb begin
    	case(selected_data)
        	//                 	abc_defg
        	4'b0000: segments = 7'b000_0001; // 0
        	4'b0001: segments = 7'b100_1111; // 1
        	4'b0010: segments = 7'b001_0010; // 2
        	4'b0011: segments = 7'b000_0110; // 3
        	4'b0100: segments = 7'b100_1100; // 4
        	4'b0101: segments = 7'b010_0100; // 5
        	4'b0110: segments = 7'b010_0000; // 6
        	4'b0111: segments = 7'b000_1111; // 7
        	4'b1000: segments = 7'b000_0000; // 8
        	4'b1001: segments = 7'b000_1100; // 9
        	default: segments = 7'b111_1111; // Blank or error
    	endcase
	end

	// Determine if data and data1 are equal
	always_comb begin
    	equal = (data == alarm_data);
	end

endmodule


////////////////PARSER///////////////
module parser#(parameter N=8)
   			  (input logic [N-1:0] value,  
          	output logic [3:0] ones, tens);

	assign ones = value %10;
     assign tens = (value / 10) % 10;
Endmodule


Do File: 
vsim -gui work.lab5
# Add all signals to the waveform
add wave *

# Force clock and initial input signals
force Clock50MHZ 0 0, 1 10 -r 20
force ResetActiveLow 1, 0 @ 10
force Sec_set 0
force Add_button 0 0, 1 1
force Min_set 0
force Hour_set 0
force ClockOn 1
force AlarmSet 0
force Alarm_enable 1

# Run the simulation for 100000 time units
run 2000

# Set Hours Manually
force Hour_set 1
force Min_set 1
force Sec_set 1
force Add_button 0
run 2000   
# Turn off Hour_set and Add_button
force Hour_set 0
run 1000
# Turn off Min_set and Add_button
force Min_set 0
run 1000

force Sec_set 0
run 1000
#7000

force ResetActiveLow 1
run 100

force ResetActiveLow 0
run 100
# Set Alarm
force AlarmSet 1
force Clock50MHZ 0 0, 1 10 -r 20
force ResetActiveLow 0,
force Hour_set 1
force Min_set 1
force Sec_set 1
force Add_button 0
run 2000  
