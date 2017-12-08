`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:32:10 12/07/2017 
// Design Name: 
// Module Name:    Dash_Display_ssd 
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
module Dash_Display_ssd(
    input clk,
	 input reset,
	 input enter,
	 output reg [3:0] AN,
    output [7:0] seven_out
    );

//Initializing some values.
reg [1:0] count = 0; //Initializing the counter to zero.
reg [15:0] allAN = 16'b0111101111011110;
reg [3:0] char_control = 4'b1010; //This will hold the four-bit signal that will generate
								//a dash.

/*
Creating a wire that will carry the signal of the slowed down clock.
*/
wire new_clk;

//Generating the slower clock signal.
clk_divider ChangeClock(.clk_in(clk), .rst(reset), .divided_clk(new_clk));

/*
Creating a wire that will carry the signal from Enter after it
runs through the debouncer. This ensures only a single signal will
be generated when enter is pressed.
*/
wire clean_enter;

//Generating the crisp Enter signal.
debouncer CleanSignal(.clk(new_clk), .rst(reset), .noisy_in(enter), .clean_out(clean_enter));

//Generating dash display.
character_to_segment CharDash(char_control, seven_out);
//Implementing the counter.
// always @(posedge new_clk) begin

always @(posedge clk or posedge reset) begin 

	if (reset) count <= 0;
	else count <= count +1'b1;
	
	case(count)
	0:
		begin
			AN <= allAN[15:12];
		end
	1:
		begin
			AN <= allAN[11:8];
		end
	2:
		begin
			AN <= allAN[7:4];
		end
	3:
		begin
			AN <= allAN[3:0];
		end
	endcase
end

//Adjusting the counter when Enter is pressed.
/*
always @(posedge clean_enter) begin
	if(clean_enter == 1)
		if (count < 3)
			count <= count + 1'b1;
		else
			count <= 0;
end
*/

endmodule
