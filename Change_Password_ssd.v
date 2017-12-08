`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    23:14:37 12/07/2017 
// Design Name: 
// Module Name:    Change_Password_ssd 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Change_Password_ssd(
    input clk,
    input [3:0] switch_test,
	 input reset,
	 input enter,
	 output reg [3:0] AN,
    output [7:0] seven_out
	 );
	 
//Initializing some values.
reg [4:0] seven_in; //Temporarily holds the 5-bit binary input from switches.
reg [4:0] empty_in;
reg [1:0] count = 0; //Initializing the counter for main display to zero.
reg [1:0] count_enter = 0; //Initializing the counter for the register loading.
reg [19:0] bit_storage;
reg [19:0] ctrl_display = 20'b11111111111111111111;
reg [15:0] allAN = 16'b0111101111011110;

/*
Creating a wire that will carry the signal of the slowed down clock.
*/
//wire new_clk;

//Generating the slower clock signal.
//clk_divider ChangeClock(.clk_in(clk), .rst(reset), .divided_clk(new_clk));

/*
Creating a wire that will carry the signal from Enter after it
runs through the debouncer. This ensures only a single signal will
be generated when enter is pressed.
*/
wire clean_enter;

//Generating the crisp Enter signal.
debouncer CleanSignal(.clk(clk), .rst(reset), .noisy_in(enter), .clean_out(clean_enter));

//Linking the binary input from the switches to the corresponding ssd pattern.
binary_to_segment disp0(seven_in, seven_out);
//binary_to_segment empty(empty_in, seven_out);

//Implementing the counter.
always @(posedge clk or posedge reset) begin

	if (reset) count <= 0;
	else count <= count + 1'b1;
	
	case(count)
	0:
		begin
			AN <= allAN[15:12];
			seven_in <= bit_storage[19:15];
		end
	1:
		begin
			AN <= allAN[11:8];
			seven_in <= bit_storage[14:10];
		end
	2:
		begin
			AN <= allAN[7:4];
			seven_in <= bit_storage[9:5];
		end
	3:
		begin
			AN <= allAN[3:0];
			seven_in <= bit_storage[4:0];
		end
	endcase
end

//Adjusting the counter when Enter is pressed.
always @(posedge clean_enter or posedge reset) begin
	//Initial conditions for always block.
	if(clean_enter == 1)
		if (count_enter < 3)
			count_enter <= count_enter + 1'b1;
		else if (count_enter == 3 || reset == 1)
			count_enter <= 0;
	//Setting up a counter to load the switch register.
	case(count_enter)
	0:
		begin
		bit_storage[19:15] <= switch_test;
		end
	1:
		begin
		bit_storage[14:10] <= switch_test;
		end
	2:
		begin
		bit_storage[9:5] <= switch_test;
		end
	3:
		begin
		bit_storage[4:0] <= switch_test;
		end
	endcase
end

//Implementing the counter.
/*
always @(posedge clk or posedge reset) begin

	if (reset) count <= 0;
	else count <= count +1'b1;
	
	case(count)
	0:
		begin
			AN <= allAN[15:12];
			empty_in <= ctrl_display[19:15];
		end
	1:
		begin
			AN <= allAN[11:8];
			empty_in <= ctrl_display[14:10];
		end
	2:
		begin
			AN <= allAN[7:4];
			empty_in <= ctrl_display[9:5];
		end
	3:
		begin
			AN <= allAN[3:0];
			empty_in <= ctrl_display[4:0];
		end
	endcase
end
*/

endmodule
